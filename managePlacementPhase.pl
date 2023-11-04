% Checks if player can play horizontally and vertically
check_can_play_placement_phase(Board, Player):-
    check_horizontal(Board, Player);
    (transpose(Board, NewBoard),
    check_horizontal(NewBoard, Player)).


check_horizontal(_, []):- 
    fail.

check_horizontal(Board, [Piece|Rest]):-
    element_at(Piece, 0, NumberPieces),
    element_at(Piece, 1, Score),
    score_length(Score, Length),

    (NumberPieces \= 0 ->

        check_consecutive_zeros(Board, Length)
        ;
        check_horizontal(Board, Rest)
    
    ).

% Check consecutive zeros
check_consecutive_zeros(Matrix, N):-
    member(Row, Matrix),
    check_consecutive_zeros_line(Row, 0, N).

% Check consecutive zeros in a line
check_consecutive_zeros_line(_, Count, N):-
    Count =:= N.       

check_consecutive_zeros_line([0|Rest], Count, N):-
    NewCount is Count + 1,
    check_consecutive_zeros_line(Rest, NewCount, N).

check_consecutive_zeros_line([Ele|Rest], _, N):-
    Ele \= 0,
    check_consecutive_zeros_line(Rest, 0, N).




check_positions(_, _, _, _, 0, FinalLength):-
    FinalLength = 0.

check_positions(Direction, Board, Column, Row, Length, FinalLength):-
    Length > 0,
    element_at(Board, Row, RowList),
    element_at(RowList, Column, Element),
    (Element =:= 0 ->
        update_column_and_row(Direction, Column, Row, NewColumn, NewRow),
        NewLength is Length - 1,
        check_positions(Direction, Board, NewColumn, NewRow, NewLength, FinalLength)
    ;
        FinalLength = Length
    ).

update_column_and_row(up, Column, Row, NewColumn, NewRow):-
    NewColumn is Column,
    NewRow is Row - 1.

update_column_and_row(down, Column, Row, NewColumn, NewRow):-
    NewColumn is Column,
    NewRow is Row + 1.

update_column_and_row(right, Column, Row, NewColumn, NewRow):-
    NewRow is Row,
    NewColumn is Column + 1.

update_column_and_row(left, Column, Row, NewColumn, NewRow):-
    NewRow is Row,
    NewColumn is Column - 1.



% Access an element in a list given a position
element_at(List, Index, Element):-
    element_at(List, Index, 0, Element).

element_at([Head|_], Index, Index, Head).
element_at([_|Tail], Index, CurrentIndex, Element):-
    NextIndex is CurrentIndex + 1,
    element_at(Tail, Index, NextIndex, Element).


% Checks if Element is 6
check_piece6(6, UpdatedInput):-
   UpdatedInput is 6 - 1.

check_piece6(Input, UpdatedInput):-
    Input \= 6,
    UpdatedInput = Input.




% Manage Piece


% Choosing piece
manage_piece(Player, Piece, Board):-
    write('\nChoose a piece: '),
    read(Input),
    check_piece_input_valid(Input, Player, Piece, Board).

% Checks if the input is valid
check_piece_input_valid(N, Player, Piece, Board):-
    (\+ member(N, [1, 2, 3, 4, 6]);
    \+ number(N)),
    write('\nERROR: invalid piece!\n'),
    write('\nChoose other piece: '),
    read(Input),
    check_piece_input_valid(Input, Player, Piece, Board).
    /*, !.*/

check_piece_input_valid(N, Player, Piece, Board):-
    number(N),
    member(N, [1, 2, 3, 4, 6]),
    select_piece(N, Player, Piece, Board).


% Select piece
select_piece(N, Player, Piece, Board):-
    check_piece6(N, UpdatedInput),
    NewN is UpdatedInput - 1,
    element_at(Player, NewN, Ele),
    check_have_piece(Ele, Player, Piece, Board).


% Checks if player has the piece
check_have_piece([0|_], Player, Piece, Board):-
    write('\nDont have that piece!\n'),
    write('\nChoose other!\n'),
    manage_piece(Player, Piece, Board).
    
check_have_piece([N|S], Player, Piece, Board):-
    N \= 0,
    element_at(S, 0, Score),
    score_length(Score, Length),
    (can_play_piece(Length, Board) ->
    Piece is S
    ;
    write('\nCant play that piece!\n'),
    manage_piece(Player, Piece, Board)
    ).

% Checks if the player can play the piece he chose
can_play_piece(Length, Board):-
    check_consecutive_zeros(Board, Length);
    (transpose(Board, NewBoard),
    check_consecutive_zeros(NewBoard, Length)).





% Manage Square 


% Choosing row and column of dark player
manage_square_dark(Board, RetColumn, RetRow, Piece):-
    manage_column(Column),
    manage_row(Row),
    NewRow is 90 - Row,
    check_empty_square(Board, Column, NewRow, dark, RetColumn, RetRow, Piece).


