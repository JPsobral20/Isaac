startGame(PlayerD, PlayerL):-
    initialMatrix(InitialBoard),
    darkPlayer(DarkPlayer),
    lightPlayer(LightPlayer),
    placementPhaseLoop(InitialBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer, FinalBoard).
    /*printEndPlacementPhase(),*/
    /*scoringPhaseLoop(PlacePhaseBoard, PlayerD, PlayerL, ScorinPhaseBoard).*/




var_empty(X):-
    var(X).

placementPhaseLoop(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer, FinalBoard):-

   
    (checkIfPlayerCanPlay(Board, DarkPlayer) -> 
    placePhasePlayerDark(Board, PlayerD, DarkPlayer, NewBoard, NewDarkPlayer)
    ;
    true
    ),

    (var_empty(NewBoard) -> NewBoard = Board, NewDarkPlayer = DarkPlayer ; true),
    
  

    (checkIfPlayerCanPlay(NewBoard, LightPlayer) ->
    
    placePhasePlayerLight(NewBoard, PlayerL, LightPlayer, NewNewBoard, NewLightPlayer)
    ;
    true
    ),
    
    (var_empty(NewNewBoard) -> NewNewBoard = NewBoard, NewLightPlayer = LightPlayer ; true),
    
    (Board == NewNewBoard -> FinalBoard = Board; placementPhaseLoop(NewNewBoard, PlayerD, PlayerL, NewDarkPlayer, NewLightPlayer, _)).



placePhasePlayerDark(Board, 'P', DarkPlayer, NewBoard, NewDarkPlayer):-
    printBoard(Board),
    /* Secalhar precisa de refactoring esta parte para baixo*/
    write('\n Your pieces (DarkPlayer):'),
    printMenuPieces(1,DarkPlayer),
    printMenuPieces(2,DarkPlayer),
    printMenuPieces(3,DarkPlayer),
    printMenuPieces(4,DarkPlayer),
    printMenuPieces(6,DarkPlayer), 
    write('\n\n------------------ PLAYER Dark -------------------\n'),
    managePiece(DarkPlayer, Piece, Board),
    manageSquareDark(Board, Column, Row, Piece),       
    chooseDirection(Column, Row, Piece, Board, Direction),
    printPieceOnBoard(Column, Row, Piece, Board, Direction, DarkPlayer, "D", AfterBoard),
    decrementPiece(DarkPlayer, Piece, UpdateDarkPlayer),
    NewDarkPlayer = UpdateDarkPlayer,
    /*change board*/
    NewBoard = AfterBoard. 


placePhasePlayerLight(Board, 'P', LightPlayer, NewBoard, NewLightPlayer):-
    printBoard(Board),
    /* Secalhar precisa de refactoring esta parte para baixo*/
    write('\n Your pieces (LightPlayer):'),
    printMenuPieces(1,LightPlayer),
    printMenuPieces(2,LightPlayer),
    printMenuPieces(3,LightPlayer),
    printMenuPieces(4,LightPlayer),
    printMenuPieces(6,LightPlayer), 
    write('\n\n------------------ PLAYER Light -------------------\n\n'),
    managePiece(LightPlayer, Piece, Board),
    manageSquareLight(Board, Column, Row, Piece),      
    chooseDirection(Column, Row, Piece, Board, Direction),
    printPieceOnBoard(Column, Row, Piece, Board, Direction, LightPlayer, "L", AfterBoard),
    decrementPiece(LightPlayer, Piece, UpdateLightPlayer),
    NewLightPlayer = UpdateLightPlayer,
    /*change board*/
    NewBoard = AfterBoard. 




