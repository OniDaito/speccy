# Machine Code commands

Taken from 'Mastering Machine Code on your ZX Spectrum'

#TODO - we've missed ADD

## BIT
The form of this instruction is BIT n,r where n is a number between zero and seven. The instruction alters the zero flag (only) according to the current value of the bit in question. If the bit is zero then the zero flag will be set, otherwise the zero flag will be reset. You can exploit this using instructions like JR Z (which will jump if the bit was zero) or RET NZ (which
will return if the bit was non-zero). BIT does not alter the value of any of the registers, nor does it change the value of the carry flag. It is a two byte instruction. I tend to find it‟s not used all that often, but that when it is used it comes in very handy indeed.

## CALL
You‟ve seen this one before – it‟s rather like GO SUB. Its exact function is as follows: PUSH the return address onto the stack, and then jump to the call address. Since the return address (now on the stack) is used by the instruction RET, it is vitally important that a subroutine should not alter the stack. You may only PUSH things onto the stack in a subroutine if you POP them off again before you attempt to return. CALL may also be used with conditions – for example, CALL Z,pq (pq is an absolute address) which means IF the zero flag is set then CALL pq, otherwise continue with the next instruction.

## CCF 
Complement Carry Flag. If the carry flag was zero then set it to one. If it was one then reset it to zero.

## CP 
In the form CP r, it will calculate the result of subtracting r from A, but will not store the result anywhere. The previous value of A (and, of course, r) remains unaltered. It will, on the other hand, alter all of the flags, so conditional instructions like JP Z or JP C will still work. CP r followed by JR Z will jump if A equals r (since A minus r is zero) and so on.

## CPD
Imagine this as CP (HL) followed by DEC HL followed by DEC BC. The PV flag is reset if BC decrements to zero and set otherwise. The zero flag is set if CP part of the instruction found that A was equal to (HL), otherwise it is reset.

## CPDR
Basically this is the same as CPD except that the instruction is executed over and over again – a kind of automatic loop if you like. CPDR stands for ComPare with Decrement and Repeat. The loop will end in one of two cases: (i) either the comparison found A equal to (HL) (ie if now A =
(HL + 1)) and the zero flag is set, or (ii) BC reaches zero, in which case thePV flag is reset.

## CPI
As CPD, except that HL is incremented instead of decremented.

## CPIR
As CPDR, except that HL is incremented instead of decremented.

## CPL
An abbreviation for ComPLement. The register A is altered bit by bit. If any particular bit starts off as zero then it is changed to one and vice versa. In other words, if A started off as 11010101 (binary) then CPL would change it to 00101010 (binary). This is equivalent to subtracting A from FF. The flags are not affected by this instruction.

## DAA
Suppose you wanted to add sixteen to twenty-six without converting the numbers to hex. The following seems plausible: LD A,16 then ADD A,26. Unfortunately, because the machine works in hex the final value of A will be 3C not 42. The instruction DAA (Decimal Adjust Accumulator) will then change A from 3C to 42. How it works is rather complicated – it makes a note of what‟s been carried where and whether you‟ve added or subtracted and so on; but it does always work. For instance, the sequence LD A,42 then SUB 06 will again leave A with 3C, but this time round DAA will change A to 36, since forty-two minus six is thirty-six. The instruction changes every flag appropriately.

## DEC
This is another one of those instructions which comes in two forms. It can be DEC r (a single register) or DEC s (a register pair). DEC r is very simple to understand – the value of the register r is decremented (decreased by one, or changed from 00 to FF), the carry flag is unaltered and the zero flag is changed as you‟d expect it to be. DEC s, however, is a sneaky little instruction, for the zero flag is not altered! In fact, none of the flags at all are changed! Thus DEC BC/JR NZ, –3 is either an infinite loop or has no effect! You must be very careful to remember this – a lot of my earlier programs crashed because I didn‟t!

## DEFB
Technically speaking this isn‟t really a machine code instruction – it‟s what‟s called a directive. The word DEFB must be followed by one or more bytes of data, each separated by a comma. Usually this data is in hex, but this isn‟t always necessary, eg DEFB 3A,C1,45d,11011110b,”f”,yellow is valid. The data is inserted into the machine code program at the point it occurs, and in the order it‟s listed. Data which forms part of a machine code program should never be executed, since the Z80 cannot distinguish between data and program.

