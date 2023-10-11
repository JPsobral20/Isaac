/*Todos os predicados deste ficheiro analisam o input, relativamente às linhas e colunas inseridas pelo utilizador,
e se as mesmas estão dentro dos limites do tabuleiro. Caso não se satisfaca, pede novamente a informação.*/

% Manage Row
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