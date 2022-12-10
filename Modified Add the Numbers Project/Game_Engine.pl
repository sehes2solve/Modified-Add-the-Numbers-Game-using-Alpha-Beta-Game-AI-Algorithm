:- use_module(game_definition).
:- use_module(alpha_beta_algorithm).


/* get_user_move(+State,-Move) */
get_user_move(st(Prev_idx,Idx,_,_),'Right'):-
	1 is Idx - Prev_idx,!.
get_user_move(st(Prev_idx,Idx,_,_),'Left'):-
	-1 is Idx - Prev_idx,!.
get_user_move(st(Prev_idx,Idx,_,_),'Up'):-
	-3 is Idx - Prev_idx,!.
get_user_move(st(Prev_idx,Idx,_,_),'Down'):-
	3 is Idx - Prev_idx,!.

/* Start: Start the game. */
start :-  
	nl,
	write(' =========================='),
	nl,
	write('= Modified Add the Numbers ='),
	nl,
    write(' =========================='),
	nl,
	nl,
	get_input(Min_score,Max_moves_num),
	get_intial(Intial),
	write('Intial Case : '),
	nl,
	show_board(Intial),
	nl,
	agents_play(Intial,Min_score,Max_moves_num,7).
	
/* get_input: gets minimal score goal for winning & maximum number of moves allowed. */
get_input(Min_score,Max_moves_num) :-
	write('Please Enter Minimum Score For Winning (number) |: '),
	read(Fst_input),
	nl,
	write('Please Enter Maximum Number of Moves Allowed (number) '),
	read(Sec_input),
	nl,
	(integer(Fst_input),integer(Sec_input),Min_score = Fst_input,Max_moves_num = Sec_input,!
	;
	write('Error : Input isn\'t a Number !'), nl, nl, get_input(Min_score,Max_moves_num)).

user_move(State,Next_state,Min_score,Max_moves_num):-
	write('User Turn: '),			nl,
	show_board(State),				
	possible_moves(State,Moves),
	write('Possible User Moves : '),
	show_poss_moves(Moves),			
	alpha_beta(State,Next_state,Min_score,Max_moves_num),
	get_user_move(Next_state,Move),
	write('Best User Move : '),
	write(Move),                    nl,nl,!.
	
computer_move(State,Next_state):-
	write('Computer Turn: '),		nl,
	show_board(State),				
	fill_empty_cell_randomly(State,Next_state,Value),
	write('Computer Random Number : '),
	write(Value),                   nl,nl,!.

agents_play(State,Min_score,Max_moves_num,_):-
	terminal_test(State,Min_score,Max_moves_num,result(Score,Case)),
	write('Game Over : '),write(Case),nl,
	show_board(State),    
	write('Score : '),write(Score),   nl,!.

agents_play(State,Min_score,Max_moves_num,0):-
	write('Please Check the Current Part of the Total Output Then Enter |:'),nl,
	write('Any Character To Continue Printing Rest Of Total Output !!!! '),  
	read(_),
	user_move(State,State1,Min_score,Max_moves_num),
	computer_move(State1,State2),
	agents_play(State2,Min_score,Max_moves_num,7),!.

agents_play(State,Min_score,Max_moves_num,Counter):-
	New_counter is Counter - 1,
	user_move(State,State1,Min_score,Max_moves_num),
	computer_move(State1,State2),
	agents_play(State2,Min_score,Max_moves_num,New_counter).
	
show_poss_moves([Last_move]):-
		write(Last_move),nl,!.
show_poss_moves([Head_move|Rest_moves]):-
	write(Head_move),write(' , '),
	show_poss_moves(Rest_moves),!.
		
show(X):-
  X = 'X', !,
  write('  ').
  
show(X):-
  X < 0,   !,
  write(X).
  
show(X):-
  X > -1,  !,
  write(' '),
  write(X).
  
show_board(st(_,Idx,b(X1, X2, X3, X4, X5, X6, X7, X8, X9),_)):-
	 write(' +--------------+'), nl,
	 write(' | '), show(X1),
	 write(' | '), show(X2),
	 write(' | '), show(X3),
	 write(' | '),	             nl,
	 write(' +--------------+'), nl,
	 write(' | '), show(X4),
	 write(' | '), show(X5),
	 write(' | '), show(X6),
     write(' | '),	             nl,
	 write(' +--------------+'), nl,
	 write(' | '), show(X7),
	 write(' | '), show(X8),
	 write(' | '), show(X9),
	 write(' | '),	             nl,
	 write(' +--------------+'), nl,
	 write('User Position at Index(Zero Based): '),
	 write(Idx),                 nl,!.