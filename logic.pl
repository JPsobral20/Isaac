start_game(PlayerD, PlayerL):-
    initial_matrix(InitialBoard),
    dark_player(DarkPlayer),
    light_player(LightPlayer),
    placement_phase_loop(InitialBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer, FinalPlacementPhaseBoard, FinalDarkPlayer, FinalLightPlayer, FinalPlayer),

    print_end_placement_phase,
    /*placeScores(FinalPlacementPhaseBoard, UpdatedBoard),*/
    scoring_phase_loop(FinalPlacementPhaseBoard, PlayerD, PlayerL, 0, 0, FinalScoreDark, FinalScoreLight, FinalPlayer),
    print_end_game,
    check_who_won(FinalScoreDark, FinalScoreLight, FinalDarkPlayer, FinalLightPlayer).

print_pass_placement_phase(Player):-
    write('\n\n------------------ PLAYER '),
    write(Player),
    write(' -------------------\n\n'),
    write('Have to pass this turn because you can not place any more pieces on the board.\n\n').


print_pass_scoring_phase(Player):-
    write('\n\n------------------ PLAYER '),
    write(Player),
    write(' -------------------\n\n'),
    write('Have to pass this turn because you can not remove pieces from the board.\n\n').


print_end_placement_phase:-
    write('\n\n------------------ END OF PLACEMENT PHASE -------------------\n\n'),
    write('The placement phase is over because both players can not place any more pieces on the board.\n\n'),
    write('The game will now proceed to the scoring phase.\n\n').


print_end_game:-
    write('\n\n------------------ END OF SCORING PHASE -------------------\n\n'),
    write('The scoring phase is over because both players can not remove any more pieces on the board.\n\n').



% Checks if a variable is empty
var_empty(X):-
    var(X).

% A loop that allows players to place their pieces on the board alternately until the placement phase is completed (when they can not place any more pieces on the board)
placement_phase_loop(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer, FinalBoard, UpdateDarkPlayer, UpdateLightPlayer, FinalPlayer):-

   
    (check_can_play_placement_phase(Board, DarkPlayer) -> 

        placement_phase_darkPlayer(Board, PlayerD, DarkPlayer, NewBoard, NewDarkPlayer)
        ;
        print_pass_placement_phase(dark),
        (var_empty(FinalPlayer) -> FinalPlayer = dark ; true)

    ),

    (var_empty(NewBoard) -> NewBoard = Board, NewDarkPlayer = DarkPlayer ; true),
    
    (check_can_play_placement_phase(NewBoard, LightPlayer) ->
    
        placement_phase_playerLight(NewBoard, PlayerL, LightPlayer, NewNewBoard, NewLightPlayer)
        ;
        print_pass_placement_phase(light),
        (var_empty(FinalPlayer) -> FinalPlayer = light ; true)

    ),


    (var_empty(NewNewBoard) -> NewNewBoard = NewBoard, NewLightPlayer = LightPlayer ; true),
    
    (Board == NewNewBoard -> FinalBoard = Board,UpdateDarkPlayer = NewDarkPlayer,UpdateLightPlayer = NewLightPlayer; placement_phase_loop(NewNewBoard, PlayerD, PlayerL, NewDarkPlayer,NewLightPlayer, FinalBoard, UpdateDarkPlayer, UpdateLightPlayer, FinalPlayer)).



% The actions of the placement phase for the DarkPlayer 
placement_phase_darkPlayer(Board, 'P', DarkPlayer, NewBoard, NewDarkPlayer):-
    print_board(Board),
    /* Secalhar precisa de refactoring esta parte para baixo*/
    write('\n Your pieces (DarkPlayer):'),
    print_menu_pieces(1,DarkPlayer),
    print_menu_pieces(2,DarkPlayer),
    print_menu_pieces(3,DarkPlayer),
    print_menu_pieces(4,DarkPlayer),
    print_menu_pieces(6,DarkPlayer), 
    write('\n\n------------------ PLAYER Dark -------------------\n'),
    manage_piece(DarkPlayer, Piece, Board), % Choose the piece to place
    manage_square_dark(Board, Column, Row, Piece), % Choose the square to place the piece 
    choose_direction(Column, Row, Piece, Board, Direction), % Choose the direction to place the piece
    print_piece_board(Column, Row, Piece, Board, Direction, DarkPlayer, "D", AfterBoard), % Place the piece on the board
    decrement_piece(DarkPlayer, Piece, UpdateDarkPlayer), % Decrement the number of pieces for that piece in the player
    NewDarkPlayer = UpdateDarkPlayer, % Update the player list with the new number of pieces
   
    NewBoard = AfterBoard. % Update the board with the new piece placed