% Choosing row and column of light player
manage_square_light(Board, RetColumn, RetRow, Piece):-
    manage_column(Column),
    manage_row(Row),
    NewColumn is 9 - Column,
    check_empty_square(Board, NewColumn, Row, light, RetColumn, RetRow, Piece).


% Choosing column
manage_column(NewColumn):-
    write('\nChoose a column: '),
    read(Column),
    validate_column(Column, NewColumn).

% Validates the column input
validate_column(Column, NewColumn):-
    valid_column(Column), !,
    NewColumn is Column.

validate_column(_, NewColumn):-
    write('\nThat column is not valid!\n'),
    manage_column(NewColumn).

valid_column(Column):-
    number(Column),
    member(Column, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).


% Choosing row
manage_row(NewRow):-
    write('\nChoose a row: '),
    read(Row),
    validate_row(Row, NewRow).

% Validates the row input
validate_row(Row, NewRow):-
    valid_row(Row), !,
    NewRow is Row.

validate_row(_, NewRow):-
    write('\nThat row is not valid!\n'),
    manage_row(NewRow).

valid_row(Row):-
    number(Row),
    member(Row, [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]).


% Checks if the square that he chose is empty
check_empty_square(Board, Column, Row, Player, RetColumn, RetRow, Piece):-
    NewRow is Row div 10,
    element_at(Board, NewRow, RowList),
    element_at(RowList, Column, Element),
    check_elem(Element, Board, Player, Column, NewRow, RetColumn, RetRow, Piece).


% Checks if element is empty
 check_elem(Element, Board, dark, _, _, RetColumn, RetRow, Piece):-
    Element \= 0,
    write('\nThat square is not empty!\n'),
    manage_square_dark(Board, RetColumn, RetRow, Piece).

 check_elem(Element, Board, light, _, _, RetColumn, RetRow, Piece):-
    Element \= 0,
    write('\nThat square is not empty!\n'),
    manage_square_light(Board, RetColumn, RetRow, Piece).

 check_elem(0, Board, dark, Column, Row, RetColumn, RetRow, Piece):-
    ( check_can_play_piece(Board, Column, Row, Piece) ->

        RetColumn is Column,
        RetRow is Row
    ;
        write('\nCant play piece there!\n'),
        manage_square_dark(Board, RetColumn, RetRow, Piece)
    ).

 check_elem(0, Board, light, Column, Row, RetColumn, RetRow, Piece):-
    ( check_can_play_piece(Board, Column, Row, Piece) ->

    RetColumn is Column,
    RetRow is Row
    ;
    write('\nCant play piece there!\n'),
    manage_square_light(Board, RetColumn, RetRow, Piece)
    ).

% Checks if piece can be place in that square
 check_can_play_piece(Board, Column, Row, Piece):-
    check_valid_move(right, Column, Row, Piece, Board);
    check_valid_move(left, Column, Row, Piece, Board);
    check_valid_move(up, Column, Row, Piece, Board);
    check_valid_move(down, Column, Row, Piece, Board).

check_valid_move(Direction, Column, Row, Piece, Board):-
    score_length(Piece, Length),
    check_positions(Direction, Board, Column, Row, Length, Success),
    (Success =:= 0 -> true ; fail).



% Manage Direction


% Choose Direction
choose_direction(Column, Row, Piece, Board, RetDirection):- 
    write('\nChoose a direction (up,down,left,right): '),
    read(Direction),
    validate_direction(Direction, Column, Row, Piece, Board, RetDirection).


validate_direction(Direction, Column, Row, Piece, Board, RetDirection):-
    \+ member(Direction, [up, down, left, right]),
    write('\nThat direction is not valid!\n'),
    write('\nChoose another direction (up,down,left,right): '),
    read(NewDirection),
    validate_direction(NewDirection, Column, Row, Piece, Board, RetDirection).

validate_direction(Direction, Column, Row, Piece, Board, RetDirection):-
    member(Direction, [up, down, left, right]),
    score_length(Piece, Length),
    check_direction(Direction, Column, Row, Length, Board, RetDirection).

