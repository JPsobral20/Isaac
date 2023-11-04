access_character(String, N, Caractere):-
    sub_atom(String, N, 1, _, Caractere).



remove_piece(Board, Score, Player, NewBoard, UpdateScore):-
    write('\nChoose a square to remove a piece!\n'),
    choose_piece(Board, Score, Player, NewBoard, UpdateScore).

    

choose_piece(Board, Score, Player, NewBoard, UpdateScore):-
    manage_column(Column),
    manage_row(Row),
    NewRow is Row div 10,
    (Player == dark ->
    UpdateRow is 9 - NewRow,
    UpdateColumn is Column
    ;
    UpdateRow is NewRow,
    UpdateColumn is 9 - Column
    ),
    element_at(Board, UpdateRow, RowList),
    element_at(RowList, UpdateColumn, Element),
    (Element == 0 ->
    write('\nThat square is empty!\n'),
    remove_piece(Board, Score, Player, NewBoard, UpdateScore)
    ;
    check_player(Board, Player, Element, Score, NewBoard, UpdateScore)
    ).





check_player(Board, dark, Piece, Score, NewBoard, UpdateScore):-
    symbol(Piece, Code),
    access_character(Code, 1, Element),
    (Element \= 'L' ->
    check_can_remove(Board, Piece, Score, NewBoard, UpdateScore, dark)
    ;
    write('\nThat piece is from light player!\n'),
    remove_piece(Board, Score, dark, NewBoard, UpdateScore)
    ).

check_player(Board, light, Piece, Score, NewBoard, UpdateScore):-
    symbol(Piece, Code),
    access_character(Code, 1, Element),
    (Element \= 'D' ->
    check_can_remove(Board, Piece, Score, NewBoard, UpdateScore, light)
    ;
    write('\nThat piece is from dark player!\n'),
    remove_piece(Board, Score, light, NewBoard, UpdateScore)
    ).



check_can_remove(Board, Piece, Score, NewBoard, UpdateScore, Player):-
    (check_piece_matrix(Board, Piece) ->
    update_score(Board, Piece, Score, NewBoard, UpdateScore)
    ;
    write('\nCannot remove that piece!\n'),
    remove_piece(Board, Score, Player, NewBoard, UpdateScore)
    ).



check_piece_matrix([], _).
check_piece_matrix([Line|Rest], Piece):-
    check_piece_line(Line, Piece),
    check_piece_matrix(Rest, Piece).

check_piece_line([], _).
check_piece_line([Element|Rest], Piece):-
    symbol(Element, Code),
    sub_atom(Code, 1, _, 0, Substring),
    (Substring == Piece ->
    fail
    ;
    check_piece_line(Rest, Piece)
    ).


update_score(Board, Piece, Score, UpdateBoard, FinalScore):-

    index0(Piece, ScorePiece),
    count_pieces(Board, Piece, [], List, UpdateCounter),
    write('\nList: '), write(List), write('\n'),
    length(List, NPieces),
    ret_counters(0, Counters),
    NewScore is Score + (ScorePiece * NPieces * Counters),
    Result is ScorePiece * NPieces * Counters,
    write('\nYour Score in this round: '), write(Result), write('\n'),
    (NewScore > 99 -> 
    FinalScore is NewScore
    ;
    chose_new_score(Score, NewScore, UpdateScore),
    FinalScore is UpdateScore
    ).


index0(Element, Value) :-
    Element = Value-_-_.


ret_counters(0, 1).
ret_counters(1, 2).
ret_counters(2, 4).


count_pieces(Board, Piece, List, UpdatedList, UpdateCounter):- 
    (ret_real_row(Board, Piece, Row);
    (transpose(Board, NewBoard),
    ret_real_row(NewBoard, Piece, Row))),
    append_pieces(Row, Piece, List, NewList),
    write('\nNewList: '), write(NewList), write('\n'),
    check_counters(Row, 0, Counters),
    UpdateCounter = Counters,
    UpdatedList = NewList.


ret_real_row([], _, _):- fail.
ret_real_row(Board, Piece, RetRow):-
    member(RetRow, Board),
    consecutive_ones(RetRow, Piece).

consecutive_ones([Piece, Piece | _], Piece).
consecutive_ones([_ | Rest], Piece) :- consecutive_ones(Rest, Piece).


append_pieces([], _, List, NewList):-
    NewList = List.

append_pieces([Element|Rest], Piece, List, NewList):-
    (Element == Piece;
    Element == 0;
    member(Element, List)),
    write('\nList in append: '), write(List), write('\n'),
    append_pieces(Rest, Piece, List, NewList).

append_pieces([Element|Rest], Piece, List, NewList):-
    Element \= Piece,
    Element \= 0,
    \+ member(Element, List),
    append(List, [Element], NList),
    append_pieces(Rest, Piece, NList, NewList).

check_counters(_, Counter, UpdateCounter):-
    UpdateCounter = Counter.
check_counters([Element|Rest], Counter, UpdateCounter):-
    symbol(Element, Code),
    sub_atom(Code, 0, 1, _, Substring),
    (Substring == 'X'; Substring == 'O' ->
    UpdateCounter is Counter + 1,
    check_counters(Rest, UpdateCounter, NewCounter)
    ;
    check_counters(Rest, Counter, UpdateCounter)
    ).



chose_new_score(Score, NewScore, UpdateScore):-

    write('\nWhich square do you want to go to?\n'),
    manage_column(Column),
    manage_row(Row),
    Square is Column + Row,
    (Square >= Score, Square =< NewScore ->
/*updateBoard(),*/
    UpdateScore is Square
    ;
    write('\nSquare Invalid!\n'),
    chose_new_score(Score, NewScore, UpdateScore)
    
    ).



remove_from_board(Board, Piece, NewBoard).

