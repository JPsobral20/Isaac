initialMatrix([
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],           
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]).

/*piece(N,S).*/

darkPlayer([[5,1], [4,2], [3,3], [2,4], [1,6]]).

lightPlayer([[5,1], [4,2], [3,3], [2,4], [1,6]]).


symbol(0,' ').

symbol(1,S):- S='0D1'.
symbol(1,S):- S='1D1'.


letter(0, R):- R=' 0'.
letter(10, R):- R='10'.
letter(20, R):- R='20'.
letter(30, R):- R='30'.
letter(40, R):- R='40'.
letter(50, R):- R='50'.
letter(60, R):- R='60'.
letter(70, R):- R='70'.
letter(80, R):- R='80'.
letter(90, R):- R='90'.

/*
printPieces(PlayerDark, PlayerLight):-
  */  



printBoard(X):-
    nl,
    write('    | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |\n'),
    printMatrix(X, 90, 0).

printMatrix([], -10, 100):- write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |\n').

printMatrix([Head|Tail], ND, NL):-
    letter(ND, RD),
    write(' '),
    write(RD),
    ND1 is ND - 10,
    write(' | '),
    printLine(Head),
    letter(NL, RL),
    write(' '),
    write(RL),
    NL1 is NL + 10,
    nl,
    printMatrix(Tail, ND1, NL1).

printLine([]).

printLine([Head|Tail]):-
    symbol(Head, S),
    write(S),
    write(' | '),
    printLine(Tail).