% The actions of the placement phase for the LightPlayer
placement_phase_playerLight(Board, 'P', LightPlayer, NewBoard, NewLightPlayer):-
    print_board(Board),
    /* Secalhar precisa de refactoring esta parte para baixo*/
    write('\n Your pieces (LightPlayer):'),
    print_menu_pieces(1,LightPlayer),
    print_menu_pieces(2,LightPlayer),
    print_menu_pieces(3,LightPlayer),
    print_menu_pieces(4,LightPlayer),
    print_menu_pieces(6,LightPlayer), 
    write('\n\n------------------ PLAYER Light -------------------\n\n'),
    manage_piece(LightPlayer, Piece, Board), % Choose the piece to place
    manage_square_light(Board, Column, Row, Piece),  % Choose the square to place the piece      
    choose_direction(Column, Row, Piece, Board, Direction), % Choose the direction to place the piece
    print_piece_board(Column, Row, Piece, Board, Direction, LightPlayer, "L", AfterBoard), % Place the piece on the board
    decrement_piece(LightPlayer, Piece, UpdateLightPlayer), % Decrement the number of pieces for that piece in the player
    NewLightPlayer = UpdateLightPlayer, % Update the player list with the new number of pieces

    NewBoard = AfterBoard. % Update the board with the new piece placed






% Scoring phase

scoring_phase_loop(Board, PlayerD, PlayerL, ScoreDark, ScoreLight, FinalScoreDark, FinalScoreLight, dark):-

    (check_can_play_scoring_phase(Board, dark), ScoreDark < 100, ScoreLight < 100 -> 
    
        scoring_phase_playerDark(Board, PlayerD, NewBoard, ScoreDark, UpdatedScoreDark)
        ;
        print_pass_scoring_phase(dark)
        
    ),

    (var_empty(NewBoard) -> NewBoard = Board, UpdatedScoreDark = ScoreDark ; true),


    (check_can_play_scoring_phase(NewBoard, light), UpdatedScoreDark < 100, ScoreLight < 100 -> 
    
        scoring_phase_playerLight(NewBoard, PlayerL, NewNewBoard, ScoreLight, UpdatedScoreLight)
        ;
        print_pass_scoring_phase(light)
        
    ),

    (var_empty(NewBoard) -> NewNewBoard = NewBoard, UpdatedScoreLight = ScoreLight ; true),

    (Board == NewNewBoard -> FinalScoreDark = ScoreDark, FinalScoreLight = ScoreLight ; scoring_phase_loop(NewNewBoard, PlayerD, PlayerL, UpdatedScoreDark, UpdatedScoreLight, FinalDarkPlayer, FinalLightPlayer, dark)).


    


scoring_phase_loop(Board, PlayerD, PlayerL, ScoreDark, ScoreLight, FinalScoreDark, FinalScoreLight, light):-


    (check_can_play_scoring_phase(Board, light), ScoreDark < 100, ScoreLight < 100 -> 
    
        scoring_phase_playerLight(Board, PlayerL, NewBoard, ScoreLight, UpdatedScoreLight)
        ;
        print_pass_scoring_phase(light)
        
    ),

    (var_empty(NewBoard) -> NewBoard = Board, UpdatedScoreLight = ScoreLight ; true),


    (check_can_play_scoring_phase(NewBoard, dark), UpdatedScoreLight < 100, ScoreDark < 100 -> 
    
        scoring_phase_playerDark(NewBoard, PlayerL, NewNewBoard, ScoreDark, UpdatedScoreDark)
        ;
        print_pass_scoring_phase(dark)
        
    ),

    (var_empty(NewBoard) -> NewNewBoard = NewBoard ; true),

    (Board == NewNewBoard -> FinalScoreDark = ScoreDark, FinalScoreLight = ScoreLight ; scoring_phase_loop(NewNewBoard, PlayerD, PlayerL, UpdatedScoreDark, UpdatedScoreLight, FinalDarkPlayer, FinalLightPlayer, light)).





scoring_phase_playerDark(Board, 'P', NewBoard, ScoreDark, UpdatedScoreDark):-

    print_board(Board),
    write('\n\n------------------ PLAYER Dark -------------------\n'),
    remove_piece(Board, ScoreDark, dark, NewBoard, UpdatedScoreDark),
    NewBoard = Board.


    
scoring_phase_playerLight(Board, 'P', NewBoard, ScoreLight, UpdatedScoreLight):-

    print_board(Board),
    write('\n\n------------------ PLAYER Light ------------------\n'),
    remove_piece(Board, ScoreLight, light, NewBoard, UpdatedScoreLight),
    NewBoard = Board.



check_who_won(FinalScoreDark, FinalScoreLight, FinalDarkPlayer, FinalLightPlayer):-
    piece_length(FinalDarkPlayer, LengthDark),
    piece_length(FinalLightPlayer, LengthLight),

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



check_can_play_scoring_phase(Board, dark).





check_can_play_scoring_phase(Board, light).



piece_length(List, Sum):-
    multiply_and_sum_helper(List, 0, Sum).


multiply_and_sum_helper([], Acc, Acc).
multiply_and_sum_helper([[X, Y] | Rest], Acc, Sum) :-
    score_length(Y, Length),
    NewAcc is Acc + X * Length,
    multiply_and_sum_helper(Rest, NewAcc, Sum).






win(dark):-
    write('\nCongratulations dark player, you won!\n'),nl,nl,
    write('\nPress any key to continue!\n'),
    read(_).


win(light):-
    write('\nCongratulations light player, you won!\n'),nl,nl,
    write('\nPress any key to continue!\n'),
    read(_).
