accessCharacter(String, N, Caractere):-
    sub_atom(String, N, 1, _, Caractere).



removePice(Board, Score, Player, NewBoard, UpdateScore):-
    write('\nChoose a square to remove a piece!\n'),
    choosePiece(Board, Score, Player, NewBoard, UpdateScore).

    

choosePiece(Board, Score, Player, NewBoard, UpdateScore):-
    manageColumn(Column),
    manageRow(Row),
    NewRow is Row div 10,
    (Player == dark ->
    UpdateRow is 9 - NewRow,
    UpdateColumn is Column
    ;
    UpdateRow is NewRow,
    UpdateColumn is 9 - Column
    ),
    elementAt(Board, UpdateRow, RowList),
    elementAt(RowList, UpdateColumn, Element),
    (Element == 0 ->
    write('\nThat square is empty!\n'),
    removePice(Board, Score, Player, NewBoard, UpdateScore)
    ;
    checkPlayer(Board, Player, Element, Score, NewBoard, UpdateScore)
    ).





checkPlayer(Board, dark, Piece, Score, NewBoard, UpdateScore):-
    symbol(Piece, Code),
    accessCharacter(Code, 1, Element),
    (Element \= 'L' ->
    checkIfCanRemove(Board, Piece, Score, NewBoard, UpdateScore, dark)
    ;
    write('\nThat piece is from light player!\n'),
    removePice(Board, Score, dark, NewBoard, UpdateScore)
    ).

checkPlayer(Board, light, Piece, Score, NewBoard, UpdateScore):-
    symbol(Piece, Code),
    accessCharacter(Code, 1, Element),
    (Element \= 'D' ->
    checkIfCanRemove(Board, Piece, Score, NewBoard, UpdateScore, light)
    ;
    write('\nThat piece is from dark player!\n'),
    removePice(Board, Score, light, NewBoard, UpdateScore)
    ).



checkIfCanRemove(Board, Piece, Score, NewBoard, UpdateScore, Player):-
    (checkPieceMatrix(Board, Piece) ->
    updateScore(Board, Piece, Score, NewBoard, UpdateScore)
    ;
    write('\nCannot remove that piece!\n'),
    removePice(Board, Score, Player, NewBoard, UpdateScore)
    ).



checkPieceMatrix([], _).
checkPieceMatrix([Line|Rest], Piece):-
    checkPieceLine(Line, Piece),
    checkPieceMatrix(Rest, Piece).

checkPieceLine([], _).
checkPieceLine([Element|Rest], Piece):-
    symbol(Element, Code),
    sub_atom(Code, 1, _, 0, Substring),
    (Substring == Piece ->
    fail
    ;
    checkPieceLine(Rest, Piece)
    ).


updateScore(Board, Piece, Score, UpdateBoard, FinalScore):-

    index0(Piece, ScorePiece),
    countPieces(Board, Piece, [], List, UpdateCounter),
    length(List, NPieces),
    retCounters(0, Counters),
    NewScore is Score + (ScorePiece * NPieces * Counters),
    (NewScore > 99 -> 
    FinalScore is NewScore
    ;
    choseNewScore(Score, NewScore, UpdateScore),
    FinalScore is UpdateScore
    ).


index0(Element, Value) :-
    Element = Value-_-_.


retCounters(0, 1).
retCounters(1, 2).
retCounters(2, 4).


countPieces(Board, Piece, List, UpdatedList, UpdateCounter):- 
    (retRealRow(Board, Piece, Row);
    (transpose(Board, NewBoard),
    retRealRow(NewBoard, Piece, Row))),
    appendPieces(Row, Piece, List, NewList),
    checkCounters(Row, 0, Counters),
    UpdateCounter = Counters,
    UpdatedList = NewList.


retRealRow([], _, _):- fail.
retRealRow(Board, Piece, RetRow):-
    member(RetRow, Board),
    consecutive_ones(RetRow, Piece).

consecutive_ones([Piece, Piece | _], Piece).
consecutive_ones([_ | Rest], Piece) :- consecutive_ones(Rest, Piece).


appendPieces([], _, List, NewList):-
    NewList = List.

appendPieces([Element|Rest], Piece, List, NewList):-
    (Element == Piece;
    Element == 0;
    member(Element, List)),
    appendPieces(Rest, Piece, List, NewList).

appendPieces([Element|Rest], Piece, List, NewList):-
    Element \= Piece,
    Element \= 0,
    \+ member(Element, List),
    append(List, [Element], NewList),
    appendPieces(Rest, Piece, NewList, NewNewList).


checkCounters(_, Counter, UpdateCounter):-
    UpdateCounter = Counter.
checkCounters([Element|Rest], Counter, UpdateCounter):-
    symbol(Element, Code),
    sub_atom(Code, 0, 1, _, Substring),
    (Substring == 'X'; Substring == 'O' ->
    UpdateCounter is Counter + 1,
    checkCounters(Rest, UpdateCounter, NewCounter)
    ;
    checkCounters(Rest, Counter, UpdateCounter)
    ).



choseNewScore(Score, NewScore, UpdateScore):-

    write('\nWhich square do you want to go to?\n'),
    manageColumn(Column),
    manageRow(Row),
    Square is Column + Row,
    (Square >= Score, Square =< NewScore ->
/*updateBoard(),*/
    UpdateScore is Square
    ;
    write('\nSquare Invalid!\n'),
    choseNewScore(Score, NewScore, UpdateScore)
    
    ).



removeFromBoard(Board, Piece, NewBoard).

