startGame(PlayerD, PlayerL):-
    initialMatrix(InitialBoard),
    darkPlayer(DarkPlayer),
    lightPlayer(LightPlayer),
    placementPhaseLoop(InitialBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer, FinalPlacementPhaseBoard, FinalDarkPlayer, FinalLightPlayer, FinalPlayer),
    write(FinalPlayer),nl,
    printEndPlacementPhase,
    /*placeScores(FinalPlacementPhaseBoard, UpdatedBoard),*/
    scoringPhaseLoop(FinalPlacementPhaseBoard, PlayerD, PlayerL, 0, 0, FinalScoreDark, FinalScoreLight, FinalPlayer),
    printEndOfGame,
    checkWhoWon(FinalScoreDark, FinalScoreLight, FinalDarkPlayer, FinalLightPlayer).

printHaveToPassPlacementPhase(Player):-
    write('\n\n------------------ PLAYER '),
    write(Player),
    write(' -------------------\n\n'),
    write('Have to pass this turn because you can not place any more pieces on the board.\n\n').


printHaveToPassScoringPhase(Player):-
    write('\n\n------------------ PLAYER '),
    write(Player),
    write(' -------------------\n\n'),
    write('Have to pass this turn because you can not remove pieces from the board.\n\n').


printEndPlacementPhase:-
    write('\n\n------------------ END OF PLACEMENT PHASE -------------------\n\n'),
    write('The placement phase is over because both players can not place any more pieces on the board.\n\n'),
    write('The game will now proceed to the scoring phase.\n\n').


printEndOfGame:-
    write('\n\n------------------ END OF SCORING PHASE -------------------\n\n'),
    write('The scoring phase is over because both players can not remove any more pieces on the board.\n\n').



% Checks if a variable is empty
var_empty(X):-
    var(X).

% A loop that allows players to place their pieces on the board alternately until the placement phase is completed (when they can not place any more pieces on the board)
placementPhaseLoop(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer, FinalBoard, UpdateDarkPlayer, UpdateLightPlayer, FinalPlayer):-

   
    (checkIfCanPlayPlacementPhase(Board, DarkPlayer) -> 

        placementPhasePlayerDark(Board, PlayerD, DarkPlayer, NewBoard, NewDarkPlayer)
        ;
        printHaveToPassPlacementPhase(dark),
        (var_empty(FinalPlayer) -> FinalPlayer = dark ; true)

    ),

    (var_empty(NewBoard) -> NewBoard = Board, NewDarkPlayer = DarkPlayer ; true),
    
    UpdateDarkPlayer = NewDarkPlayer,

    (checkIfCanPlayPlacementPhase(NewBoard, LightPlayer) ->
    
        placementPhasePlayerLight(NewBoard, PlayerL, LightPlayer, NewNewBoard, NewLightPlayer)
        ;
        printHaveToPassPlacementPhase(light),
        (var_empty(FinalPlayer) -> FinalPlayer = light ; true)

    ),

    UpdateLightPlayer = NewLightPlayer,

    (var_empty(NewNewBoard) -> NewNewBoard = NewBoard, NewLightPlayer = LightPlayer ; true),
    
    (Board == NewNewBoard -> FinalBoard = Board; placementPhaseLoop(NewNewBoard, PlayerD, PlayerL, NewDarkPlayer, NewLightPlayer, FinalBoard, _, _, FinalPlayer)).



% The actions of the placement phase for the DarkPlayer 
placementPhasePlayerDark(Board, 'P', DarkPlayer, NewBoard, NewDarkPlayer):-
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
placementPhasePlayerLight(Board, 'P', LightPlayer, NewBoard, NewLightPlayer):-
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






% Scoring phase

