# Mips 5 Stage Pipelined Processor

## Design

<img src="arch_img.png" center>
you can check the design here<a href="Design.pdf"> Design</a>

<br>
<br>

## Description

### This is a MIPS 5 stage pipelined processor, which comes with an assembler to interpret instructions to supported OP codes.

### This architecture deals with Data hazards and Control Hazards

### We use Full Data Forwarding

### We handled the Load Use Case

### Architure supports R1-R7 with PC, SP

<br>
<br>

## IR format

<br>
<table border="1" style="text-align:center">
<tr>
<th  style="text-align:center">Instruction Type</th>
<th  style="text-align:center">mmediate or register</th>
<th  style="text-align:center">code</th>
<th  style="text-align:center">Rdest</th>
<th  style="text-align:center">Rsrc</th>
<th  style="text-align:center">Offset / Immediate value</th>
</tr>

<tr>
<td>31-30 <br> (2 bits)</td>
<td>29 <br> (1 bit)</td>
<td> 28-24 <br> (5 bits) </td>
<td>23-20 <br> (4 bits)</td>
<td> 19-16 <br> (4 bits) </td>
<td> 15-0 <br> (16 bits) </td>
</tr>
</table>

<br><br>

## General components of an instruction opcode

<br>
<table border="1" style="text-align:center">
<tr>
<td>0-operand or 1-operand </td>
<td>2-operands</td>
<td>Memory</td>
<td>Change of control</td>
</tr>

<tr>
<td>00</td>
<td>01</td>
<td>10</td>
<td>11</td>
</tr>
</table>

<br><br>

## Supported instructions

<br>

<table border="1" style="text-align:center;width:100%">
<tr style="text-align:center">
<th  style="text-align:center">NO OP</th>
<th  style="text-align:center">One OP</th>
<th  style="text-align:center">Two OP</th>
<th  style="text-align:center">Memory</th>
</tr>

<tr>
<td>NOP</td>
<td>CLR</td>
<td>MOV</td>
<td>PUSH</td>
</tr>

<tr>
<td>SETC</td>
<td>NOT</td>
<td>ADD</td>
<td>POP</td>
</tr>

<tr>
<td>CLRC</td>
<td>INC</td>
<td>SUB</td>
<td>LDD</td>
</tr>

<tr>
<td></td>
<td>NEG</td>
<td>AND</td>
<td>STD</td>
</tr>

<tr>
<td></td>
<td>DEC</td>
<td>OR</td>
<td></td>
</tr>

<tr>
<td></td>
<td>OUT</td>
<td>IADD</td>
<td></td>
</tr>

<tr>
<td></td>
<td>IN</td>
<td>SHL</td>
<td></td>
</tr>

<tr>
<td></td>
<td>RLC</td>
<td>SHR</td>
<td></td>
</tr>

<tr>
<td></td>
<td>RRC</td>
<td>LDM</td>
<td></td>
</tr>

</table>
