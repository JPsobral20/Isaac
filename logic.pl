startGame(PlayerD, PlayerL):-
    initialMatrix(InitialBoard),
    darkPlayer(DarkPlayer),
    lightPlayer(LightPlayer),
    gamePlacePhaseLoop(InitialBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer).
    /*gameScoringPhaseLoop(PlacePhaseBoard, PlayerD, PlayerL, ScorinPhaseBoard).*/


/*
checkIfAtLeatsOnePlayerCanPlay():-
    checkIfDarkCanPlay();
    checkIfLightCanPlay().
*/

gamePlacePhaseLoop(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer):-

    /*checkIfAtLeatsOnePlayerCanPlay(),*/
    placePhasePlayerDark(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer, NewBoard),
    placePhasePlayerLight(NewBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer, NewNewBoard),
    gamePlacePhaseLoop(NewNewBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer).



placePhasePlayerDark(Board, 'P', 'P', DarkPlayer, LightPlayer, NewBoard):-
    /*checkIfDarkCanPlay(),*/
    printBoard(Board),
    write('\n------------------ PLAYER Dark -------------------\n'),
    managePiece(DarkPlayer),
    manageColumn(Column),
    manageRow(Row),
    /*chooseDirection()*/
    /*removePiece(Dakplayer, NewDarkPlayer)*/

    /*change board*/
    NewBoard = Board.  %mudar 


placePhasePlayerLight(Board, 'P', 'P', DarkPlayer, LightPlayer, NewBoard):-
    /*checkIfLightCanPlay(),*/
    printBoard(Board),
    write('\n------------------ PLAYER Light -------------------\n\n'),
    managePiece(LightPlayer),
    manageColumn(Column),
    manageRow(Row),
    /*chooseDirection()*/
    /*removePiece(LightPlayer, NewLightPlayer)*/

    /*change board*/
    NewBoard = Board. %mudar




