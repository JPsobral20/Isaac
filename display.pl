% Defines the initial game board matrix with all positions initialized to 0. The matrix represents the game board.
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


% Define the players pieces. Each player has a list of the number of each piece that he has. Represented as [NumberOfPieces, ScorePiece]
darkPlayer([[5,1], [4,2], [3,3], [2,4], [1,6]]).

lightPlayer([[5,1], [4,2], [3,3], [2,4], [1,6]]).

% Specifies the size of the piece for each score.
scoreLength(1,3).
scoreLength(2,4).
scoreLength(3,5).
scoreLength(4,6).
scoreLength(6,7).

symbol(0, '   ').
symbol(1, ' 1 ').

/* All the pieces to write on the board, [68] is the list when we do "D" and [76] is the list when we do "L", 
the first number is the score of that piece and the last is the number(id) of pieces */



symbol(1-[68]-5, '1D5').
symbol(1-[68]-4, '1D4').
symbol(1-[68]-3, '1D3').
symbol(1-[68]-2, '1D2').
symbol(1-[68]-1, '1D1').
symbol(2-[68]-4, '2D4').
symbol(2-[68]-3, '2D3').
symbol(2-[68]-2, '2D2').
symbol(2-[68]-1, '2D1').
symbol(3-[68]-3, '3D3').
symbol(3-[68]-2, '3D2').
symbol(3-[68]-1, '3D1').
symbol(4-[68]-2, '4D2').
symbol(4-[68]-1, '4D1').
symbol(6-[68]-1, '6D1').
symbol(1-[76]-5, '1L5').
symbol(1-[76]-4, '1L4').
symbol(1-[76]-3, '1L3').
symbol(1-[76]-2, '1L2').
symbol(1-[76]-1, '1L1').
symbol(2-[76]-4, '2L4').
symbol(2-[76]-3, '2L3').
symbol(2-[76]-2, '2L2').
symbol(2-[76]-1, '2L1').
symbol(3-[76]-3, '3L3').
symbol(3-[76]-2, '3L2').
symbol(3-[76]-1, '3L1').
symbol(4-[76]-2, '4L2').
symbol(4-[76]-1, '4L1').
symbol(6-[76]-1, '6L1').



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
 
% Get the number of pieces of a player
getNumberPiece(Score,Player,Number):- 
    member([Number,Score],Player).

% Prints the pieces that each player has
printMenuPieces(Score,Player):-
    write('\n\n'),
    scoreLength(Score, Length),
    printRestPiece(Length),
    format("Piece score ~w: ", [Score]),
    getNumberPiece(Score,Player,Number),
    write('|'),
    printPiece(Length,Number).

printPiece(0,NumPieces):-format("x~w",[NumPieces]).
printPiece(N,NumPieces):-
    N > 0,
    write('_|'),
    N1 is N - 1,
    printPiece(N1,NumPieces).



printRestPiece(3):- 
    write('                '),
    write('_ _ _\n').

printRestPiece(4):-
    write('                '),
    write('_ _ _ _\n').

printRestPiece(5):-
    write('                '),
    write('_ _ _ _ _\n').

printRestPiece(6):-
    write('                '),
    write('_ _ _ _ _ _\n').

printRestPiece(7):-
    write('                '),
    write('_ _ _ _ _ _ _\n').

% Prints the game board
printBoard(X):-
    nl,
    write('    | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |\n'),
    printLineBoard,
    printMatrix(X, 90, 0).

printLineBoard:-
    write(' -----------------------------------------------\n').


% Prints the board matrix
printMatrix([], -10, 100):- write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |\n').

printMatrix([Head|Tail], ND, NL):-
    rows(ND, RD),
    write(' '),
    write(RD),
    ND1 is ND - 10,
    write(' |'),
    printLine(Head),
    rows(NL, RL),
    write(' '),
    write(RL),
    NL1 is NL + 10,
    nl,
    printLineBoard,
    printMatrix(Tail, ND1, NL1).

% Prints a row of the board
printLine([]).

printLine([Head|Tail]):-
    symbol(Head, S),
    write(S),
    write('|'),
    printLine(Tail).