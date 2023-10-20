/*Todos os predicados deste ficheiro analisam o input, relativamente às linhas e colunas inseridas pelo utilizador,
e se as mesmas estão dentro dos limites do tabuleiro. Caso não se satisfaca, pede novamente a informação.*/

printPieceOnBoard(Column, Row, Piece, Board, right, Player, Acronym, AfterBoard):-
    getNumberPiece(Piece,Player,Number),
    Element = Number-Acronym-Piece,
    elementAt(Board, Row, RowList),
    scoreLength(Piece, Length),
    NewLength is Length - 1,
    updateRow(RowList, Column, NewLength, Element, UpdatedRow),
    replaceRowBoard(Board, Row, UpdatedRow, AfterBoard).
    
printPieceOnBoard(Column, Row, Piece, Board, left, Player, Acronym, AfterBoard):-
    getNumberPiece(Piece,Player,Number),
    Element = Number-Acronym-Piece, 
    elementAt(Board, Row, RowList),
    scoreLength(Piece, Length),
    NewLength is Length - 1,
    NewColumn is Column - (Length) + 1,
    updateRow(RowList, NewColumn, NewLength, Element, UpdatedRow),
    replaceRowBoard(Board, Row, UpdatedRow, AfterBoard).

printPieceOnBoard(Column, Row, Piece, Board, down, Player, Acronym, AfterBoard):-
    getNumberPiece(Piece,Player,Number),
    Element = Number-Acronym-Piece,
    scoreLength(Piece, Length),
    NewRow is Row + Length,
    updateColumn(Board, Column, Row, NewRow, Element, AfterBoard).

printPieceOnBoard(Column, Row, Piece, Board, up, Player, Acronym, AfterBoard):-
    getNumberPiece(Piece,Player,Number),
    Element = Number-Acronym-Piece,
    scoreLength(Piece, Length),
    NewRow is Row - (Length - 1), % Dividi-se por 10 e depois tiramos o tamanho da peça - 1 para obter a linha inicial
    NewRowEnd is NewRow + Length,
    updateColumn(Board, Column, NewRow, NewRowEnd, Element, AfterBoard).

updateColumn(Board, _, EndRow, EndRow, _, Board).

updateColumn(Board, Column, RowIndex, EndRow, Piece, UpdatedBoard) :-
    elementAt(Board, RowIndex, RowList),
    updateRow(RowList, Column, 0, Piece, UpdatedRow),
    NewRowIndex is RowIndex + 1,
    updateColumn(Board, Column, NewRowIndex, EndRow, Piece, RestOfBoard),
    replaceRowBoard(RestOfBoard, RowIndex, UpdatedRow, UpdatedBoard).

replaceRowBoard([], _, _, []).
replaceRowBoard([_|T], 0, NewRow, [NewRow|T]).
replaceRowBoard([H|T], Index, NewRow, [H|NewT]) :-
    Index > 0,
    NewIndex is Index - 1,
    replaceRowBoard(T, NewIndex, NewRow, NewT).


updateRow([], _, _, _, []).
updateRow([_|T], 0, 0, NewElement, [NewElement|T]). % É o primeiro na lista
updateRow([_|T], 0, NTimesElement, NewElement, [NewElement|NewT]) :- % Quando chega ao intervalo ele vai substituir o elemento e fazer a recursao para o resto(tail)
    NTimesElement > 0,
    NewNTimesElement is NTimesElement - 1,
    updateRow(T, 0, NewNTimesElement, NewElement, NewT).
updateRow([H|T], StartIndex, NTimesElement, NewElement, [H|NewT]) :- % Se ainda não chegou ao intervalo ele vai manter a cabeça da lista e fazer a recursao para o resto(tail)
    StartIndex > 0,
    NewStartIndex is StartIndex - 1,
    updateRow(T, NewStartIndex,  NTimesElement, NewElement, NewT).

















elementAtIndex(1, [Head|_], Head).
elementAtIndex(I, [_|Tail], Element):-
    I > 1,
    checkPiece6(I, NewI),
    I1 is NewI - 1,
    elementAtIndex(I1, Tail, Element).


