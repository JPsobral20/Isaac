startGame_PL_PL(Player1, Player2) :-
    initialBoard(InitialBoard),
    addWorkers(InitialBoard, WorkersBoard, Player1, Player2),
    gameLoop(WorkersBoard, Player1, Player2).


addWorkers(InitialBoard, WorkersBoard, 'P', 'P') :-
    printBoard(InitialBoard),
    write('\n------------------ PLAYER X -------------------\n\n'),
    write('1. Choose worker 1 cell.\n'),
    askCoords(InitialBoard, red, Worker1Board, empty),
    printBoard(Worker1Board),
    write('\n------------------ PLAYER O -------------------\n\n'),
    write('1. Choose worker 2 cell.\n'),
    askCoords(Worker1Board, red, WorkersBoard, empty),
    printBoard(WorkersBoard).
