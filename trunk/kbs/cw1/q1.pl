% Family Tree:
% bill - jane
%      |
%  +-------+
% jim    albert
%  |
%  +------+-----+
%  alice fred john
%          |
%      +-----+
%    mary  edward
%            |
%          richard

parent_of(bill, [jim, albert]).
parent_of(jane, '.'(jim, '.'(albert, []))).
parent_of(jim, [alice, fred, john]).
parent_of(fred, [mary, edward]).
parent_of(edward, [richard]).
        
male(bill).
male(jim).
male(albert).
male(fred).
male(john).
male(richard).
male(edward).

female(jane).
female(alice).
female(mary).

father_of(F, Ch):-
	parent_of(F, List), my_member(Ch, List), male(F).

grandfather_of(Gf, Gc):-
	parent_of(Gf, List1), my_member(Ch, List1),
	parent_of(Ch, List2), my_member(Gc, List2),
	male(Gf).

my_member(X, [X|_]).
my_member(X, [_|T]):-my_member(X, T).

% Assuming that a person's children are all listed in the same list
sister_of(Sis, Person) :-
        parent_of(_, List), my_member(Sis, List), my_member(Person, List),
        female(Sis), Sis \== Person.

% Assumes that the children are in a list - even if there's only a single child!
has_more_than_one_child(Person) :-
        parent_of(Person, List), length(List, X), X > 1.

ancestor_of(Ancestor, Person) :-
        parent_of(Ancestor, List), my_member(Person, List).

ancestor_of(Ancestor, Person) :-
        parent_of(Ancestor, List),
        my_member(A, List),
        ancestor_of(A, Person).