module(1, 'Nicomachean Ethics', 'Aristotle').
module(2, 'Lisp', 'Peter Norvig').
module(3, 'How to gimme your money', 'Steve Jobs').

% Alex Duller
student_module(100, 1).

% Bill Evans 
student_module(200, 1).
student_module(200, 2).

% Leonard Bernstein
student_module(300, 1).
student_module(300, 2).
student_module(300, 3).

student('Alex Duller', 100, 1).
student('Bill Evans', 200, 2).
student('Bill Evans', 201, 3).
student('Leonard Bernstein', 300, 1).
student('Jane Morgan', 400, 2).

% 1.
print_students_in_year(YNo) :-
        \+member(YNo, [1,2,3]),
        write('Invalid year'), nl, fail.

print_students_in_year(YNo) :-
        student(Name, Num, YNo),
        write(Name), write(', '), write(Num), nl,
        fail.
print_students_in_year.

% 2.
print_students_lectured_by(Lecturer) :-
        \+module(_, _, Lecturer),
        write(Lecturer), write(' is not a lecturer.'), nl, fail.

print_students_lectured_by(Lecturer) :-
        student(Name, Num, _),
        student_module(Num, Module),
        module(Module, _, Lecturer),
        write(Name), write(', '), write(Num), nl,
        fail.
print_students_lectured_by.

% 3.
% Advantages of output:
% - Easy to tell if known, if unique, both or neither
% - No need for output specific to clauses - all handled automatically
%
% Disadvantages of output:
% - If called more than once by same clause then get output multiple times
% - More control over output on a per clause basis - may not want output
% - No easy way to distinguish on failure whether not unique or not known.
%
% Conclusion: Do not output. It's fairly easy to test if a student exists and
% we have more control over what is output. We also avoid outputting the error
% messages multiple times if we call the clause multiple times. If a message is
% output by the calling clause such as 'Student not known or unique', it should
% be fairly easy for the user to look at the definitions and see which one is
% the problem. This approach also keeps this clause much simpler!

is_known_and_unique(StudentName) :-
        student(StudentName, Number, _),
        \+((student(StudentName, OtherNumber, _), Number \== OtherNumber)).

% 4.
print_modules_for(StudentName) :-
        \+is_known_and_unique(StudentName),
        write(StudentName), write(' is unknown or not unique'), nl, fail.

print_modules_for(StudentName) :-
        is_known_and_unique(StudentName),
        student(StudentName, Num, _),
        \+student_module(Num, _),
        write(StudentName), write(' is not taking any modules'), nl, fail.

print_modules_for(StudentName) :-
        is_known_and_unique(StudentName),
        student(StudentName, Num, _),
        student_module(Num, Module),
        module(Module, Title, _),
        write(Title), write(', '), write(Module), nl, fail.
print_modules_for.