checkPiece6(6, UpdatedInput):-
   UpdatedInput is 6 - 1.

checkPiece6(Input, UpdatedInput):-
    Input \= 6,
    UpdatedInput = Input.


checkPieceInputValid(N, Player, Piece, Board):-
    \+ member(N, [1, 2, 3, 4, 6]),
    write('\nERROR: invalid piece!\n\n'),
    write('Choose other piece: '),
    read(Input),
    checkPieceInputValid(Input, Player, Piece, Board).
    /*, !.*/


checkPieceInputValid(N, Player, Piece, Board):-
    member(N, [1, 2, 3, 4, 6]),
    selectPiece(N, Player, Piece, Board).


selectPiece(N, Player, Piece, Board):-
    elementAtIndex(N, Player, Ele),
    havePiece(Ele, Player, Piece, Board).


havePiece([0|S], Player, Piece, Board):-
    write('\nNão tem peças de score '),
    elementAtIndex(1, S, Ele),
    write(Ele),
    write('\nEscolha outra!\n'),
    managePiece(Player, Piece, Board).
    
    
havePiece([N|S], Player, Piece, Board):-
    N \= 0,
    elementAt(S, 0, Score),
    scoreLength(Score, Length),
    (canPlayPiece(Length, Board) ->
    Piece is S
    ;
    write('Não pode jogar essa peca!'),nl,
    managePiece(Player, Piece, Board)
    ).


canPlayPiece(Length, Board):-
    verificar_zeros_consecutivos(Board, Length);
    (transpose(Board, NewBoard),
    verificar_zeros_consecutivos(NewBoard, Length)).

managePiece(Player, Piece, Board):-
    write('\nChoose a piece: '),
    read(Input),
    checkPieceInputValid(Input, Player, Piece, Board).



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



manageRow(NewRow):-
    write('\nChoose a row: '),
    read(Row),
    validateRow(Row, NewRow).

validateRow(Row, NewRow):-
    validRow(Row), !,
    NewRow is Row.

validateRow(_, NewRow):-
    write('\nThat row is not valid!\n'),
    manageRow(NewRow).

validRow(Row):-
    member(Row, [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]).



manageColumn(NewColumn):-
    write('\nChoose a column: '),
    read(Column),
    validateColumn(Column, NewColumn).

validateColumn(Column, NewColumn):-
    validColumn(Column), !,
    NewColumn is Column.

validateColumn(_, NewColumn):-
    write('\nThat column is not valid!\n'),
    manageColumn(NewColumn).

validColumn(Column):-
    member(Column, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).


manageSquareDark(Board, RetColumn, RetRow, Piece):-
    manageColumn(Column),
    manageRow(Row),
    NewRow is 90 - Row,
    checkEmptySquare(Board, Column, NewRow, dark, RetColumn, RetRow, Piece).


manageSquareLight(Board, RetColumn, RetRow, Piece):-
    manageColumn(Column),
    manageRow(Row),
    NewColumn is 9 - Column,
    checkEmptySquare(Board, NewColumn, Row, light, RetColumn, RetRow, Piece).


checkEmptySquare(Board, Column, Row, Player, RetColumn, RetRow, Piece):-
    NewRow is Row div 10,
    elementAt(Board, NewRow, RowList),
    elementAt(RowList, Column, Element),
    checkEle(Element, Board, Player, Column, NewRow, RetColumn, RetRow, Piece).


checkEle(Element, Board, dark, _, _, RetColumn, RetRow, Piece):-
    Element \= 0,
    manageSquareDark(Board, RetColumn, RetRow, Piece).

checkEle(Element, Board, light, _, _, RetColumn, RetRow, Piece):-
    Element \= 0,
    manageSquareLight(Board, RetColumn, RetRow, Piece).

