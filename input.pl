/*Todos os predicados deste ficheiro analisam o input, relativamente às linhas e colunas inseridas pelo utilizador,
e se as mesmas estão dentro dos limites do tabuleiro. Caso não se satisfaca, pede novamente a informação.*/

manageRow(NewRow):-
    readRow(Row),
    validateRow(Row, NewRow).

manageColumn(NewColumn):-
    readColumn(Column),
    validateColumn(Column, NewColumn).

readRow(Row):-
    write('Insert row: '),
    read(Row).

readColumn(Column):-
    write('Insert column: '),
    read(Column).

validateRow(0, NewRow):-
    NewRow = 1.

validateRow(10, NewRow):-
    NewRow = 2.

validateRow(20, NewRow):-
    NewRow = 3.

validateRow(30, NewRow):-
    NewRow = 4.

validateRow(40, NewRow):-
    NewRow = 5.

validateRow(50, NewRow):-
    NewRow = 6.

validateRow(60, NewRow):-
    NewRow = 7.

validateRow(70, NewRow):-
    NewRow = 8.

validateRow(80, NewRow):-
    NewRow = 9.

validateRow(90, NewRow):-
    NewRow = 10.

validateRow(_Row, NewRow):-
    write('That row is not valid!\n\n'),
    readRow(Input),
    validateRow(Input, NewRow).



validateColumn(0, NewColumn):-
    NewColumn = 1.

validateColumn(1, NewColumn):-
    NewColumn = 2.

validateColumn(2, NewColumn):-
    NewColumn = 3.

validateColumn(3, NewColumn):-
    NewColumn = 4.

validateColumn(4, NewColumn):-
    NewColumn = 5.

validateColumn(5, NewColumn):-
    NewColumn = 6.

validateColumn(6, NewColumn):-
    NewColumn = 7.

validateColumn(7, NewColumn):-
    NewColumn = 8.

validateColumn(8, NewColumn):-
    NewColumn = 9.

validateColumn(9, NewColumn):-
    NewColumn = 10.


validateColumn(_Column, NewColumn):-
    write('That column is not valid!\n\n'),
    readColumn(Input),
    validateColumn(Input, NewColumn).

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