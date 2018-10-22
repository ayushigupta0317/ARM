     AREA     appcode, CODE, READONLY
     export __main	 
	 ENTRY 
__main  function
	          MOV R0 , #300    ;Given First number
	          MOV R1 , #200    ;GIven Second number
              MOV R2 , #150    ;Given Third number  			  
              CMP R0 , R1     ;Comparing first 2 numbers
              IT HI           ;C set and Z clear
              MOVHI R1 , R2   ;Conditional move
			  IT MI           ;N set
			  MOVMI R0 , R2
			  IT EQ           ;Z set
			  MOVEQ R0 , R2 
			  CMP R0 , R1     ;Comparing third number with greatest of first two no.
			  IT HI 
			  MOVHI R1 , R0   ;Storing largest number in R1
Stop		  B Stop  
        endfunc
      end

