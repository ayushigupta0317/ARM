     AREA     appcode, CODE, READONLY
     export __main	 
	 ENTRY 
__main  function
	          MOV R0 , #70	        ;First no. a	
			  MOV R1 , #30          ;Second no. b
Loop		  CMP R0 , R1           ;Comparing both numbers a-b
              IT EQ                 ;If a=b
			  BEQ Stop              ;Conditional branch to stop
              IT HI			        ;C set and Z clear
			  SUBHI R0 , R0 , R1 	;a=a-b		  
			  IT MI                 ;N conditional flag set
			  SUBMI R1 , R1 , R0    ;b=b-a
			  B Loop			  
Stop		  B Stop
        endfunc
      end

