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
    /* Secalhar precisa de refactoring esta parte para baixo*/
    write('\n Your pieces (DarkPlayer):'),
    printMenuPieces(1,DarkPlayer),
    printMenuPieces(2,DarkPlayer),
    printMenuPieces(3,DarkPlayer),
    printMenuPieces(4,DarkPlayer),
    printMenuPieces(6,DarkPlayer), 
    write('\n\n------------------ PLAYER Dark -------------------\n'),
    managePiece(DarkPlayer, Piece),     %verifivar_se_consegue_jogar_a_peca_que_escolheu
    manageSquareDark(Board, Column, Row),
    chooseDirection(Column, Row, Piece, Board, Direction),
    decrementPiece(DarkPlayer, Piece, NewDarkPlayer),

    /*change board*/
    NewBoard = Board.  %mudar 


placePhasePlayerLight(Board, 'P', 'P', LightPlayer, NewBoard, NewLightPlayer):-
    /*checkIfLightCanPlay(),*/
    printBoard(Board),
    /* Secalhar precisa de refactoring esta parte para baixo*/
    write('\n Your pieces (LightPlayer):'),
    printMenuPieces(1,LightPlayer),
    printMenuPieces(2,LightPlayer),
    printMenuPieces(3,LightPlayer),
    printMenuPieces(4,LightPlayer),
    printMenuPieces(6,LightPlayer), 
    write('\n\n------------------ PLAYER Light -------------------\n\n'),
    managePiece(LightPlayer, Piece),    %verifivar_se_consegue_jogar_a_peca_que_escolheu
    manageSquareLight(Board, Column, Row),
    chooseDirection(Column, Row, Piece, Board, Direction),
    decrementPiece(LightPlayer, Piece, NewLightPlayer),


    /*change board*/
    NewBoard = Board. %mudar




