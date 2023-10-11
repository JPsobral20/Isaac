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

rows(0, ' 0').
rows(10, '10').
rows(20, '20').
rows(30, '30').
rows(40, '40').
rows(50, '50').
rows(60, '60').
rows(70, '70').
rows(80, '80').
rows(90, '90').

/*
printPieces(PlayerDark, PlayerLight):-
  */  



printBoard(X):-
    nl,
    write('    | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |\n'),
    printMatrix(X, 90, 0).

printMatrix([], -10, 100):- write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |\n').

printMatrix([Head|Tail], ND, NL):-
    rows(ND, RD),
    write(' '),
    write(RD),
    ND1 is ND - 10,
    write(' | '),
    printLine(Head),
    rows(NL, RL),
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