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


startGame(PlayerD, PlayerL):-
    initialMatrix(InitialBoard),
    darkPlayer(DarkPlayer),
    lightPlayer(LightPlayer),
    placePhasePlayerDark(InitialBoard, PlayerD, PlayerL, DarkPlayer, LightPlayer, NewBoard).
    /*gameScoringPhaseLoop(PlacePhaseBoard, PlayerD, PlayerL, ScorinPhaseBoard).*/



takePiece(1, [Head|_]):-
    /* tirar a peça */
    write('\n Tem '),
    write(Head),
    write(' peças de score 1').

    
takePiece(2, [Head|_]):-
    /* tirar a peça */
    write('\n Tem '),
    write(Head),
    write(' peças de score 2').
    

takePiece(3, [Head|_]):-
    /* tirar a peça */
    write('\n Tem '),
    write(Head),
    write(' peças de score 3').


takePiece(4, [Head|_]):-
    /* tirar a peça */
    write('\n Tem '),
    write(Head),
    write(' peças de score 4').

takePiece(6, [Head|_]):-
    /* tirar a peça */
    write('\n Tem '),
    write(Head),
    write(' peças de score 6').


checkPiece(N, Player):-
    \+ member(N, [1, 2, 3, 4, 6]),
    write('\nERROR: invalid piece!\n\n'),
    write('Choose a piece: '),
    read(Input),
    checkPiece(Input, Player).
    /*, !.*/


checkPiece(N, Player):-
    member(N, [1, 2, 3, 4, 6]),
    elementAtIndex(N, Player, Ele),
    takePiece(N, Ele).


/* acho que podemos apagar
gamePlacePhaseLoop(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer):-

    placePhasePlayerDark(Board, PlayerD, PlayerL, DarkPlayer, LightPlayer, NewBoard).

*/
        

placePhasePlayerDark(Board, 'P', 'P', DarkPlayer, LightPlayer, NewBoard):-
    /*checkIfDarkCanPlay(),*/
    printBoard(Board),
    write('\n------------------ PLAYER Dark -------------------\n'),
    write('\nChoose a piece: '),
    read(Input),
    checkPiece(Input, DarkPlayer),
    /*
    manageColumn(Column),
    manageRow(Row),
    */
    /*change board*/
    NewBoard = Board,  %mudar 
    placePhasePlayerLight(NewBoard, 'P', 'P', DarkPlayer, LightPlayer, NewPlacePhaseBoard).


placePhasePlayerLight(Board, 'P', 'P', DarkPlayer, LightPlayer, NewBoard):-
    printBoard(Board),
    /*checkIfDarkCanPlay(),*/
    write('\n------------------ PLAYER Light -------------------\n\n'),
    write('Choose a piece: '),
    read(Input),
    checkPiece(Input, LightPlayer),
    /*
    manageColumn(Column),
    manageRow(Row),
    */
    /*change board*/
    NewBoard = Board, %mudar
    placePhasePlayerDark(NewBoard, 'P', 'P', DarkPlayer, LightPlayer, NewPlacePhaseBoard).




