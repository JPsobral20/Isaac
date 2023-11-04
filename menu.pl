main_menu:-
    print_main_menu,
    print_menu_option,
    read(Input),
    check_input(Input).

print_menu_option:-
    write('Insert your option: ').

% Checks input
check_input(1):-
    start_game('P','P'),
    main_menu.

check_input(2):-
    /*Print Bot Options*/
    main_menu.

check_input(3):-
    /*print more bot options*/
    main_menu.

check_input(0):-
    write('\nExiting...\n\n').

check_input(_):-
    write('\nERROR: invalid option!\n\n'),
    print_menu_option,
    read(Input),
    check_input(Input).

    
% Prints the main menu
print_main_menu:-
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