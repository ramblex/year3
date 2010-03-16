:- dynamic(male/1).
:- dynamic(parent_of/2).
:- dynamic(father_of/2).
:- dynamic(answer_to/2).

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
        get_answer(Goal, Ans),
        Ans == 'yes'.
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
        get_answer(Goal, Ans),
        Ans == 'yes'.
prove_right_to_left((Goal1, Goal2)):-
	prove_right_to_left(Goal2),
	prove_right_to_left(Goal1).
prove_right_to_left(true).

male(mark).
parent_of(mark, jim).
father_of(X, Y):-parent_of(X, Y), male(X).

% (b) The names have been altered slightly so that they make sense when
% prefixed with 'Is'
power_problem :- \+there_any_noise, it_switched_on.
os_problem :- windows_vista_installed.
operator_error_problem :- the_user_andrews_son.

% Q3.
% Interpret from left to right
commence_proof(X, left_to_right) :-
        write('Would you like to delete previous answers? [yes/no] '),
        read(Ans),
        clear_answers(Ans),
        prove_left_to_right(X), !.

% Interpret from right to left
commence_proof(X, right_to_left) :-
        write('Would you like to delete previous answers? [yes/no] '),
        read(Ans),
        clear_answers(Ans),
        prove_right_to_left(X), !.

% Delete answers given to questions
clear_answers('yes') :-
        retractall(answer_to(_,_)).
clear_answers(_).

% Try getting the goal from answers given ...
get_answer(Goal, Ans) :- answer_to(Goal, Ans), !.

% ... otherwise ask for an answer
get_answer(Goal, Ans) :-
        write('Is '), write(Goal), write('? '), read(Ans),
        assert(answer_to(Goal, Ans)).
