% Auteur: Eva Greiner

voer(Dier) :-
	get_feeding(Dier, Gevaarlijk, _, _, Hoeveelheid, SoortEten),
	geef_eten(Gevaarlijk, Hoeveelheid, SoortEten).

get_feeding(Dier, Gevaarlijk, Grootte, Eetgewoonte, Hoeveelheid, SoortEten) :-
	get_stats_a(Dier, Grootte, Eetgewoonte, Gevaarlijk),
	verzamel_eten(Grootte, Eetgewoonte, Hoeveelheid, SoortEten).
	
get_stats_a(Dier, Grootte, Eetgewoonte, Gevaarlijk) :-
	hasprop(Dier, grootte_orde, Grootte),
	hasprop(Dier, eten, Eetgewoonte),
	get_danger_a(Dier, Gevaarlijk).

get_danger_a(Dier, gevaarlijk) :-
	hasprop(Dier, knuffact, gevaarlijk),
	!.

get_danger_a(_, ongevaarlijk).

verzamel_eten(Grootte, Eetgewoonte, Hoeveelheid, SoortEten) :-
	get_amount(Grootte, Hoeveelheid),
	get_food(Eetgewoonte, SoortEten).

% interface
geef_eten(Gevaarlijk, Hoeveelheid, Eten) :-
	writef('Dit dier dient %w van het volgende voedsel te krijgen:\n',
		[Hoeveelheid]),
	show_list(Eten),
	feed_danger(Gevaarlijk).

feed_danger(gevaarlijk) :- !,
	write('Het dier is gevaarlijk. Het eten dient daarom van een afstand in het verblijf gegooid te worden.\n').

feed_danger(_).
% eind interface

% de daadwerkelijke db
get_amount(huge, ergveel).
get_amount(groot, veel).
get_amount(medium, normaal).
get_amount(klein, weinig).
get_amount(tiny, ergweinig).

get_food(herbivoor, [groenten, takken]).
get_food(omnivoor, [groenten, brood, vlees]).
get_food(carnivoor, [vlees]).
