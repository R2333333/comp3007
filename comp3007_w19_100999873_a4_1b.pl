%Roy Xu 100999873
myRem(A,B,C) :-  D is A // B, C is A - ( B * D). 
zeroFree(X) :- (X > 10, myRem(X,10,Y), Y > 0, zeroFree(X//10));( X < 10, X > 0).
countZerofree([],0).
countZerofree([H|T],A) :- (zeroFree(H), countZerofree(T,X), A is X + 1); 
   \+(zeroFree(H)), countZerofree(T,A).