## DEFM
Similar to DEFB except that the data which follows the word DEFM must be a string of characters (not surrounded by quotes). Commas in the text will themselves be interpreted as data, not as separators. For instance, DEFM SOLSTICE will cause the bytes 53 4F 4C 53 54 49 43 45to be inserted into the program. Control characters may also be insertedinto a DEFM directive provided they are made distinguishable fromordinary symbols (eg if they are underlined or in italics). DEFM HELLOenter THERE and DEFM ink blue WHAT? are both valid, although someconvention must be established about spaces around the control word(s). Itend to write spaces in for clarity so that I would write DEFM X enter tomean 58 0D, and DEFM X space enter to mean 58 20 0D. DEFM standsfor DEFine Message, as opposed to DEFB which means DEFine Byte(s).DEFS Yet another of those directives. This one means DEFine Space(s).The word DEFS should be followed by one numerical constant. (Just one,mind.) The given number instructs the computer to insert that number ofrubbish characters. So, DEFS 08 will insert eight bytes into the program atthat point, but without really worrying about what those bytes actually are.DEFS is used mainly to define “variables” in RAM; eg FRED DEFS 02(FRED is a label) and then at some later point in the program LD(FRED),HL.

## DEFW
One last directive (for now). DEFW stands for DEFine Word. It isused in a very similar way to DEFB except that the items of data are twobytes long, not one, so that (for instance) DEFW 4000 is equivalent to DEFB 00,40. Note how the bytes are switched around. Labels andexpressions are permitted in DEFW, so DEFW 7000, FRED,ERIC + 3 isquite valid.

## DI
Not a Welsh name, nor is it short for Diane or Diana. It is, in fact, an abbreviation (surprise, surprise). It stands for Disable Interrupts and,although this sounds pretty confusing, its use is immensely simple. Fiftytimes a second a little pulse is sent down one of the pins of the Z80 chip.There is a flag called IFF1 which stands for Interrupt Flip Flop One (no, Ididn‟t make that up!), and the effect of DI can be thought of as RES IFF1.When the Z80 receives one of these pulses it checks the value of the flagIFF1. If it is set then the computer acts as if a RST 38 instruction (or CALL0038) has just been reached, with the return address being the nextinstruction in sequence. If IFF1 is reset however, then no action is takenand any machine code program will run as normal. The flag IFF1 must beset before any attempt is made to return to BASIC otherwise the Spectrumwill not register any key being pressed.

## DJNZ
Yet another abbreviation. This one stands for Decrement B and Jump if Not Zero. So if B is 7, DJNZ will reduce it to 6 and then jump to a new destination. If B is zero, DJNZ will reduce it to FF and again jump to anew destination. If B is one, however, then DJNZ will change it to zero andwill not jump to a new destination. Instead, it will simply carry on with thenext instruction. The form of the instruction is DJNZ e, where e is a single byte. If B is decremented to zero then the e is ignored. If not, then the especifies how far to jump. The displacement calculated is as in JR.

## EI
Guess what? Another abbreviation. EI stands for Enable Interrupts and is the opposite of DI. This instruction is equivalent to SET IFF1. See DI for a more complete explanation.

## EQU
Short for EQUate. This is not a machine code instruction, but a directive. Each EQU directive must have a label attached to it, and the word EQU must be followed by a number (in the range 0000 to FFFF) or an expression such as ERIC + 2. When this directive is reached no action is taken, and no bytes are inserted into the program – therefore, it doesn‟t really matter whereabouts in the program an EQU appears although it is conventional to place all EQU directives at the very start of a program. What it does is to assign a numerical value (the one given) to the label attached. In other words, if you have ANNIE EQU 9000 and then at some later stage LD HL,(ANNIE), then the instruction will be compiled as LD HL,(9000).

## EX 
Short for exchange. This instruction will swap the values contained by certain register pairs. There are five EX instructions – these are EX AF,AF‟; EX DE, HL; EX (SP), HL; EX (SP),IX; and EX (SP),IY. They don‟t alter any of the flags, all they do is swap the values over – thus, EX DE,HL replaces DE by the value HL used to contain and HL by the value DE used to contain. The last three are rather interesting – the old value of HL (or IX or IY) is swapped with the topmost item on the stack, so LD BC,0123/PUSH BC/LD HL,4567/EX (SP),HL/POP BC will leave BC with 4567 and HL with 0123. EX (SP),HL does not move the stack pointer and nor, of course, do EX (SP),IX or EX (SP),IY.

## EXX
You can imagine this as EX BC,B‟C‟ followed by EX DE,D‟E‟ followed by EX HL,H‟L‟. Basically, each of the common registers (except A) is exchanged with its corresponding alternative register. You are warned, however, that the HL‟ register pair must contain the value 2758 before returning to BASIC, so if you alter it in any way you must re-assign it before too long.

