startGame(PlayerD, PlayerL):-
    initialMatrix(InitialBoard),
    darkPlayer(DarkPlayer),
    lightPlayer(LightPlayer),
    placementPhaseLoop(InitialBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer).
    /*scoringPhaseLoop(PlacePhaseBoard, PlayerD, PlayerL, ScorinPhaseBoard).*/


/*
checkIfAtLeatsOnePlayerCanPlay():-
    checkIfDarkCanPlay();
    checkIfLightCanPlay().
*/

placementPhaseLoop(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer):-

    /*checkIfAtLeatsOnePlayerCanPlay(),*/
    placePhasePlayerDark(Board, PlayerD, PlayerL, DarkPlayer, NewBoard, NewDarkPlayer),
    placePhasePlayerLight(NewBoard, PlayerD, PlayerL, LightPlayer, NewNewBoard, NewLightPlayer),
    placementPhaseLoop(NewNewBoard, PlayerD, PlayerL, NewDarkPlayer, LightPlayer). %mudar



placePhasePlayerDark(Board, 'P', 'P', DarkPlayer, NewBoard, NewDarkPlayer):-
    /*checkIfDarkCanPlay(),*/
    printBoard(Board),
    write('\n------------------ PLAYER Dark -------------------\n'),
    managePiece(DarkPlayer, Piece),
    manageColumn(Column),
    manageRow(Row),
    /*chooseDirection()*/
    decrementPiece(DarkPlayer, Piece, NewDarkPlayer),

    /*change board*/
    NewBoard = Board.  %mudar 


placePhasePlayerLight(Board, 'P', 'P', LightPlayer, NewBoard, NewLightPlayer):-
    /*checkIfLightCanPlay(),*/
    printBoard(Board),
    write('\n------------------ PLAYER Light -------------------\n\n'),
    managePiece(LightPlayer, Piece),
    manageColumn(Column),
    manageRow(Row),
    /*chooseDirection()*/
    /*decrementPiece(LightPlayer, NewLightPlayer)*/

    /*change board*/
    NewBoard = Board. %mudar




