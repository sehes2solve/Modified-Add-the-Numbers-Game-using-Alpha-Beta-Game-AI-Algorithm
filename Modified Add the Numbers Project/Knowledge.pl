/*1st Intial State (The Project Description Intial State Example)*/
 get_intial(st(-1,6,
             b( 1,-1, 0,
				1, 0, 1,
				0, 1,-1)
				    ,0)).
/*2nd Intial State */
get_intial1(st(-1,6,
             b(-1,-1,-1,
			   -1,-1,-1,
			   -1,-1,-1)
			        ,0)).
/*3rd Intial State */
get_intial2(st(-1,6,
             b( 0, 0, 0,
			    0, 0, 0,
			    0, 0, 0)
			        ,0)).
/*4th Intial State */
get_intial3(st(-1,6,
			 b( 1, 1, 1,
			    1, 1, 1,
			    1, 1, 1)
			        ,0)).

/* possible_moves(+state,-possible_moves_for_user_in_this_state) */
possible_moves(st(_,Idx,_,_),Moves):-
(\+(2 is mod(Idx,3)),List1 = ['Right']      ;2 is mod(Idx,3),List1 = [   ]),
(\+(0 is mod(Idx,3)),List2 = ['Left' |List1];0 is mod(Idx,3),List2 = List1),
(Idx             < 6,List3 = ['Down' |List2];Idx         > 5,List3 = List2),
(Idx             > 2,Moves = ['Up'   |List3];Idx         < 3,Moves = List3),!.