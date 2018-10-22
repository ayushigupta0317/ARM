     AREA     appcode, CODE, READONLY
     export __main	 
	 ENTRY 
__main  function
	          MOV R0 , #0            ; Starting no. = 0
	          MOV R1 , #1            ; Starting no. = 1
            MOV R2 , #10           ; no. of terms in fibonacci series 
Loop2       SUB R2 , R2 , #1        
			      CMP R2, #2	          
			      IT HI                  ; C set and Z clear
			      BHI Loop1
Loop1         ADD R3 , R1 , R0       ; R3 holding final term in this case 10th term 
              MOV R0 , R1       
              MOV R1 , R3  
			        IT EQ                  ; Z set
              BEQ Stop
			        B Loop2
Stop	      B Stop            
        endfunc
      end
