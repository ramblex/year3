prove_left_to_right(clause(X, Y)):-clause(X, Y).
prove_left_to_right(A=A).
prove_left_to_right(\+ A):- \+ prove_left_to_right(A).
prove_left_to_right(Goal):-
	\+(Goal = true), \+(Goal = ','(_, _)), \+(Goal = \+(_)), 
	\+(Goal = '='(_, _)), \+(Goal = clause(_, _)),
	clause(Goal, Body), prove_left_to_right(Body).
prove_left_to_right(Goal):-
	\+(Goal = true), \+(Goal = ','(_, _)), \+(Goal = \+(_)), 
	\+(Goal = '='(_, _)), \+(Goal = clause(_, _)),
	\+((clause(Goal, _))),
        write('Is '), write(Goal), write('? '), read(Term), Term == 'yes'.
prove_left_to_right((Goal1, Goal2)):-
	prove_left_to_right(Goal1),
	prove_left_to_right(Goal2).
prove_left_to_right(true).

prove_right_to_left(clause(X, Y)):-clause(X, Y).
prove_right_to_left(A=A).
prove_right_to_left(\+ A):- \+ prove_right_to_left(A).
prove_right_to_left(Goal):-
	\+(Goal = true), \+(Goal = ','(_, _)), \+(Goal = \+(_)), 
	\+(Goal = '='(_, _)), \+(Goal = clause(_, _)),
	clause(Goal, Body), prove_right_to_left(Body).
prove_right_to_left(Goal):-
	\+(Goal = true), \+(Goal = ','(_, _)), \+(Goal = \+(_)), 
	\+(Goal = '='(_, _)), \+(Goal = clause(_, _)),
	\+((clause(Goal, _))),
        write('Is '), write(Goal), write('? '), read(Term), Term == 'yes'.
prove_right_to_left((Goal1, Goal2)):-
	prove_right_to_left(Goal2),
	prove_right_to_left(Goal1).
prove_right_to_left(true).

male(mark).
parent_of(mark, jim).
father_of(X, Y):-parent_of(X, Y), male(X).

% Interpret from left to right
commence_proof(X, left_to_right) :- prove_left_to_right(X), !.

% Interpret from right to left
commence_proof(X, right_to_left) :- prove_right_to_left(X), !.

% (b)
power_problem :- \+there_any_noise, it_switched_on.
os_problem :- windows_vista_installed.
operator_error_problem :- the_user_andrews_son.
