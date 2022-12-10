:- module(game_definition,[max_move/4,min_move/2,terminal_test/4,utility/2,fill_empty_cell_randomly/3]).
/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
1-Game Tree Definition
2-Terminal Test
3-Utility
4-Play AI Agent move Randomly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
state ==> previous index the user was at , current index the user at , board values , number of moves the user did
Ex    ==> s(prev_idx,idx,b(v1,v2,v3,v4,v5,v6),moves_num)

Board manuipliation (Zero Based)
  get_board_value(Idx,Board,Value)*/
get_board_value(0,b(V,_,_,_,_,_,_,_,_),Value):- Value = V,!.
get_board_value(1,b(_,V,_,_,_,_,_,_,_),Value):- Value = V,!.
get_board_value(2,b(_,_,V,_,_,_,_,_,_),Value):- Value = V,!.
get_board_value(3,b(_,_,_,V,_,_,_,_,_),Value):- Value = V,!.
get_board_value(4,b(_,_,_,_,V,_,_,_,_),Value):- Value = V,!.
get_board_value(5,b(_,_,_,_,_,V,_,_,_),Value):- Value = V,!.
get_board_value(6,b(_,_,_,_,_,_,V,_,_),Value):- Value = V,!.
get_board_value(7,b(_,_,_,_,_,_,_,V,_),Value):- Value = V,!.
get_board_value(8,b(_,_,_,_,_,_,_,_,V),Value):- Value = V,!.
/*set_board_value(Idx,Value,Board,New_board)*/
set_board_value(0,Value,b(_,V2,V3,V4,V5,V6,V7,V8,V9),b(Value,V2,V3,V4,V5,V6,V7,V8,V9)):-!.
set_board_value(1,Value,b(V1,_,V3,V4,V5,V6,V7,V8,V9),b(V1,Value,V3,V4,V5,V6,V7,V8,V9)):-!.
set_board_value(2,Value,b(V1,V2,_,V4,V5,V6,V7,V8,V9),b(V1,V2,Value,V4,V5,V6,V7,V8,V9)):-!.
set_board_value(3,Value,b(V1,V2,V3,_,V5,V6,V7,V8,V9),b(V1,V2,V3,Value,V5,V6,V7,V8,V9)):-!.
set_board_value(4,Value,b(V1,V2,V3,V4,_,V6,V7,V8,V9),b(V1,V2,V3,V4,Value,V6,V7,V8,V9)):-!.
set_board_value(5,Value,b(V1,V2,V3,V4,V5,_,V7,V8,V9),b(V1,V2,V3,V4,V5,Value,V7,V8,V9)):-!.
set_board_value(6,Value,b(V1,V2,V3,V4,V5,V6,_,V8,V9),b(V1,V2,V3,V4,V5,V6,Value,V8,V9)):-!.
set_board_value(7,Value,b(V1,V2,V3,V4,V5,V6,V7,_,V9),b(V1,V2,V3,V4,V5,V6,V7,Value,V9)):-!.
set_board_value(8,Value,b(V1,V2,V3,V4,V5,V6,V7,V8,_),b(V1,V2,V3,V4,V5,V6,V7,V8,Value)):-!.

terminal_test(st(_,Idx,Board,Moves_num),Min_score,Max_moves_num,result(Score,Case)):-
	get_board_value(Idx,Board,Score),
	(Score >= Min_score,Case = 'User Won',!
	;
	Moves_num = Max_moves_num,Case = 'User Lost',!),!.

%move up
mx_move(st(_,Idx,Board,Moves_num),st(Idx,Curr_idx,Curr_Empty_cell_board,New_moves_num),Poss_moves):-
	member('Up',Poss_moves),
	Curr_idx is Idx - 3,
	get_board_value(Idx,Board,Cell),
	get_board_value(Curr_idx,Board,Curr_cell),
	New_curr_cell is Cell + Curr_cell,
	set_board_value(Idx,'X',Board,Empty_cell_board),
	set_board_value(Curr_idx,New_curr_cell,Empty_cell_board,Curr_Empty_cell_board),
	New_moves_num is Moves_num + 1.

%move down
mx_move(st(_,Idx,Board,Moves_num),st(Idx,Curr_idx,Curr_Empty_cell_board,New_moves_num),Poss_moves):-
	member('Down',Poss_moves),
	Curr_idx is Idx + 3,
	get_board_value(Idx,Board,Cell),
	get_board_value(Curr_idx,Board,Curr_cell),
	New_curr_cell is Cell + Curr_cell,
	set_board_value(Idx,'X',Board,Empty_cell_board),
	set_board_value(Curr_idx,New_curr_cell,Empty_cell_board,Curr_Empty_cell_board),
	New_moves_num is Moves_num + 1.

%move left
mx_move(st(_,Idx,Board,Moves_num),st(Idx,Curr_idx,Curr_Empty_cell_board,New_moves_num),Poss_moves):-
	member('Left',Poss_moves),
	Curr_idx is Idx - 1,
	get_board_value(Idx,Board,Cell),
	get_board_value(Curr_idx,Board,Curr_cell),
	New_curr_cell is Cell + Curr_cell,
	set_board_value(Idx,'X',Board,Empty_cell_board),
	set_board_value(Curr_idx,New_curr_cell,Empty_cell_board,Curr_Empty_cell_board),
	New_moves_num is Moves_num + 1.

%move right
mx_move(st(_,Idx,Board,Moves_num),st(Idx,Curr_idx,Curr_Empty_cell_board,New_moves_num),Poss_moves):-
	member('Right',Poss_moves),
	Curr_idx is Idx + 1,
	get_board_value(Idx,Board,Cell),
	get_board_value(Curr_idx,Board,Curr_cell),
	New_curr_cell is Cell + Curr_cell,
	set_board_value(Idx,'X',Board,Empty_cell_board),
	set_board_value(Curr_idx,New_curr_cell,Empty_cell_board,Curr_Empty_cell_board),
	New_moves_num is Moves_num + 1.

max_move(st(Prev_idx,Idx,Board,Moves_num),Min_score,Max_moves_num,New_state):-
	\+(terminal_test(st(Prev_idx,Idx,Board,Moves_num),Min_score,Max_moves_num,_)),
	possible_moves(st(Prev_idx,Idx,Board,Moves_num),Moves),
	mx_move(st(Prev_idx,Idx,Board,Moves_num),New_state,Moves).

fill_empty_cell(Value,st(Prev_idx,Idx,Board,Moves_num),st(Prev_idx,Idx,Curr_Board,Moves_num)):-
	set_board_value(Prev_idx,Value,Board,Curr_Board),!.

%put -1
min_move(State,New_state):-
	fill_empty_cell(-1,State,New_state).
%put 0
min_move(State,New_state):-
	fill_empty_cell(0,State,New_state).
%put 1
min_move(State,New_state):-
	fill_empty_cell(1,State,New_state).

fill_empty_cell_randomly(State,New_state,Value):-
	random(-1,1,Value),
	fill_empty_cell(Value,State,New_state),!.
	
utility(st(_,Idx,Board,_),Score):-
	get_board_value(Idx,Board,Score),!.