## HALT
When a HALT instruction is reached, control will wait at that point in the program until the next interrupt occurs. When this happens the instruction RST 38 (CALL 0038) will be executed and on return, control will then continue from the first instruction after HALT. Note that the flag IFF1 must be set if a HALT is to be executed, otherwise an interrupt will never occur. In this case, HALT will literally halt forever. There will be no way of breaking out except by pulling out the plug. The effect of HALT, as far as you and I are concerned, is to wait for the next TV frame to be output – roughly equivalent to PAUSE 1 in BASIC. See DI for an explanation of the use of IFF1.  IM DANGER!!! Under no circumstances use this instruction.

## IN
This is more or less the same as the BASIC IN function. It has two forms. The first is IN A,(n) where n is a numerical constant. This is equivalent to the BASIC statement LET A = IN(256*A + n). The second form is IN r,(C) where r is a register. This is equivalent to the BASIC statement LET r = IN(256*B + C). The argument of IN refers to a hardware device outside the Z80 chip – a different number for each different device. In the form IN A,(n) the flags are not altered; however, the flags are altered by IN r,(C).

## INC
Don‟t panic! At long last we‟re back to sensible instructions we can all understand. INC r increases the value of the register r by one, but without altering the carry flag. INC s increases the value of s by one but alters no flags at all.

## IND
IN with Decrement. IND can be thought of as IN (HL),(C) followed by DEC HL followed by DEC B. The carry flag is unaltered, but the zero flag reflects the new result of B.

## INDR
As IND, except that the instruction re-executes over and over again, stopping only when B reaches zero.

## INI 
As IND, except that HL is incremented instead of decremented.

## INIR 
As INDR, except that HL is incremented instead of decremented.

## JP
If you can understand GO TO 10 then you can understand JP 7300. The destination is an address, not a line number, but the principle is Mastering Machine Code on your ZX Spectrum exactly the same. JP is the machine language GO TO. We also have conditional jumps, for example JP NZ,7300 means IF non zero THEN jump to address 7300 (In other words if the zero flag is not set.) There is another form of JP which also has an analogy in BASIC – variable destinations. If you understand GO TO N then you‟ll understand JP (HL). JP (HL) means GO TO HL. In this form you may not have conditions: for instance, JP NC,(HL) is not allowed. Only one of three register pairs may be used as variable destinations – these are HL, IX and IY. Even so these are very powerful instructions – HL can be the result of a calculation, possibly even generated at random.

## JR
The same as JP only slightly less powerful, but one byte shorter. Only four of the eight conditions may be used: Z, NZ, C and NC. This means it is impossible to use (for instance) JR PO. It is also impossible to say JR (HL). JR does not use an absolute address – the R stands for Relative. You write the instruction as JR e (or JR Z,e or whatever) where the e is a single byte which specifies how far to jump. JR 0 has no effect, since it jumps forward by zero bytes. JR FE is an infinite loop because control will jump back to the JR FE instruction itself. The displacement byte starts counting from the instruction immediately after the JR e instruction. If the byte is between 00 and 7F then the jump is forward, and if the byte is between 80 and FF then the jump is backwards. See table two of Appendix One.

## LD
The most used instruction in the whole of machine language. All it does is to transfer data from one location to another. It has many, many forms: the simplest being LD r1,r2 – that is to transfer data from one register to another. Other forms are LD A,(BC), LD A,(DE), and LD A,(HL) – and in reverse, LD (BC),A, LD (DE),A and LD (HL),A. Remember that the brackets mean the contents of an address. Registers I and R may be loaded, in conjunction with A (but only A) the registers and the register pairs may all be loaded with numerical constants, the register pairs with the contents of any address and inversely any address may be loaded from a register pair (– note that register pairs store two bytes, not one, and these are transferred to and from the address pointed to and the address pointed to plus one). Also allowed are LD A,(pq) and LD (pq),A (where pq represents an address) and SP may be loaded from HL, IX, IY or (pq). ((pq) may be loaded from SP but HL, IX and IY may not.) In other words – there‟s a lot you can do and a lot you can‟t. You can‟t say LD HL,DE, for instance (– you must use LD H,D then LD L,E or vice versa). Fortunately, since LD is used so very, very often, it is extremely easy to become familiar
with its many forms.

## LDD
LoaD with Decrement. Effectively, LD (DE),(HL) followed by DEC HL, DEC DE and DEC BC all in one go. The carry flag and zero flag are unaltered as is the sign flag, however the PV flag is reset to zero if and only if BC decrements to zero. Thus, JP PO will jump only if BC is zero after the
instruction.

