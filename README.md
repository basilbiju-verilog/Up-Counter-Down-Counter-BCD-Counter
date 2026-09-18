# Up Counter, Down Counter & BCD Counter

Three 4-bit counter designs — **Up Counter**, **Down Counter**, and
**BCD (Modulo-10) Counter** — all edge-triggered with synchronous reset.
Implemented in Verilog HDL and verified on Artix-7 FPGA.

---

## What is a Counter?

A counter is a sequential circuit that increments or decrements
its value on every rising clock edge.

```
UP   COUNTER → 0 → 1 → 2 → 3 → ... → 15 → 0 (wraps)
DOWN COUNTER → 15 → 14 → 13 → ... → 0 → 15 (wraps)
BCD  COUNTER → 0 → 1 → 2 → ... → 9 → 0 (resets at 10)
```

---

## — 4-bit Up Counter
<img width="1060" height="510" alt="Screenshot 2026-09-18 193710" src="https://github.com/user-attachments/assets/c98bda1b-4e1b-4bcd-a4d0-af105c33ab01" />

### How It Works
```verilog
always @(posedge clk) begin
    if (rst)
        count <= 4'b0000;   // reset to 0
    else
        count <= count + 1; // increment every clock
end
```

### Count Sequence
```
Clock →  0  1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16
Count →  0  1  2  3  4  5  6  7  8  9  10  11  12  13  14  15   0
                                                                  ^ wraps back
```

### Waveform
```
CLK    → _/‾\_/‾\_/‾\_/‾\_/‾\_/‾\_/‾\_/‾\
RST    → 1   0   0   0   0   0   0   0
────────────────────────────────────────────
Q[3]   → 0   0   0   0   0   0   0   0  (MSB)
Q[2]   → 0   0   0   0   0   0   0   0
Q[1]   → 0   0   0   1   1   1   1   0
Q[0]   → 0   1   0   1   0   1   0   1  (LSB)
COUNT  → 0   1   2   3   4   5   6   7
         ^rst ^counting up
```
<img width="982" height="338" alt="Screenshot 2026-09-18 193437" src="https://github.com/user-attachments/assets/321ba5de-206f-43de-8d54-e915ad2c135c" />

---

##  — 4-bit Down Counter
<img width="1572" height="910" alt="Screenshot 2026-09-18 195318" src="https://github.com/user-attachments/assets/28e7cc3b-0257-48cb-a8c1-7a4a49daa64b" />

### How It Works
```verilog
always @(posedge clk) begin
    if (rst)
        count <= 4'b1111;   // reset to 15
    else
        count <= count - 1; // decrement every clock
end
```

### Count Sequence
```
Clock →  0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16
Count → 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0  15
                                                                         ^ wraps back
```

### Waveform
```
CLK    → _/‾\_/‾\_/‾\_/‾\_/‾\_/‾\_/‾\_/‾\
RST    → 1   0   0   0   0   0   0   0
────────────────────────────────────────────
Q[3]   → 0   1   1   1   1   1   1   1  (MSB)
Q[2]   → 0   1   1   1   1   0   0   0
Q[1]   → 0   1   1   0   0   1   1   0
Q[0]   → 0   1   0   1   0   1   0   1  (LSB)
COUNT  → 0  15  14  13  12  11  10   9
         ^rst ^counting down from 15
```
<img width="950" height="463" alt="Screenshot 2026-09-18 194707" src="https://github.com/user-attachments/assets/3a6f4f98-1813-40f8-992a-acb9b0be334b" />

---

## — BCD Counter (Modulo-10)
<img width="1549" height="455" alt="Screenshot 2026-09-18 201501" src="https://github.com/user-attachments/assets/056ad75f-dfc5-4b24-b9f8-bac47d439f8c" />

### How It Works
```verilog
always @(posedge clk) begin
    if (rst)
        count <= 4'b0000;        // reset to 0
    else if (count == 4'd9)
        count <= 4'b0000;        // reset at 9 — never reaches 10
    else
        count <= count + 1;      // increment normally
end
```

### Count Sequence
```
Clock →  0  1  2  3  4  5  6  7  8  9  10  11  12
Count →  0  1  2  3  4  5  6  7  8  9   0   1   2
                                         ^ resets here — never goes to 10
```

### Waveform
```
CLK    → _/‾\_/‾\_/‾\_/‾\_/‾\_/‾\_/‾\_/‾\_/‾\_/‾\
RST    → 1   0   0   0   0   0   0   0   0   0
────────────────────────────────────────────────────
COUNT  → 0   1   2   3   4   5   6   7   8   9   0
                                                  ^ jumps back to 0
                                                    skips 10,11,12,13,14,15
```
<img width="874" height="573" alt="Screenshot 2026-09-18 201020" src="https://github.com/user-attachments/assets/4e163fc1-14b8-4cfb-97d0-f5407377a330" />

---

## All Three Counters — Side by Side

| Feature | Up Counter | Down Counter | BCD Counter |
|---------|-----------|--------------|-------------|
| Count direction | 0 → 15 | 15 → 0 | 0 → 9 |
| Reset value | 0 | 15 | 0 |
| Wraps at | 15 → 0 | 0 → 15 | 9 → 0 |
| Max value | 15 | 15 | 9 |
| Total states | 16 | 16 | 10 |
| Operation | `count + 1` | `count - 1` | `count + 1` with reset at 9 |
| Use case | General timing | Countdown timer | Decimal display |

---

## Key Verilog Difference Between All Three

```verilog
// UP COUNTER — just add 1
count <= count + 1;

// DOWN COUNTER — just subtract 1
count <= count - 1;

// BCD COUNTER — add 1 but force reset at 9
if (count == 4'd9)
    count <= 4'b0000;  // <- this one extra line makes it BCD
else
    count <= count + 1;
```

---

## Files

| File | Description |
|------|-------------|
| `counter_4bit.v` | Up counter RTL source |
| `counter_4bit_tb.v` | Up counter testbench |
| `counter_4bit.xdc` | Constraints — Cmod A7-35T |
| `counter_4bit_down.v` | Down counter RTL source |
| `counter_4bit_down_tb.v` | Down counter testbench |
| `counter_4bit_down.xdc` | Constraints — Cmod A7-35T |
| `mod10_bcd_counter.v` | BCD counter RTL source |
| `mod10_bcd_counter_tb.v` | BCD counter testbench |
| `mod10_bcd_counter.xdc` | Constraints — Cmod A7-35T |

---

## Real World Uses

| Counter | Application | Why |
|---------|-------------|-----|
| Up Counter | Stopwatch, address generator | Count events forward |
| Down Counter | Countdown timer, PWM period | Count events backward |
| BCD Counter | 7-segment display driver | Shows 0–9 on display |
| BCD Counter | Digital clock (seconds/minutes) | Wraps at 9 like real digits |

---

## What to Verify in Your Waveform

```
UP COUNTER
  → After reset, count must start from 0
  → Must reach 15 then wrap to 0

DOWN COUNTER
  → After reset, count must start from 15
  → Must reach 0 then wrap to 15

BCD COUNTER  ← most important check
  → Count must go 0,1,2,3,4,5,6,7,8,9,0,1...
  → Must NEVER show 10,11,12,13,14 or 15
  → The jump from 9 back to 0 is your proof
```

---

## Board

- **Device:** Digilent Cmod A7-35T (Artix-7 XC7A35T)
- **Tool:** Xilinx Vivado 2024
- **I/O:** LVCMOS33

---
