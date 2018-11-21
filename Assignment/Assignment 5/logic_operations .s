         area     appcode, CODE, READONLY
	 IMPORT printMsg             
	 export __main	
	 ENTRY 
__main    FUNCTION             
			VLDR.F32 S6,=1   ;X0 FIRST INPUT
			VLDR.F32 S7,=1	 ;X1 SECOND INPUT
			VLDR.F32 S8,=0	 ;X2 THIRD INPUT
			ADR.W  R3, BranchTable
			MOV R4, #0        ;to select one option in switch case (gates)
			TBB  [R3, R4]   ;switch case equivalent in Arm cortex M4
			
			;0->LOGIC_AND
			;1->LOGIC_OR
			;2->LOGIC_NOT
			;3->LOGIC_NAND
			;4->LOGIC_NOR
			;5->LOGIC_XOR
			;6->LOGIC_XNOR
			
			;S9 = W0, S10 = W1, S11 = W2, S12 = BIAS
			
LOGIC_AND	        VLDR.F32 S9,=-0.1
			VLDR.F32 S10,=0.2
			VLDR.F32 S11,=0.2
			VLDR.F32 S12,=-0.2
			B EXPCALCULATE
			
LOGIC_OR	        VLDR.F32 S9,=-0.1
			VLDR.F32 S10,=0.7
			VLDR.F32 S11,=0.7
			VLDR.F32 S12,=-0.1
			B EXPCALCULATE
			
LOGIC_NOT	        VLDR.F32 S9,=0.5
			VLDR.F32 S10,=-0.7
			VLDR.F32 S11,=0
			VLDR.F32 S12,=0.1
			B EXPCALCULATE
			
LOGIC_NAND	        VLDR.F32 S9,=0.6
			VLDR.F32 S10,=-0.8
			VLDR.F32 S11,=-0.8
			VLDR.F32 S12,=0.3
			B EXPCALCULATE
	
LOGIC_NOR	        VLDR.F32 S9,=0.5
			VLDR.F32 S10,=-0.7
			VLDR.F32 S11,=-0.7
			VLDR.F32 S12,=0.1
			B EXPCALCULATE
			
LOGIC_XOR	        VLDR.F32 S9,=-5
			VLDR.F32 S10,=20
			VLDR.F32 S11,=10
			VLDR.F32 S12,=1
			B EXPCALCULATE
			
LOGIC_XNOR	        VLDR.F32 S9,=-5
			VLDR.F32 S10,=20
			VLDR.F32 S11,=10
			VLDR.F32 S12,=1
			B EXPCALCULATE
			
;CALCULATING X= X0*W0 + X1*W1 + X2*W2 + BIAS

EXPCALCULATE                    VMLA.F32 S13, S6, S9
				VMLA.F32 S13, S7, S10
				VMLA.F32 S13, S8, S11
				VADD.F32 S13, S13, S12
				B EXPONENTIAL	                  ;LOOP TO CALCULATE e^x
				
;offset calculation for switch case

BranchTable		        DCB    0
				DCB    ((LOGIC_OR-LOGIC_AND)/2)
				DCB    ((LOGIC_NOT-LOGIC_AND)/2)
				DCB    ((LOGIC_NAND-LOGIC_AND)/2)
				DCB    ((LOGIC_NOR-LOGIC_AND)/2)
				DCB    ((LOGIC_XOR-LOGIC_AND)/2)
				DCB    ((LOGIC_XNOR-LOGIC_AND)/2)

				
EXPONENTIAL  	                ;VLDR.F32 S0,=5                   ;holding x  
				VLDR.F32 S1,=1                    ;holding intermediate series elements h
				VLDR.F32 S2,=1                    ;holding final value
				MOV R2,#1                         ;counter variable i 
				MOV R1,#5                         ;no. of terms of the series n
LOOP1                           CMP R2, R1                        ;Compare 'i' and 'n'  
				BLE LOOP2                         ;if i < n goto LOOP2 
				B SIGMOID_loop                    ;else goto sigmoid function 
LOOP2                           VMOV.F32 S3, R2                    
				VCVT.F32.U32 S3, S3               ;Converting the bitstream into unsigned 32 bit fp no. 
				VMUL.F32 S1, S1, S13               ;h = h*x 
				VDIV.F32 S1, S1, S3               ;Dividing h by 'i' & store it back in 'h' 
				VADD.F32 S2, S2, S1               ;adding previous result to 'h'  
				ADD R2, R2, #1                    ;Incrementing counter 
				B LOOP1 
				
SIGMOID_loop                    VLDR.F32 S4,=1                    ;constant 1
				VDIV.F32 S2, S4, S2               ;1/e^x
				VADD.F32 S2, S4, S2               ;1/e^x + 1
				VDIV.F32 S2, S4, S2               ;1/(1/e^x + 1)
				B RESULT
				
RESULT	                VLDR.F32 S5 ,=0.5
		        VCMP.F32 S2, S5                   ;compare the output of sigmoid routine with S5
		        VMRS.F32 APSR_nzcv,FPSCR          ;Transfer floating-point flags to the APSR flags
		        ITE HI
		        MOVHI R0,#1                       ;if S2 > S5
		        MOVLS R0,#0                       ;if S2 < S5
		        BL printMsg
				
Stop            B Stop 
           ENDFUNC 
        END
			