## LDDR
As LDD, but the instruction is executed repeatedly until BC reaches zero.

## LDI
As LDD except that DE and HL are both incremented instead of decremented. BC is still decremented as before.

## LDIR
As LDI, but the instruction is executed repeatedly until BC reaches zero.

## NEG
NEGates the accumulator (or A register). It works by performing the subtraction 00 minus A and all the flags are changed accordingly. Thus, S reflects the sign of the result. Z will be set if and only if A is zero. P will be set if and only if A is 80. C will always be set unless A is zero. NEG is equivalent to CPL followed by INC A (ignoring flags). 

## NOP
My favourite instruction. This wondrous little beastie (whose name incidentally is short for No Operation) has a very simple purpose – to waste time. NOP does absolutely nothing at all except sit around all day drinking tea, and what‟s more it takes it‟s time doing it! It has two major uses: (i) as a delay, or (ii) to overwrite previous machine code when debugging or editing. I suppose its nearest BASIC equivalent would be a blank REM statement. I‟d say this instruction was virtually indispensable

## OR
In the form OR r this instruction is almost the opposite of AND r. Bit by bit the value of the A register is changed. If any given bit is one then it remains unaltered, otherwise it takes its new value from the corresponding bit of r. If A contains 00 then (ignoring flags) OR r is the same as LD A,r. OR FF is effectively LD A,FF. All of the flags will change as you‟d expect them to and the carry flag is reset to zero.

## ORG
Yet another of those funny directive things again. ORG is a directive which must not have a label attached. The word ORG must be followed by a number in the range 0000 to FFFF. It means all machine code from here on is to be written to the address given. Thus, ORG 7000 followed by LD A,01 means that the instruction LD A,01 is to reside at address 7000. Unless the next thing encountered is another ORG directive, then the next instruction will be at address 7002 (since LD A,01 is a two byte instruction).

## OUT
You‟ve seen this one in BASIC. It‟s printed in red on the key marked “0”. The machine code OUT instruction has two forms. The first is OUT (n),A – this is equivalent to the BASIC statement OUT 256*A + n,A. The second form is OUT (C),r which has the BASIC equivalent OUT 256*B + C,r. OUT sends numbers out of the Z80 chip and into the hardware outside. It has absolutely no effect on the flags.

## OUTD
OUT with Decrement. Equivalent to OUT (C),(HL) followed by DEC HL followed by DEC B. The carry flag is unchanged, but the zero flag reflects the new value of B.

## OTDR
A slightly different spelling in no way alters the fact that this is still an OUT with Decrement and Repeat instruction – all it does is lead us to digress from alphabetical order in order to maintain consistency. Equivalent to OUTD repeated over and over again until B reaches zero. OUTI As OUTD, except that HL is incremented instead of decremented. OTIR As OTDR, except that HL is incremented instead of decremented.

## POP
Removes two bytes of data from the top of the stack and loads them into a register pair. Register pairs BC, DE, HL, IX and IY may be used. In addition, the instruction POP AF may be used forming a pseudo “register pair” from the accumulator and the flags register. Specifically POP will remove the topmost byte from the stack into the low part of the register pair and the next byte into the high part. The stack pointer SP is updated automatically.

## PUSH
PUSH is the opposite of POP. It stores the contents of any register pair at the top of the stack. The high part is pushed first, then the low part. It “remembers” that a new item has been stacked by updating the value of SP. After a PUSH instruction, SP will always point to the low part of the topmost item on the stack.

## RES
With this instruction we can actually alter individual bits of any register. RES is short for RESet, which means “change to zero” in computing circles, so RES is the instruction which changes any required bit of a register to zero. For instance, to reset bit 3 of D you just have to say RES 3,D. RES has no effect on any of the flags.

## RET
RET is used to return from a subroutine. It works by POPping an address from the stack and then jumping to that address. It is possible to alter the address to which a subroutine will return by altering the value at the top of the stack. For example, POP HL/INC HL/PUSH HL will increase the return address by one. You could, for instance, store one byte of data immediately after the CALL instruction, then POP HL/LD A,(HL)/INC HL/PUSH HL will store that byte in A while at the same time ensuring that the subroutine will return to the address after that data. Another trick is to push an “artificial” return address onto the stack and then JP (or JR) to a subroutine instead of CALLing it. Now it will “return” to wherever you want it to go! Return may be used with conditions if needed. It does not alter the flags.

## RETI
Not applicable to the Spectrum.

## RETN
Not applicable to the Spectrum.

