#!/usr/bin/env bash
set -uo pipefail

CPU_SECS=${DIAG_CPU_SECS:-120}
MEM_SECS=${DIAG_MEM_SECS:-120}
TOTAL=7

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

PASSES=0
FAILS=0
WARNS=0
FAIL_MSGS=()
PHASE_RESULTS=()

pass() { echo -e "  ${GREEN}✓ $1${NC}"; ((PASSES++)); }
fail() { echo -e "  ${RED}✗ $1${NC}"; ((FAILS++)); FAIL_MSGS+=("$1"); }
warn() { echo -e "  ${YELLOW}! $1${NC}"; ((WARNS++)); }
info() { echo -e "  ${BLUE}· $1${NC}"; }

phase_header() {
    local num="$1" name="$2"
    echo ""
    echo -e "${BOLD}${CYAN}[$num/$TOTAL]${NC} ${BOLD}$name${NC}  ${DIM}(✓${PASSES} ✗${FAILS} !${WARNS})${NC}"
}

phase_done() {
    local name="$1"
    if [ "$FAILS" -gt "${2:-0}" ]; then
        PHASE_RESULTS+=("${RED}✗${NC} $name")
    elif [ "$WARNS" -gt "${3:-0}" ]; then
        PHASE_RESULTS+=("${YELLOW}!${NC} $name")
    else
        PHASE_RESULTS+=("${GREEN}✓${NC} $name")
    fi
}

START_TIME=$(date +%s)

get_max_temp() {
    sensors -u 2>/dev/null \
        | awk '/temp[0-9]+_input:/ { v=$2+0; if (v > 0 && v < 200 && v > max) max=v } END { if (max > 0) printf "%.1f", max }'
}

trap 'echo ""; echo "Interrupted."; exit 1' INT

# ── Banner ──

clear
echo -e "${BOLD}"
echo "┌──────────────────────────────────────────────┐"
echo "│         NixOS Hardware Diagnostics           │"
printf "│         %-37s│\n" "$(date '+%Y-%m-%d %H:%M:%S')"
printf "│         CPU: %-5s  Memory: %-16s│\n" "${CPU_SECS}s" "${MEM_SECS}s"
echo "└──────────────────────────────────────────────┘"
echo -e "${NC}"

# ── Phase 1: System Inventory ──

f_before=$FAILS w_before=$WARNS
phase_header 1 "SYSTEM INVENTORY"

cpu_model=$(lscpu 2>/dev/null | grep 'Model name' | sed 's/.*:\s*//')
info "CPU: ${cpu_model} ($(nproc) cores)"

mem_total=$(free -h | awk '/Mem:/{print $2}')
info "Memory: ${mem_total}"

mobo=$(dmidecode -t baseboard 2>/dev/null | grep -E 'Manufacturer|Product Name' | sed 's/^\s*//' | paste -sd ', ')
[ -n "$mobo" ] && info "Board: ${mobo}"

serial=$(dmidecode -t system 2>/dev/null | grep 'Serial Number' | head -1 | sed 's/.*:\s*//')
[ -n "$serial" ] && [ "$serial" != "Not Specified" ] && info "Serial: ${serial}"

bios=$(dmidecode -t bios 2>/dev/null | grep -E 'Vendor|Version|Release Date' | sed 's/^\s*//' | paste -sd ', ')
[ -n "$bios" ] && info "BIOS: ${bios}"

info "Disks:"
lsblk -dno NAME,SIZE,MODEL 2>/dev/null | grep -v '^loop' | while IFS= read -r line; do
    info "  ${line}"
done

gpus=$(lspci 2>/dev/null | grep -iE 'vga|3d|display' | sed 's/.*: //')
if [ -n "$gpus" ]; then
    info "GPU:"
    while IFS= read -r gpu; do info "  ${gpu}"; done <<< "$gpus"
fi

info "Network:"
ip -br link 2>/dev/null | grep -v '^lo' | while IFS= read -r line; do
    info "  ${line}"
done

phase_done "Inventory" "$f_before" "$w_before"

# ── Phase 2: SMART Disk Health ──

f_before=$FAILS w_before=$WARNS
phase_header 2 "DISK HEALTH (SMART)"