scoringPhaseLoop(Board, PlayerD, PlayerL, ScoreDark, ScoreLight, FinalScoreDark, FinalScoreLight, dark):-

    (checkIfCanPlayScoringPhase(Board, dark), ScoreDark < 100, ScoreLight < 100 -> 
    
        scoringPhasePlayerDark(Board, PlayerD, NewBoard, ScoreDark, UpdatedScoreDark)
        ;
        printHaveToPassScoringPhase(dark)
        
    ),

    (var_empty(NewBoard) -> NewBoard = Board, UpdatedScoreDark = ScoreDark ; true),


    (checkIfCanPlayScoringPhase(NewBoard, light), UpdatedScoreDark < 100, ScoreLight < 100 -> 
    
        scoringPhasePlayerLight(NewBoard, PlayerL, NewNewBoard, ScoreLight, UpdatedScoreLight)
        ;
        printHaveToPassScoringPhase(light)
        
    ),

    (var_empty(NewBoard) -> NewNewBoard = NewBoard, UpdatedScoreLight = ScoreLight ; true),

    (Board == NewNewBoard -> FinalScoreDark = ScoreDark, FinalScoreLight = ScoreLight ; scoringPhaseLoop(NewNewBoard, PlayerD, PlayerL, UpdatedScoreDark, UpdatedScoreLight, FinalDarkPlayer, FinalLightPlayer, dark)).


    


scoringPhaseLoop(Board, PlayerD, PlayerL, ScoreDark, ScoreLight, FinalScoreDark, FinalScoreLight, light):-


    (checkIfCanPlayScoringPhase(Board, light), ScoreDark < 100, ScoreLight < 100 -> 
    
        scoringPhasePlayerLight(Board, PlayerL, NewBoard, ScoreLight, UpdatedScoreLight)
        ;
        printHaveToPassScoringPhase(light)
        
    ),

    (var_empty(NewBoard) -> NewBoard = Board, UpdatedScoreLight = ScoreLight ; true),


    (checkIfCanPlayScoringPhase(NewBoard, dark), UpdatedScoreLight < 100, ScoreDark < 100 -> 
    
        scoringPhasePlayerDark(NewBoard, PlayerL, NewNewBoard, ScoreDark, UpdatedScoreDark)
        ;
        printHaveToPassScoringPhase(dark)
        
    ),

    (var_empty(NewBoard) -> NewNewBoard = NewBoard ; true),

    (Board == NewNewBoard -> FinalScoreDark = ScoreDark, FinalScoreLight = ScoreLight ; scoringPhaseLoop(NewNewBoard, PlayerD, PlayerL, UpdatedScoreDark, UpdatedScoreLight, FinalDarkPlayer, FinalLightPlayer, light)).





scoringPhasePlayerDark(Board, 'P', NewBoard, ScoreDark, UpdatedScoreDark):-

    printBoard(Board),
    write('\n\n------------------ PLAYER Dark -------------------\n'),
    removePice(Board, ScoreDark, dark, NewBoard, UpdatedScoreDark),
    NewBoard = Board.


    
scoringPhasePlayerLight(Board, 'P', NewBoard, ScoreLight, UpdatedScoreLight):-

    printBoard(Board),
    write('\n\n------------------ PLAYER Light ------------------\n'),
    removePice(Board, ScoreLight, light, NewBoard, UpdatedScoreLight),
    NewBoard = Board.



checkWhoWon(FinalScoreDark, FinalScoreLight, FinalDarkPlayer, FinalLightPlayer):-
    pieceLength(FinalDarkPlayer, LengthDark),
    pieceLength(FinalLightPlayer, LengthLight),

    (FinalScoreDark == FinalScoreLight ->
    
        (LengthDark == LengthLight -> 

            win(dark)
            ;
            (LengthDark > LengthLight ->
            
                win(dark)
                ;
                win(light)
            )    
        )

        ;

        (FinalScoreDark > FinalScoreLight ->
        
            win(dark)
            ;
            win(light)
        )

    ).



checkIfCanPlayScoringPhase(Board, dark).





checkIfCanPlayScoringPhase(Board, light).



pieceLength(List, Sum):-
    multiply_and_sum_helper(List, 0, Sum).


multiply_and_sum_helper([], Acc, Acc).
multiply_and_sum_helper([[X, Y] | Rest], Acc, Sum) :-
    NewAcc is Acc + X * Y,
    multiply_and_sum_helper(Rest, NewAcc, Sum).






win(dark):-
    write('\nCongratulations dark player, you won!\n'),nl,nl,
    write('\nPress any key to continue!\n'),
    read(_).


win(light):-
    write('\nCongratulations light player, you won!\n'),nl,nl,
    write('\nPress any key to continue!\n'),
    read(_).
