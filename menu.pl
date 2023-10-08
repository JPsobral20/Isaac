mainMenu :-
    printMainMenu,
    menuOption,
    read(Input),
    checkInput(Input).

checkInput(1) :-
    startGame_PL_PL('P','P'),
    mainMenu.

checkInput(2) :-
    startGame_PL_PL('P','C'),
    mainMenu.

checkInput(3) :-
    startGame_PL_PL('C','C'),
    mainMenu.

checkInput(0) :-
    write('\nExiting...\n\n').

checkInput(_Other) :-
    write('\nERROR: invalid option!\n\n'),
    menuOption,
    read(Input),
    checkInput(Input).

printMainMenu :-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                         ___     _       _ _                           |'),nl,
    write('|                        |  _|___| |_ ___|_| |_                         |'),nl,
    write('|                        |  _| ."| . |  _| | "_|                        |'),nl,
    write('|                        |_| |__,|___|_| |_|_,_|                        |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                           Barbara Sofia Silva                         |'),nl,
    write('|                              Julieta Frade                            |'),nl,
    write('|               -----------------------------------------               |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                          1. Player vs Player                          |'),nl,
    write('|                                                                       |'),nl,
    write('|                          2. Player vs Computer                        |'),nl,
    write('|                                                                       |'),nl,
	write('|                          3. Computer vs Computer                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                          0. Exit                                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write(' _______________________________________________________________________ '),nl,nl,nl.

menuOption :-
    write('> Insert your option: ').