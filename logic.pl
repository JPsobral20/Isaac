elementAtIndex(1, [Head|_], Head).
elementAtIndex(I, [_|Tail], Element):-
    I > 1,
    checkPiece6(I, NewI),
    I1 is NewI - 1,
    elementAtIndex(I1, Tail, Element).


checkPiece6(Input, UpdatedInput) :-
    (Input == 6,
    UpdatedInput is Input - 1, !);
    UpdatedInput = Input.


startGame_PL_PL(PlayerD, PlayerL):-
    initialMatrix(InitialBoard),
    darkPlayer(DarkPlayer),
    lightPlayer(LightPlayer),
    gamePlacePhaseLoop(InitialBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer, PlacePhaseBoard).
    /*gameScoringPhaseLoop(PlacePhaseBoard, PlayerD, PlayerL, ScorinPhaseBoard).*/



takePiece(1, [Head|_]):-
    write('\n Tem '),
    write(Head),
    write(' peças de score 1').

    
takePiece(2, [Head|_]):-
    write('\n Tem '),
    write(Head),
    write(' peças de score 2').
    

takePiece(3, [Head|_]):-
    write('\n Tem '),
    write(Head),
    write(' peças de score 3').


takePiece(4, [Head|_]):-
    write('\n Tem '),
    write(Head),
    write(' peças de score 4').

takePiece(6, [Head|_]):-
    write('\n Tem '),
    write(Head),
    write(' peças de score 6').


checkPiece(N, Player):-
    N \= 1,
    N \= 2,
    N \= 3,
    N \= 4,
    N \= 6,
    write('\nERROR: invalid piece!\n\n'),
    write('Choose a piece: '),
    read(Input),
    checkPiece(Input, Player).



checkPiece(N, Player):-
    elementAtIndex(N, Player, X),
    ((N == 1, takePiece(1, X));
    (N == 2, takePiece(2, X));
    (N == 3, takePiece(3, X));
    (N == 4, takePiece(4, X));
    (N == 6, takePiece(6, X))).





gamePlacePhaseLoop(Board, 'P', 'P', DarkPlayer, LightPlayer, NewBoard):-

    NewBoard = Board, %mudar
    placePhasePlayerDark(NewBoard, DarkPlayer, LightPlayer, NewPlacePhaseBoard).
        

placePhasePlayerDark(Board, DarkPlayer, LightPlayer, NewBoard):-
    /*checkIfDarkCanPlay(),*/
    printBoard(Board),
    write('\n------------------ PLAYER Dark -------------------\n\n'),
    write('Choose a piece: '),
    read(Input),
    checkPiece(Input, DarkPlayer),
    NewBoard = Board,  %mudar 
    placePhasePlayerLight(NewBoard, DarkPlayer, LightPlayer, NewPlacePhaseBoard).


placePhasePlayerLight(Board, DarkPlayer, LightPlayer, NewBoard):-
    printBoard(Board),
    /*checkIfDarkCanPlay(),*/
    write('\n------------------ PLAYER Light -------------------\n\n'),
    write('Choose a piece: '),
    read(Input),
    checkPiece(Input, LightPlayer),
    NewBoard = Board, %mudar
    placePhasePlayerDark(NewBoard, DarkPlayer, LightPlayer, NewPlacePhaseBoard).