mapfile -t DISKS < <(lsblk -dno NAME,TYPE 2>/dev/null | awk '$2=="disk"{print "/dev/"$1}')

if [ ${#DISKS[@]} -eq 0 ]; then
    warn "No disks found"
else
    for disk in "${DISKS[@]}"; do
        dname=$(basename "$disk")

        if ! smartctl -i "$disk" &>/dev/null; then
            warn "${dname}: SMART not supported"
            continue
        fi

        health=$(smartctl -H "$disk" 2>/dev/null | grep -iE 'overall-health|result' | tail -1)
        if echo "$health" | grep -qi 'passed\|ok'; then
            pass "${dname}: SMART health OK"
        else
            fail "${dname}: SMART health FAILED"
        fi

        realloc=$(smartctl -A "$disk" 2>/dev/null | grep -i 'Reallocated_Sector' | awk '{print $NF}')
        if [ -n "$realloc" ] && [ "$realloc" -gt 0 ] 2>/dev/null; then
            warn "${dname}: ${realloc} reallocated sectors"
        fi

        if smartctl -i "$disk" 2>/dev/null | grep -qi nvme; then
            pct=$(smartctl -A "$disk" 2>/dev/null | grep 'Percentage Used' | awk '{print $NF}' | tr -d '%')
            if [ -n "$pct" ]; then
                if [ "$pct" -gt 90 ] 2>/dev/null; then
                    warn "${dname}: NVMe ${pct}% life used"
                else
                    info "${dname}: NVMe ${pct}% life used"
                fi
            fi
        fi

        temp=$(smartctl -A "$disk" 2>/dev/null | grep -i 'Temperature' | head -1 | grep -oP '[0-9]+' | tail -1)
        [ -n "$temp" ] && info "${dname}: ${temp}°C"
    done
fi

phase_done "SMART" "$f_before" "$w_before"

# ── Pre-stress dmesg baseline ──

DMESG_BASELINE=$(dmesg 2>/dev/null | wc -l)

# ── Phase 3: CPU Stress Test ──

f_before=$FAILS w_before=$WARNS
phase_header 3 "CPU STRESS TEST (${CPU_SECS}s)"

temp_before=$(get_max_temp)
[ -n "$temp_before" ] && info "Temperature before: ${temp_before}°C"

info "Stressing $(nproc) cores for ${CPU_SECS}s..."
if stress-ng --cpu 0 --cpu-method matrixprod --timeout "${CPU_SECS}s" --metrics-brief 2>&1; then
    pass "CPU stress test completed without errors"
else
    fail "CPU stress test exited with errors"
fi

temp_after=$(get_max_temp)
[ -n "$temp_after" ] && info "Temperature after: ${temp_after}°C"

throttle_msgs=$(dmesg 2>/dev/null | tail -n +"${DMESG_BASELINE}" | grep -ci 'throttl\|mce\|machine.check\|hardware.error' || true)
if [ "$throttle_msgs" -gt 0 ]; then
    fail "Thermal throttling or hardware errors during CPU test"
else
    pass "No throttling or hardware errors during CPU test"
fi

phase_done "CPU stress" "$f_before" "$w_before"

# ── Phase 4: Memory Stress Test ──

f_before=$FAILS w_before=$WARNS
phase_header 4 "MEMORY STRESS TEST (${MEM_SECS}s)"

total_mb=$(free -m | awk '/Mem:/{print $2}')
workers=$(nproc)
per_worker_mb=$(( total_mb * 80 / 100 / workers ))
test_total_mb=$(( per_worker_mb * workers ))

info "Testing ${test_total_mb}MB across ${workers} workers (${per_worker_mb}MB each)"

dmesg_pre_mem=$(dmesg 2>/dev/null | wc -l)

if stress-ng --vm "$workers" --vm-bytes "${per_worker_mb}M" --verify --timeout "${MEM_SECS}s" --metrics-brief 2>&1; then
    pass "Memory stress test completed without errors"
else
    fail "Memory stress test exited with errors"
fi

mem_errors=$(dmesg 2>/dev/null | tail -n +"${dmesg_pre_mem}" | grep -ci 'memory\|ecc\|edac\|oom\|bad.page\|mce' || true)
if [ "$mem_errors" -gt 0 ]; then
    fail "Memory-related errors detected in kernel log"
else
    pass "No memory errors in kernel log"
fi

phase_done "Memory stress" "$f_before" "$w_before"

# ── Phase 5: Disk Read Performance ──

f_before=$FAILS w_before=$WARNS
phase_header 5 "DISK PERFORMANCE"

for disk in "${DISKS[@]}"; do
    dname=$(basename "$disk")
    speed=$(hdparm -t "$disk" 2>/dev/null | grep 'Timing' | sed 's/.*= *//')
    if [ -n "$speed" ]; then
        info "${dname}: ${speed}"
    else
        info "${dname}: could not measure read speed"
    fi
done

phase_done "Disk perf" "$f_before" "$w_before"

# ── Phase 6: Temperature Readings ──

f_before=$FAILS w_before=$WARNS
phase_header 6 "TEMPERATURE READINGS"

if sensors &>/dev/null; then
    sensors 2>/dev/null | grep -E '°C' | while IFS= read -r line; do
        info "$line"
    done

    max_temp=$(get_max_temp)
    if [ -n "$max_temp" ]; then
        max_int=${max_temp%.*}
        if [ "$max_int" -gt 95 ] 2>/dev/null; then
            fail "Max temperature ${max_temp}°C exceeds 95°C"
        elif [ "$max_int" -gt 85 ] 2>/dev/null; then
            warn "Max temperature ${max_temp}°C is elevated (>85°C)"
        else
            pass "Max temperature ${max_temp}°C is within safe range"
        fi
    fi
else
    warn "No temperature sensors detected"
fi

phase_done "Temperatures" "$f_before" "$w_before"

# ── Phase 7: Final Kernel Log Check ──

f_before=$FAILS w_before=$WARNS
phase_header 7 "KERNEL LOG CHECK"

hw_errors=$(dmesg 2>/dev/null | grep -ci 'hardware.error\|mce\|machine.check\|panic\|fatal' || true)
if [ "$hw_errors" -gt 0 ]; then
    fail "${hw_errors} critical hardware error(s) in kernel log"
    dmesg 2>/dev/null | grep -i 'hardware.error\|mce\|machine.check\|panic\|fatal' | tail -5 | while IFS= read -r line; do
        info "  ${line}"
    done
else
    pass "No critical hardware errors in kernel log"
fi

io_errors=$(dmesg 2>/dev/null | grep -ci 'I/O.error\|blk_update_request' || true)
if [ "$io_errors" -gt 0 ]; then
    fail "${io_errors} I/O error(s) in kernel log"
else
    pass "No I/O errors in kernel log"
fi

phase_done "Kernel log" "$f_before" "$w_before"

# ── Summary ──

end_time=$(date +%s)
elapsed=$(( end_time - START_TIME ))
mins=$(( elapsed / 60 ))
secs=$(( elapsed % 60 ))

echo ""
echo -e "${BOLD}══════════════════════════════════════════════${NC}"
echo ""
for r in "${PHASE_RESULTS[@]}"; do
    echo -e "  $r"
done
echo ""
echo -e "  ${GREEN}Passed:   ${PASSES}${NC}"
echo -e "  ${RED}Failed:   ${FAILS}${NC}"
echo -e "  ${YELLOW}Warnings: ${WARNS}${NC}"
echo -e "  Duration: ${mins}m ${secs}s"
echo ""

if [ "$FAILS" -eq 0 ]; then
    echo -e "${GREEN}${BOLD}"
    echo "  ╔═══════════════════════════════╗"
    echo "  ║       ALL TESTS PASSED        ║"
    echo "  ╚═══════════════════════════════╝"
    echo -e "${NC}"
else
    echo -e "${RED}${BOLD}"
    echo "  ╔═══════════════════════════════╗"
    echo "  ║      FAILURES DETECTED        ║"
    echo "  ╚═══════════════════════════════╝"
    echo -e "${NC}"
    for msg in "${FAIL_MSGS[@]}"; do
        echo -e "    ${RED}- ${msg}${NC}"
    done
    echo ""
fi

