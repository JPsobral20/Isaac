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
    write('Choose other piece: '),
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
    
    
havePiece([N|_], _, _):-
    N \= 0.

managePiece(Player, Piece):-
    write('\nChoose a piece: '),
    read(Input),
    checkPieceInputValid(Input, Player, Piece).



decrementPiece([Sublist | Rest], N, NewDarkPlayer):-
    N > 1,
    checkPiece6(N, NewN),
    N1 is NewN - 1,
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
    NewRow is Row.

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


manageSquareDark(Board, RetColumn, RetRow):-
    manageColumn(Column),
    manageRow(Row),
    NewRow is 90 - Row,
    RetColumn is Column,
    RetRow is NewRow,
    checkEmptySquare(Board, Column, NewRow, dark).


manageSquareLight(Board, RetColumn, RetRow):-
    manageColumn(Column),
    manageRow(Row),
    NewColumn is 9 - Column,
    RetColumn is NewColumn,
    RetRow is Row,
    checkEmptySquare(Board, NewColumn, Row, light).



checkEmptySquare(Board, Column, Row, Player):-
    NewRow is Row div 10,
    elementAt(Board, NewRow, RowList),
    elementAt(RowList, Column, Element),
    checkEle(Element, Board, Player).


checkEle(Element, Board, dark):-
    Element \= 0,
    manageSquareDark(Board, Column, Row).

checkEle(Element, Board, light):-
    Element \= 0,
    manageSquareDark(Board, Column, Row).

checkEle(0, _, _).




chooseDirection(Column, Row, Piece, Board, RetDirection):- 
    write('\nChoose a direction (up,down,left,right): '),
    read(Direction),
    validateDirection(Direction, Column, Row, Piece, Board, RetDirection).


validateDirection(Direction, Column, Row, Piece, Board, RetDirection) :-
    \+ member(Direction, [up, down, left, right]),
    write('\nThat direction is not valid!\n'),
    write('\nChoose another direction (up,down,left,right): '),
    read(NewDirection),
    validateDirection(NewDirection, Column, Row, Piece, Board, RetDirection).

validateDirection(Direction, Column, Row, Piece, Board, RetDirection) :-
    member(Direction, [up, down, left, right]),
    scoreLength(Piece, Length),
    checkDirection(Direction, Column, Row, Length, Board, RetDirection).

checkDirection(up, Column, Row, Length, Board, RetDirection):-  
    (Row - ((Length - 1) * 10) >= 0 ->
        write('\nThat direction is valid!\n'),
        validMove(up, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        scoreLength(Piece, Length),
        chooseDirection(Column, Row, Piece, Board, RetDirection)
    ).

checkDirection(down, Column, Row, Length, Board, RetDirection):-
    (Row + ((Length - 1) * 10) =< 90 ->
        write('\nThat direction is valid!\n'),
        validMove(down, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        scoreLength(Piece, Length),
        chooseDirection(Column, Row, Piece, Board, RetDirection)
    ).

checkDirection(left, Column, Row, Length, Board, RetDirection):-
    (Column - (Length - 1) >= 0 ->
        write('\nThat direction is valid!\n'),
        validMove(left, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        scoreLength(Piece, Length),
        chooseDirection(Column, Row, Piece, Board, RetDirection)
    ).

checkDirection(right, Column, Row, Length, Board, RetDirection):-
    (Column + (Length - 1) =< 9  ->
        write('\nThat direction is valid!\n'),
        validMove(right, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        scoreLength(Piece, Length),
        chooseDirection(Column, Row, Piece, Board, RetDirection)
    ).


validMove(Direction, Column, Row, Length, Board, RetDirection):-
    NewRow is Row div 10,
    checkPositions(Direction, Board, Column, NewRow, Length, Success),
    scoreLength(Piece, Length),
    (Success =:= 0 -> RetDirection = Direction ; chooseDirection(Column, Row, Piece, Board, RetDirection)).


checkPositions(_, _, _, _, 0, FinalLength):-
    FinalLength = 0.

checkPositions(Direction, Board, Column, Row, Length, FinalLength):-
    Length > 0,
    elementAt(Board, Row, RowList),
    elementAt(RowList, Column, Element),
    (Element =:= 0 ->
        updateColumAndRow(Direction, Column, Row, NewColumn, NewRow),
        NewLength is Length - 1,
        checkPositions(Direction, Board, NewColumn, NewRow, NewLength, FinalLength)
    ;
        FinalLength = Length,
        nl
    ).

updateColumAndRow(up, Column, Row, NewColumn, NewRow):-
    NewColumn is Column,
    NewRow is Row - 1.

updateColumAndRow(down, Column, Row, NewColumn, NewRow):-
    NewColumn is Column,
    NewRow is Row + 1.

updateColumAndRow(right, Column, Row, NewColumn, NewRow):-
    NewRow is Row,
    NewColumn is Column + 1.

updateColumAndRow(left, Column, Row, NewColumn, NewRow):-
    NewRow is Row,
    NewColumn is Column - 1.


% Predicado para acessar um elemento em uma lista dada uma posição
elementAt(List, Index, Element) :-
    elementAt(List, Index, 0, Element).

elementAt([Head|_], Index, Index, Head).
elementAt([_|Tail], Index, CurrentIndex, Element) :-
    NextIndex is CurrentIndex + 1,
    elementAt(Tail, Index, NextIndex, Element).




