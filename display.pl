initialBoard([
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




symbol(0,S):- S=' '.
symbol(dark,S):- S='D'.
symbol(light,S):- S='L'.


letter(1, R):- R='90'.
letter(2, R):- R='80'.
letter(3, R):- R='70'.
letter(4, R):- R='60'.
letter(5, R):- R='50'.
letter(6, R):- R='40'.
letter(7, R):- R='30'.
letter(8, R):- R='20'.
letter(9, R):- R='10'.
letter(10, R):- R=' 0'.

printBoard(X):-
    nl,
    write('    | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |\n'),
    printMatrix(X, 1, 10).

printMatrix([], 11, 0):- write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |\n').

printMatrix([Head|Tail], ND, NL):-
    letter(ND, RD),
    write(' '),
    write(RD),
    ND1 is ND + 1,
    write(' | '),
    printLine(Head),
    letter(NL, RL),
    write(' '),
    write(RL),
    NL1 is NL - 1,
    nl,
    printMatrix(Tail, ND1, NL1).

printLine([]).

printLine([Head|Tail]):-
    symbol(Head, S),
    write(S),
    write(' | '),
    printLine(Tail).