% Algoritmes om nieuwe gebruikersprofielen van bezoekers te
% te maken, oude profielen aan te passen en te verwijderen, 
% en een lijst op te vragen met eigenschappen.
%
% Auteur: Martijn van der Veen



% user_add = voeg user toe met eigenschappen
user_add(Naam, Eigenschappen) :-
	assert(isa(Naam, bezoeker)),
	user_addprop(Naam, Eigenschappen).

user_addprop(_, []) :- !.
user_addprop(Naam, [Eigenschap/Waarde|Eigenschappen]) :-
	assert(prop(Naam, Eigenschap, Waarde)),
	user_addprop(Naam, Eigenschappen).


user_del(Naam) :-
	item_exists(Naam, 1),
	isa(Naam, bezoeker),
	retract(isa(Naam, bezoeker)),
	retractall(prop(Naam, _, _)).




% item_exists(Naam, 0_of_1)
% controleren of item met naam Naam bestaat
item_exists(Naam, 1) :-
	isa(Naam, _),
	!.

item_exists(_, 0).



% krijg lijst met alle eigenschappen van bezoeker
user_getprops(Naam, Props) :-
	item_exists(Naam, 1),
	isa(Naam, bezoeker),
	findall(Eig/Waarde, prop(Naam, Eig, Waarde), Props).




% en nog iets om alles op te slaan in de database
% voordat prolog afgesloten wordt...
% (niet nodig als prologprogramma altijd aan blijft staan)
