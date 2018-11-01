		PRESERVE8 
        THUMB 
        AREA  appcode,CODE,READONLY 
        EXPORT __main 
        ENTRY 
__main    FUNCTION                                ;e^x series
                VLDR.F32 S0,=2                    ;holding x  
                VLDR.F32 S1,=1                    ;holding intermediate series elements h
                VLDR.F32 S2,=1                    ;holding final value
                MOV R0,#1                         ;counter variable i 
                MOV R1,#5                         ;no. of terms of the series n 
LOOP1           CMP R0, R1                        ;Compare 'i' and 'n'  
				        BLE LOOP2                         ;if i < n goto LOOP2 
				        B Stop                            ;else goto stop 
LOOP2           VMOV.F32 S3, R0                    
                VCVT.F32.U32 S3, S3               ;Converting the bitstream into unsigned 32 bit fp no. 
                VMUL.F32 S1, S1, S0               ;h = h*x 
                VDIV.F32 S1, S1, S3               ;Dividing h by 'i' & store it back in 'h' 
                VADD.F32 S2, S2, S1               ;adding previous result to 'h'  
                ADD R0, R0, #1                    ;Incrementing counter 
                B LOOP1 
Stop            B Stop 
           ENDFUNC 
        END