checkEle(0, Board, dark, Column, Row, RetColumn, RetRow, Piece):-
    (checkCanPlayPiece(Board, Column, Row, Piece) ->

        RetColumn is Column,
        RetRow is Row
    ;
        write('Cant piece there'),nl,
        manageSquareDark(Board, RetColumn, RetRow, Piece)
    ).

checkEle(0, Board, light, Column, Row, RetColumn, RetRow, Piece):-
    (checkCanPlayPiece(Board, Column, Row, Piece) ->

    RetColumn is Column,
    RetRow is Row
    ;
    write('Cant piece there'),nl,
    manageSquareLight(Board, RetColumn, RetRow, Piece)
    ).


checkCanPlayPiece(Board, Column, Row, Piece):-
    checkValidMove(right, Column, Row, Piece, Board);
    checkValidMove(left, Column, Row, Piece, Board);
    checkValidMove(up, Column, Row, Piece, Board);
    checkValidMove(down, Column, Row, Piece, Board).


checkValidMove(Direction, Column, Row, Piece, Board):-
    scoreLength(Piece, Length),
    checkPositions(Direction, Board, Column, Row, Length, Success),
    (Success =:= 0 -> true ; fail).




chooseDirection(Column, Row, Piece, Board, RetDirection):- 
    write('\nChoose a direction (up,down,left,right): '),
    read(Direction),
    validateDirection(Direction, Column, Row, Piece, Board, RetDirection).


validateDirection(Direction, Column, Row, Piece, Board, RetDirection):-
    \+ member(Direction, [up, down, left, right]),
    write('\nThat direction is not valid!\n'),
    write('\nChoose another direction (up,down,left,right): '),
    read(NewDirection),
    validateDirection(NewDirection, Column, Row, Piece, Board, RetDirection).

validateDirection(Direction, Column, Row, Piece, Board, RetDirection):-
    member(Direction, [up, down, left, right]),
    scoreLength(Piece, Length),
    checkDirection(Direction, Column, Row, Length, Board, RetDirection).

checkDirection(up, Column, Row, Length, Board, RetDirection):-  
    (Row - (Length - 1) >= 0 ->
        write('\nThat direction is valid!\n'),
        validMove(up, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        scoreLength(Piece, Length),
        chooseDirection(Column, Row, Piece, Board, RetDirection)
    ).

checkDirection(down, Column, Row, Length, Board, RetDirection):-
    (Row + (Length - 1) =< 9 ->
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
    checkPositions(Direction, Board, Column, Row, Length, Success),
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
        FinalLength = Length
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
elementAt(List, Index, Element):-
    elementAt(List, Index, 0, Element).

elementAt([Head|_], Index, Index, Head).
elementAt([_|Tail], Index, CurrentIndex, Element):-
    NextIndex is CurrentIndex + 1,
    elementAt(Tail, Index, NextIndex, Element).






checkIfPlayerCanPlay(Board, Player):-
    checkHorizontal(Board, Player);
    (transpose(Board, NewBoard),
    checkHorizontal(NewBoard, Player)).



checkHorizontal(_, []):- 
    fail.

checkHorizontal(Board, [Piece|Rest]):-
    elementAt(Piece, 0, NumberPieces),
    elementAt(Piece, 1, Score),
    scoreLength(Score, Length),

    (NumberPieces \= 0 ->

    verificar_zeros_consecutivos(Board, Length)

    ;

    checkHorizontal(Board, Rest)
    
    ).


verificar_zeros_consecutivos(Matrix, N):-
    member(Row, Matrix),
    verificar_zeros_consecutivos_na_linha(Row, 0, N).

% Verificar zeros consecutivos em uma linha
verificar_zeros_consecutivos_na_linha(_, Count, N):-
    Count =:= N.       % Condição para N ou mais zeros consecutivos

verificar_zeros_consecutivos_na_linha([0|Rest], Count, N):-
    NewCount is Count + 1,
    verificar_zeros_consecutivos_na_linha(Rest, NewCount, N).

verificar_zeros_consecutivos_na_linha([Ele|Rest], _, N):-
    Ele \= 0,
    verificar_zeros_consecutivos_na_linha(Rest, 0, N).



