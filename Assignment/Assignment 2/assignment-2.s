If I build the following code (CODE-1) in KEIL Simulator, I get four errors which are shown below.
code_1.s(11): error: A1619E: Specified condition is not consistent with previous IT
code_1.s(12): error: A1619E: Specified condition is not consistent with previous IT
code_1.s(13): error: A1619E: Specified condition is not consistent with previous IT
code_1.s(14): error: A1619E: Specified condition is not consistent with previous IT

1.)  The instruction " ITTTE LT " used in CODE-1 means that it is If-Then-Else block with 3 Then instructions and 1 Else instruction following it.

2.)  " LT " indicates If-Then-Else block is conditional.

3.)  In CODE-1, no conditional instructions used in ITTTE block.
     therefore errors.

4.)  In CODE-2, then block use LT conditional instructions whereas else block uses GE conditional instruction. 
     therefore no errors.
     
5.)  As per rule of if-then-else, else condition must be inverse of then condition, here LT is inverse of GE.
