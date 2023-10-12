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


checkPieceInputValid(N, Player):-
    \+ member(N, [1, 2, 3, 4, 6]),
    write('\nERROR: invalid piece!\n\n'),
    write('Choose a piece: '),
    read(Input),
    checkPieceInputValid(Input, Player).
    /*, !.*/


checkPieceInputValid(N, Player):-
    member(N, [1, 2, 3, 4, 6]),
    checkHavePiece(N, Player).



checkHavePiece(N, Player):-
    elementAtIndex(N, Player, Ele),
    havePiece(Ele, Player).


havePiece([0|S], Player):-
    write('\nNão tem peças de score '),
    write(S),
    write('\nEscolha outra!\n'),
    managePiece(Player).
    
havePiece([N|S], Player):-
    N \= 0,
    write('\n Tem '),
    write(N),
    write(' peças de score '),
    write(S).


managePiece(Player):-
    write('\nChoose a piece: '),
    read(Input),
    checkPieceInputValid(Input, Player).
    







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