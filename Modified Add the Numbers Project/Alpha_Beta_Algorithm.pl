:- module(alpha_beta_algorithm,[alpha_beta/4]).
/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NOTE: max_or_min_value(...) rule has The Two 
Max Value & Min Value behaviours & decide which
Behaviour to do based on The (Turn) Variable
thats why each of :
1-max_or_min_value(...) |
2-move(...)         =>  |do ether User move or
3-get_intial_value(...) |Computer move.
4-switch_turn(...)	=>  |alternate turns.
5-get_better_action(...)|
6-best_value(...)   =>  |get best utility value 
7-prune(...)            |agent would choose.
8-continue(...)         |
Have Two Different Behaviours Based on Turn var.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  switch_turn(+Turn,-Next_turn)*/
switch_turn(max,min):-!.
switch_turn(min,max):-!.

/*get_better_action(action(+V1,+State1),action(+V2,+State2)
				    ,+Turn,action(-Best_v,-Best_State)*/
get_better_action(action(V1,State1),action(V2,_),max,action(V1,State1)):-
	V1 >= V2,!.
get_better_action(action(V1,_),action(V2,State2),max,action(V2,State2)):-
	V1 <  V2,!.
get_better_action(action(V1,State1),action(V2,_),min,action(V1,State1)):-
	V1 =< V2,!.
get_better_action(action(V1,_),action(V2,State2),min,action(V2,State2)):-
	V1 >  V2,!.
	
/*prune(+range(Alpha,Beta),+action(Better_v,Better_state)
        ,+Turn,-return_action(Best_v,Best_state))*/
prune(range(_,Beta),action(Better_v,Better_state)
      ,max,return_action(Better_v,Better_state)):-
	Better_v >= Beta.
prune(range(Alpha,_),action(Better_v,Better_state)
      ,min,return_action(Better_v,Better_state)):-
	Better_v =< Alpha.
	
/*continue(+Rest,+range(Alpha,Beta)
           ,+current_action(Better_v,Better_state)
		   ,+Turn,-return_action(Best_v,Best_state)
		   ,+Min_score,+Max_moves_num).*/
continue(Rest,range(Alpha,Beta),current_action(Better_v,Better_state)
	     ,max,return_action(Best_v,Best_state),Min_score,Max_moves_num):-
         Larger_alpha is max(Alpha,Better_v),
		 best_value(Rest,range(Larger_alpha,Beta)
	                ,current_action(Better_v,Better_state)
	                ,max,return_action(Best_v,Best_state)
				    ,Min_score,Max_moves_num).
continue(Rest,range(Alpha,Beta),current_action(Better_v,Better_state)
	     ,min,return_action(Best_v,Best_state),Min_score,Max_moves_num):-
         Tinier_beta is min(Beta,Better_v),
		 best_value(Rest,range(Alpha,Tinier_beta)
	                ,current_action(Better_v,Better_state)
	                ,min,return_action(Best_v,Best_state)
				    ,Min_score,Max_moves_num).
					
/*best_value(+[Poss_actions_results],+range(Alpha,Beta)
             ,+current_action(Curr_best_v,Curr_best_State)
			 ,+Turn,-return_action(Curr_best_v,Curr_best_State)
			 ,+Min_score,+Max_moves_num)*/
best_value([],range(_,_)
               ,current_action(Curr_best_v,Curr_best_state),_
               ,return_action(Curr_best_v,Curr_best_state),_,_):-!.
	
best_value([Head_state|Rest],range(Alpha,Beta)
               ,current_action(Curr_best_v,Curr_best_state)
               ,Turn,return_action(Best_v,Best_state)
			   ,Min_score,Max_moves_num):-
	switch_turn(Turn,Next_turn),
	max_or_min_value(Head_state,range(Alpha,Beta),Next_turn
	          ,action(My_v,_),Min_score,Max_moves_num),
	get_better_action(action(Curr_best_v,Curr_best_state)
	                  ,action(My_v,Head_state),Turn
					  ,action(Better_v,Better_state)),
	(
	 prune(range(Alpha,Beta),action(Better_v,Better_state)
        ,Turn,return_action(Best_v,Best_state)),!
	;
	 continue(Rest,range(Alpha,Beta)
	          ,current_action(Better_v,Better_state)
			  ,Turn,return_action(Best_v,Best_state)
			  ,Min_score,Max_moves_num)
	).

/*move(+State,+Turn,+Min_score,+Max_moves_num,-New_state)*/
move(State,max,Min_score,Max_moves_num,New_state):-
	max_move(State,Min_score,Max_moves_num,New_state).
move(State,min,_,_,New_state):-
	min_move(State,New_state).
	
/*get_intial_v(+Turn,-Intial_v)*/
get_intial_value(max,-inf):-!.
get_intial_value(min,inf):-!.
	
/*max_or_min_value(+State,+range(Alpha,Beta),+Turn
                   ,-action(V,Best_State_should_choose)
                   ,+Min_score,+Max_moves_num)*/	
max_or_min_value(State,range(Alpha,Beta),Turn
		  ,action(V,Best_state),Min_score,Max_moves_num):-
	bagof(New_state,move(State,Turn,Min_score,Max_moves_num,New_state)
	      ,Poss_actions_results),
	get_intial_value(Turn,Intial_v),
	best_value(Poss_actions_results,range(Alpha,Beta)
	               ,current_action(Intial_v,st(null))
	               ,Turn,return_action(V,Best_state)
				   ,Min_score,Max_moves_num),!.
	
max_or_min_value(State,_,max,action(V,State),_,_):-
	utility(State,V),!.

/*alpha_beta(+State,-Best_State_should_choose
             ,+Min_score,+Max_moves_num)*/
alpha_beta(State,Best_State,Min_score,Max_moves_num):-
	max_or_min_value(State,range(-inf,inf),max,action(_,Best_State)
	          ,Min_score,Max_moves_num).
