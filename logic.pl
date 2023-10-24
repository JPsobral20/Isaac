startGame(PlayerD, PlayerL):-
    initialMatrix(InitialBoard),
    darkPlayer(DarkPlayer),
    lightPlayer(LightPlayer),
    placementPhaseLoop(InitialBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer, FinalBoard).
    /*printEndPlacementPhase(),*/
    /*scoringPhaseLoop(PlacePhaseBoard, PlayerD, PlayerL, ScorinPhaseBoard).*/

/*
printHaveToPass(Player):-
*/



% Checks if a variable is empty
var_empty(X):-
    var(X).

% A loop that allows players to place their pieces on the board alternately until the placement phase is completed (when they can not place any more pieces on the board)
placementPhaseLoop(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer, FinalBoard):-

   
    (checkIfPlayerCanPlay(Board, DarkPlayer) -> 
    placePhasePlayerDark(Board, PlayerD, DarkPlayer, NewBoard, NewDarkPlayer)
    ;
    /*printHaveToPass(dark),*/
    true
    ),

    (var_empty(NewBoard) -> NewBoard = Board, NewDarkPlayer = DarkPlayer ; true),
    
  

    (checkIfPlayerCanPlay(NewBoard, LightPlayer) ->
    
    placePhasePlayerLight(NewBoard, PlayerL, LightPlayer, NewNewBoard, NewLightPlayer)
    ;
    /*printHaveToPass(light)*/
    true
    ),
    
    (var_empty(NewNewBoard) -> NewNewBoard = NewBoard, NewLightPlayer = LightPlayer ; true),
    
    (Board == NewNewBoard -> FinalBoard = Board; placementPhaseLoop(NewNewBoard, PlayerD, PlayerL, NewDarkPlayer, NewLightPlayer, _)).


% The actions of the placement phase for the DarkPlayer 
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
    managePiece(DarkPlayer, Piece, Board), % Choose the piece to place
    manageSquareDark(Board, Column, Row, Piece), % Choose the square to place the piece 
    chooseDirection(Column, Row, Piece, Board, Direction), % Choose the direction to place the piece
    printPieceOnBoard(Column, Row, Piece, Board, Direction, DarkPlayer, "D", AfterBoard), % Place the piece on the board
    decrementPiece(DarkPlayer, Piece, UpdateDarkPlayer), % Decrement the number of pieces for that piece in the player
    NewDarkPlayer = UpdateDarkPlayer, % Update the player list with the new number of pieces
   
    NewBoard = AfterBoard. % Update the board with the new piece placed

% The actions of the placement phase for the LightPlayer
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
    managePiece(LightPlayer, Piece, Board), % Choose the piece to place
    manageSquareLight(Board, Column, Row, Piece),  % Choose the square to place the piece      
    chooseDirection(Column, Row, Piece, Board, Direction), % Choose the direction to place the piece
    printPieceOnBoard(Column, Row, Piece, Board, Direction, LightPlayer, "L", AfterBoard), % Place the piece on the board
    decrementPiece(LightPlayer, Piece, UpdateLightPlayer), % Decrement the number of pieces for that piece in the player
    NewLightPlayer = UpdateLightPlayer, % Update the player list with the new number of pieces

    NewBoard = AfterBoard. % Update the board with the new piece placed




