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
    placementPhaseLoop(NewNewBoard, PlayerD, PlayerL, NewDarkPlayer, NewLightPlayer). 

placePhasePlayerDark(Board, 'P', 'P', DarkPlayer, NewBoard, NewDarkPlayer):-
    /*checkIfDarkCanPlay(),*/
    printBoard(Board),
    write('\n------------------ PLAYER Dark -------------------\n'),
    managePiece(DarkPlayer, Piece),     %verifivar_se_consegue_jogar_a_peca_que_escolheu
    manageColumn(Column),
    manageRow(Row),
    chooseDirection(Column, Row, Piece, Board),
    decrementPiece(DarkPlayer, Piece, NewDarkPlayer),

    /*change board*/
    NewBoard = Board.  %mudar 


placePhasePlayerLight(Board, 'P', 'P', LightPlayer, NewBoard, NewLightPlayer):-
    /*checkIfLightCanPlay(),*/
    printBoard(Board),
    write('\n------------------ PLAYER Light -------------------\n\n'),
    managePiece(LightPlayer, Piece),    %verifivar_se_consegue_jogar_a_peca_que_escolheu
    manageColumn(Column),
    manageRow(Row),
    /* ver se consegue jogar a peça na posição que escolheu*/
    chooseDirection(Column, Row, Piece, Board),
    decrementPiece(LightPlayer, Piece, NewLightPlayer),


    /*change board*/
    NewBoard = Board. %mudar




