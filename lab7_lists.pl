% ============================================================
%  ARTI 303 - Programming for AI
%  Lab 7 - Lists (Parts I and II)
%  Student: Fatima Alhanfoosh
%  File: lab7_lists.pl
%
%  Contents:
%    Part 1 - Lab Activity: Shopping Program   (run:  ?- start.)
%    Part 2 - Task 1: deleteElement/3
%    Part 2 - Task 2: add_at_the_end/3
% ============================================================


% ============================================================
%  PART 1 - LAB ACTIVITY: SHOPPING PROGRAM
%  Menu: d = display all items, a = add an item, e = exit.
%  The basket starts with five items and is passed from one
%  menu call to the next as a list.
% ============================================================

% Start the program with a basket of five items.
start :-
    menu([coffee, milk, chocolate, apple, juice]).

% Show the menu, read the user's choice, then act on it.
menu(List) :-
    nl,
    write('** SHOPPING LIST **'), nl,
    write('d. display all items.'), nl,
    write('a. Add an item to the list.'), nl,
    write('e. exit.'), nl,
    write('ENTER YOUR CHOICE .'), nl,
    read(Choice),
    choice(Choice, List).

% d: display every item, then show the menu again.
choice(d, List) :-
    !,
    display_items(List),
    menu(List).

% a: read a new item, add it to the basket, then show the menu again.
choice(a, List) :-
    !,
    write('enter the item you want to add it'), nl,
    read(Item),
    add_at_the_end(Item, List, NewList),
    write('The item has been added'), nl,
    menu(NewList).

% e: exit the program.
choice(e, _) :-
    !,
    write('Goodbye!'), nl.

% Anything else: tell the user and show the menu again.
choice(_, List) :-
    write('Invalid choice, try again.'), nl,
    menu(List).

% Display the items using recursion over the list.
% Base case: the empty list - nothing left to print.
display_items([]).
display_items([H|T]) :-
    write(H), nl,
    display_items(T).

% How to run:
% ?- start.
% |: d.          (shows coffee, milk, chocolate, apple, juice)
% |: a.
% |: bread.      (The item has been added)
% |: e.


% ============================================================
%  PART 2 - TASK 1: DELETE EVERY OCCURRENCE
%  deleteElement(X, List, Result)
%  Result is List with ALL occurrences of X removed.
%  Gives ONE answer only (unlike del/3).
% ============================================================

% Base case: deleting anything from the empty list gives the empty list.
deleteElement(_, [], []).

% If X is the head, drop it and keep deleting from the tail.
% The cut (!) stops Prolog from trying the next clause, so only one answer.
deleteElement(X, [X|Tail], Result) :-
    !,
    deleteElement(X, Tail, Result).

% Otherwise keep the head and delete from the tail.
deleteElement(X, [H|Tail], [H|Result]) :-
    deleteElement(X, Tail, Result).

% Test queries:
% ?- deleteElement(1, [1,2,1,4,3,4,1,1,1,3,4,2,1,1,1], List).
%    List = [2, 4, 3, 4, 3, 4, 2].
% ?- deleteElement(3, [1,2,1,4,3,4,1,1,1,3,4,2,1,1,1], List).
%    List = [1, 2, 1, 4, 4, 1, 1, 1, 4, 2, 1, 1, 1].
% ?- deleteElement(5, [1,5,2], List).      % element appears once
%    List = [1, 2].


% ============================================================
%  PART 2 - TASK 2: ADD AT THE END
%  add_at_the_end(X, List, Result)
%  Result is List with X placed at the end.
%
%  Why it is not free like adding to the front:
%  Prolog can only reach the HEAD of a list directly. To reach the
%  end it has to walk through every element until the empty list [],
%  then build the answer back up - so it needs recursion.
% ============================================================

% Solution 1 (recursive):
% Base case: adding X to the empty list gives [X].
add_at_the_end(X, [], [X]).

% Keep the head, and add X to the end of the tail.
add_at_the_end(X, [H|Tail], [H|Result]) :-
    add_at_the_end(X, Tail, Result).

% Solution 2 (using append / conc): join the list with [X].
add_at_the_end2(X, List, Result) :-
    append(List, [X], Result).

% Test queries:
% ?- add_at_the_end(5, [1,2,3,4], List).
%    List = [1, 2, 3, 4, 5].
% ?- add_at_the_end(d, [a,b,c], List).
%    List = [a, b, c, d].
% ?- add_at_the_end2(d, [a,b,c], List).
%    List = [a, b, c, d].
