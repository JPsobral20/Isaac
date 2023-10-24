mainMenu:-
    printMainMenu,
    printMenuOption,
    read(Input),
    checkInput(Input).

printMenuOption:-
    write('Insert your option: ').

% Checks input
checkInput(1):-
    startGame('P','P'),
    mainMenu.

checkInput(2):-
    /*Print Bot Options*/
    mainMenu.

checkInput(3):-
    /*print more bot options*/
    mainMenu.

checkInput(0):-
    write('\nExiting...\n\n').

checkInput(_):-
    write('\nERROR: invalid option!\n\n'),
    printMenuOption,
    read(Input),
    checkInput(Input).

    
% Prints the main menu
printMainMenu:-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                 _____  _____    _____    _____  ______                |'),nl,
    write('|                   |    |       |     |  |     | |                     |'),nl,
    write('|                   |    |____   |_____|  |_____| |                     |'),nl,
    write('|                   |         |  |     |  |     | |                     |'),nl,
    write('|                 __|__   ____|  |     |  |     | |_____                |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                          1. Player vs Player                          |'),nl,
    write('|                                                                       |'),nl,
    write('|                          2. Player vs Computer                        |'),nl,
    write('|                                                                       |'),nl,
	write('|                          3. Computer vs Computer                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                          4. Rules                                     |'),nl,
    write('|                                                                       |'),nl,
    /*write('|                          9. Credits                                   |'),nl,*/
    write('|                                                                       |'),nl,
    write('|                          0. Exit                                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write(' _______________________________________________________________________ '),nl,nl,nl.