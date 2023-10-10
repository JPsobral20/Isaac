/*Todos os predicados deste ficheiro analisam o input, relativamente às linhas e colunas inseridas pelo utilizador,
e se as mesmas estão dentro dos limites do tabuleiro. Caso não se satisfaca, pede novamente a informação.*/

manageRow(NewRow):-
    write('\nChoose a row: '),
    read(Row),
    validateRow(Row),
    updateRow(Row, NewRow).

manageColumn(Column):-
    write('\nChoose a column: '),
    read(Column),
    validateColumn(Column).

updateRow(Row, NewRow):-
    NewRow is Row / 10.

validateRow(Row):-
    \+ member(Row, [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]),
    write('\nThat row is not valid!\n'),
    write('\nChoose a row: '),
    read(Input),
    validateRow(Input).


validateColumn(Column):-
    \+ member(Column, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]),
    write('\nThat column is not valid!\n'),
    write('\nChoose a column: '),
    read(Input),
    validateColumn(Input).

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