check_direction(up, Column, Row, Length, Board, RetDirection):-  
    (Row - (Length - 1) >= 0 ->
        valid_move(up, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        score_length(Piece, Length),
        choose_direction(Column, Row, Piece, Board, RetDirection)
    ).

check_direction(down, Column, Row, Length, Board, RetDirection):-
    (Row + (Length - 1) =< 9 ->
        valid_move(down, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        score_length(Piece, Length),
        choose_direction(Column, Row, Piece, Board, RetDirection)
    ).

check_direction(left, Column, Row, Length, Board, RetDirection):-
    (Column - (Length - 1) >= 0 ->
        valid_move(left, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        score_length(Piece, Length),
        choose_direction(Column, Row, Piece, Board, RetDirection)
    ).

check_direction(right, Column, Row, Length, Board, RetDirection):-
    (Column + (Length - 1) =< 9  ->
        valid_move(right, Column, Row, Length, Board, RetDirection)
    ;
        write('\nThat direction is not valid!\n'),
        score_length(Piece, Length),
        choose_direction(Column, Row, Piece, Board, RetDirection)
    ).


valid_move(Direction, Column, Row, Length, Board, RetDirection):-
    check_positions(Direction, Board, Column, Row, Length, Success),
    score_length(Piece, Length),
    (Success =:= 0 -> RetDirection = Direction ; write('\nThat direction is not valid!\n'), choose_direction(Column, Row, Piece, Board, RetDirection)).




% Print Piece On Board

print_piece_board(Column, Row, Piece, Board, right, Player, Acronym, AfterBoard):-
    get_number_piece(Piece,Player,Number),
    Element = Piece-Acronym-Number,
    element_at(Board, Row, RowList),
    score_length(Piece, Length),
    NewLength is Length - 1,
    update_row(RowList, Column, NewLength, Element, UpdatedRow),
    replace_row_board(Board, Row, UpdatedRow, AfterBoard).
    
print_piece_board(Column, Row, Piece, Board, left, Player, Acronym, AfterBoard):-
    get_number_piece(Piece,Player,Number),
    Element = Piece-Acronym-Number, 
    element_at(Board, Row, RowList),
    score_length(Piece, Length),
    NewLength is Length - 1,
    NewColumn is Column - (Length) + 1,
    update_row(RowList, NewColumn, NewLength, Element, UpdatedRow),
    replace_row_board(Board, Row, UpdatedRow, AfterBoard).

print_piece_board(Column, Row, Piece, Board, down, Player, Acronym, AfterBoard):-
    get_number_piece(Piece,Player,Number),
    Element = Piece-Acronym-Number,
    score_length(Piece, Length),
    NewRow is Row + Length,
    update_column(Board, Column, Row, NewRow, Element, AfterBoard).

print_piece_board(Column, Row, Piece, Board, up, Player, Acronym, AfterBoard):-
    get_number_piece(Piece,Player,Number),
    Element = Piece-Acronym-Number,
    score_length(Piece, Length),
    NewRow is Row - (Length - 1), % Dividi-se por 10 e depois tiramos o tamanho da peça - 1 para obter a linha inicial
    NewRowEnd is NewRow + Length,
    update_column(Board, Column, NewRow, NewRowEnd, Element, AfterBoard).

update_column(Board, _, EndRow, EndRow, _, Board).

update_column(Board, Column, RowIndex, EndRow, Piece, UpdatedBoard) :-
    element_at(Board, RowIndex, RowList),
    update_row(RowList, Column, 0, Piece, UpdatedRow),
    NewRowIndex is RowIndex + 1,
    update_column(Board, Column, NewRowIndex, EndRow, Piece, RestOfBoard),
    replace_row_board(RestOfBoard, RowIndex, UpdatedRow, UpdatedBoard).


% Update the row in a new Board
replace_row_board([], _, _, []).
replace_row_board([_|T], 0, NewRow, [NewRow|T]).
replace_row_board([H|T], Index, NewRow, [H|NewT]) :-
    Index > 0,
    NewIndex is Index - 1,
    replace_row_board(T, NewIndex, NewRow, NewT).

% Change the row to the new element

update_row([], _, _, _, []).
update_row([_|T], 0, 0, NewElement, [NewElement|T]). % It is the first in the list
update_row([_|T], 0, NTimesElement, NewElement, [NewElement|NewT]) :- % When it reaches the interval it will replace the element and do the recursion for the rest (tail)
    NTimesElement > 0,
    NewNTimesElement is NTimesElement - 1,
    update_row(T, 0, NewNTimesElement, NewElement, NewT).
update_row([H|T], StartIndex, NTimesElement, NewElement, [H|NewT]) :- % If it has not yet reached the interval it will keep the head of the list and do the recursion for the rest (tail)
    StartIndex > 0,
    NewStartIndex is StartIndex - 1,
    update_row(T, NewStartIndex,  NTimesElement, NewElement, NewT).








% Decrement Piece


% Decrements the number of piece that he chose
decrement_piece([Sublist | Rest], N, NewDarkPlayer):-
    N > 1,
    check_piece6(N, NewN),
    N1 is NewN - 1,
    decrement_piece(Rest, N1, UpdatedRest),
    NewDarkPlayer = [Sublist | UpdatedRest].

decrement_piece([Sublist | Rest], 1, NewDarkPlayer):-
    [CurrentFirst | RestOfSublist] = Sublist,
    NewFirst is CurrentFirst - 1,
    UpdatedSublist = [NewFirst | RestOfSublist],
    NewDarkPlayer = [UpdatedSublist | Rest].

