% volgens mij was dit de oude consult-file
% van eva, en wordt ie nu niet meer gebruikt


:-
	include('db_schoonmaak.pl').
:-
	include('db_voeding.pl').

show_list([]).

show_list([H|T]) :-
	writef('- %w\n',[H]),
	show_list(T).