## RL
The form of this instruction is RL r. Each bit of the register specified is moved one position to the left. The leftmost bit is moved into the carry, and the rightmost bit takes on the previous value of the carry. Hence, Rotate Left. For example, if B contained 10010101 and the carry contained zero then RL B would leave B containing 00101010 and the carry containing one. RL alters all of the flags.

## RLA
Note that there is no space between the L and the A. RLA is a more efficient way of doing RL A! The instruction is one byte shorter and only the carry flag is affected by this instruction.

## RLC
Rotate Left without Carry. RLC r is almost the same as RL r, in fact, in the sense that each bit of the register in question is moved one position to the left. Here, however, the former leftmost bit becomes both the new value of CARRY and the new rightmost bit. The former value of CARRY does not enter into the process at all. All of the flags are changed.

## RLCA
In one byte instead of two, RLCA is just RLC A only quicker. Only the carry flag is changed by this operation.

## RLD
Now for a weird one. RLD is not to be confused with RL D for it is a completely different instruction which works as follows: write the value of A and the contents of address (HL) in hex. The second hex digit of (HL) is shifted left so that it becomes the new first digit. The former value of this first digit overwrites the second digit of A, which in turn becomes the second digit of (HL). Thus, if we start off with A containing 25 and (HL) containing A3 then RLD will change things to A = 2A, (HL) = 35. RLD incidentally, for some reason known only to the boffins above, is an abbreviation for Rotate Left Decimal.

## RR 
As RL, except that the bits are moved right instead of left.

## RRA
As RLA, except that the bits are moved right instead of left.

## RRC
As RLC, except that the bits are moved right instead of left.

## RRCA
As RLCA, except that the bits are moved right instead of left.

## RRD
As RLD, except that the hex digits are moved right instead of left.

## RST
The same as CALL except that the instruction is but one byte long altogether! It is much less powerful though for two reasons: (i) you may not use conditions (eg RST 10 is legal but RST NZ,10 is not); and (ii) only one of eight specific addresses may be called. These are 00, 08,10,18, 20, 28, 30 and 38. Since the Spectrum begins executing the ROM from address 0000 onwards, RST 00 is the same as pulling out and then reconnecting the plug.

## SBC
SBC, like ADC, comes in two forms. The first is SBC A,r, which will first of all subtract r from A, and will then subtract the carry. Similarly SBC HL,s will subtract both s and the carry flag from HL. SBC A,A is quite a useful instruction – it leaves the carry unchanged but alters A to 00 if there is no carry or FF if there is a carry.

## SCF
Set the Carry Flag. All other flags are unchanged.

## SET
The opposite of RES. SET 4,H will set bit 4 of register H to one (for example). Any bit of any register may be set.

## SLA
Shift Left Arithmetic. The form of this instruction is SLA r. It is similar to RL r except that the rightmost bit is always replaced by zero. SLA r will multiply the register r by two.

## SRA
Shift Right Arithmetic. Any register may be shifted right using the format SRA r. The instruction is similar to RR r except that the leftmost bit remains unchanged. SRA r will divide the register r by two if that register contains a number which is to be regarded as being in two‟s complement form (Appendix One, table two).  SRL Shift Right Logical. Again, similar to RR except that here the leftmost bit is replaced by zero always. SR L r will divide the register r by two if that register contains a number which is to be regarded as being in absolute value form (Appendix One, table one).

## SUB
Written as SUB r (but sometimes as SUB A,r just to be confusing). This instruction will subtract r from the register A. Note that unlike with ADD there is no corresponding instruction SUB HL,s. If you wish to subtract s from HL you must first of all reset the carry flag (usually by the use of the instruction AND A) and then use SBC HL,s.

## XOR
XOR r changes the value of A bit by bit. If any given bit of A is identical to the corresponding bit of r then that bit of A is reset to zero, otherwise that bit of A will be set. XOR alters all the flags and, in particular, the carry flag is always reset. Note that XOR A is the same as LD A,00 (ignoring flags) and that XOR FF is the same as CPL (also ignoring flags). $ The final directive. $ is not really a directive in its own right. Technically, it‟s just a special symbol which may be used in an EQU directive. However, if the dollar symbol is used in an EQU directive then the word EQU itself may be omitted! $ simply means the address of the next byte, so FRED $ + 2 (which is a short way of writing FRED EQU $ + 2) where FRED is a label means “define FRED to mean the next address plus two”. An example of its use could be LD (HL),00/CHEAT $ – 1 (CHEAT is a label) and then at some later stage LD (CHEAT),A which forms the beginnings of a self adjusting program. Can you see that the label CHEAT has been defined to mean the address of the second byte of the LD (HL),00 instruction.