# SAP-1-VHDL
Simple-As-Posible computer written in VHDL for Nexys4 DDR development board, based on Albert Malvino's design.

## Overview
The original desing proposed by Albert Malvino, Ph.D can be found in his book Digital Computer Electronics. SAP-1 has 8-bit data bus and 4-bit address bus shared with the less significant nibble of data bus. I've made little modifications in order to avoid unnecesary complexity regard to hardware restrictions in original design.

## Features
* 8-bit data bus
* 4-bit address bus shared with LSN of data
* 4-bit opcode (only 5 are used)
* 6 T states (machine cycles)
* 16-Bytes of Program/Data Memory
* 2 Registers
* Binary display

## Modifications
* All control signals are ACTIVE HIGH
* Improved debounce circuit for push button inputs
* Binary led display MUX-ed for RUN and PROG modes
