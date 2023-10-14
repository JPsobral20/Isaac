/*Todos os predicados deste ficheiro analisam o input, relativamente às linhas e colunas inseridas pelo utilizador,
e se as mesmas estão dentro dos limites do tabuleiro. Caso não se satisfaca, pede novamente a informação.*/

elementAtIndex(1, [Head|_], Head).
elementAtIndex(I, [_|Tail], Element):-
    I > 1,
    checkPiece6(I, NewI),
    I1 is NewI - 1,
    elementAtIndex(I1, Tail, Element).


checkPiece6(Input, UpdatedInput) :-
    (Input = 6 -> UpdatedInput is Input - 1 ; UpdatedInput = Input).


checkPieceInputValid(N, Player, Piece):-
    \+ member(N, [1, 2, 3, 4, 6]),
    write('\nERROR: invalid piece!\n\n'),
    write('Choose a piece: '),
    read(Input),
    checkPieceInputValid(Input, Player, Piece).
    /*, !.*/


checkPieceInputValid(N, Player, Piece):-
    member(N, [1, 2, 3, 4, 6]),
    checkHavePiece(N, Player, Piece).


checkHavePiece(N, Player, Piece):-
    elementAtIndex(N, Player, Ele),
    havePiece(Ele, Player, Piece).


havePiece([0|S], Player, Piece):-
    write('\nNão tem peças de score '),
    elementAtIndex(1, S, Ele),
    write(Ele),
    write('\nEscolha outra!\n'),
    managePiece(Player, Piece).
    
    
havePiece([N|S], Player, Piece):-
    N \= 0,
    write('\n Tem '),
    write(N),
    write(' peças de score '),
    elementAtIndex(1, S, Ele),
    write(Ele),
    Piece = Ele.

managePiece(Player, Piece):-
    write('\nChoose a piece: '),
    read(Input),
    checkPieceInputValid(Input, Player, Piece).



decrementPiece([Sublist | Rest], N, NewDarkPlayer):-
    N > 1,
    N1 is N - 1,
    decrementPiece(Rest, N1, UpdatedRest),
    NewDarkPlayer = [Sublist | UpdatedRest].

decrementPiece([Sublist | Rest], 1, NewDarkPlayer):-
    [CurrentFirst | RestOfSublist] = Sublist,
    NewFirst is CurrentFirst - 1,
    UpdatedSublist = [NewFirst | RestOfSublist],
    NewDarkPlayer = [UpdatedSublist | Rest].




    



manageRow(NewRow) :-
    write('\nChoose a row: '),
    read(Row),
    validateRow(Row, NewRow).

validateRow(Row, NewRow) :-
    validRow(Row), !,
    NewRow is Row / 10.

validateRow(_, NewRow) :-
    write('\nThat row is not valid!\n'),
    manageRow(NewRow).

validRow(Row) :-
    member(Row, [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]).



manageColumn(NewColumn) :-
    write('\nChoose a column: '),
    read(Column),
    validateColumn(Column, NewColumn).

validateColumn(Column, NewColumn) :-
    validColumn(Column), !,
    NewColumn is Column.

validateColumn(_, NewColumn) :-
    write('\nThat column is not valid!\n'),
    manageColumn(NewColumn).

validColumn(Column) :-
    member(Column, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).


chooseDirection(Column,Row,Piece):- 
    write('\nChoose a direction (up,down,left,right): '),
    read(Direction),
    validateDirection(Direction, Column, Row, Piece).

validateDirection(Direction, Column, Row, Piece) :-
    \+ member(Direction, [up, down, left, right]),
    write('\nThat direction is not valid!\n'),
    write('\nChoose a direction (up,down,left,right): '),
    read(NewDirection),
    validateDirection(NewDirection, Column, Row, Piece).

validateDirection(Direction, Column, Row) :-
    member(Direction, [up, down, left, right]).
    scoreLength(Piece, Length),
    checkDirection(Direction, Column, Row, Length).

checkDirection(up, Column, Row, Length):-           % Se a linha somada ao comprimento da peça for maior que 90, não é válido
    (Row + (Length * 10) <= 90 ->
        write('\nThat direction is valid!\n')
        ;
        write('\nThat direction is not valid!\n')
    ).

checkDirection(up, Column, Row, Length):-           % Se a linha subtraida ao comprimento da peça for menor que 0, não é válido
    (Row - (Length * 10) >= 0 ->
        write('\nThat direction is valid!\n')
        ;
        write('\nThat direction is not valid!\n')
    ).


/* não é relacionado com o nosso código

manageMoveWorkerBool(NewMoveWorkerBool):-
      read(MoveWorkerBool),
      validateMoveWorkerBool(MoveWorkerBool, NewMoveWorkerBool).

validateMoveWorkerBool(1, NewMoveWorkerBool):-
    NewMoveWorkerBool = 1.

validateMoveWorkerBool(0, NewMoveWorkerBool):-
    NewMoveWorkerBool = 0.

validateMoveWorkerBool(_Bool, NewMoveWorkerBool):-
    write('\nERROR: That answer is not valid, please try again![0(No)/1(Yes)]'),
    read(Input),
    validateMoveWorkerBool(Input, NewMoveWorkerBool).
*/