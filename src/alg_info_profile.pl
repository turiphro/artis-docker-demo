/***********************************
Universiteit van Amsterdam
Bachelor Kunstmatige Intelligentie
jaar 1, blok 3: Communicatieve Interactie
Artis project
Groep 1

Auteur: Eva Greiner

Procedurele kennis toegespitst op user.
user 1 geeft de informatie volgens alg_info.pl
user 2 bouwt er een verhaaltje omheen en is gemaakt voor kinderen.
***********************************/

info_profile(Animal, 1) :- !,
	info(Animal),
	sleep(2).

info_profile(Animal, 2) :- !,
	get_type(Animal, TypeList),
	writef('Je wilt iets weten over de %w.\n', [Animal]),
	ask_fam(Animal, TypeList),
	nl,	sleep(0.5),
	prop(Animal, verblijf, Loc),
	isa(Loc, Type),
	writef('De %w woont in een %w.\n',[Animal, Type]),
	get_cleaning(Animal, MatList, StepList),
	det_lw(Type, Lw),
	writef('Om %w %w schoon te maken hebben we deze dingen nodig:\n', 
		[Lw, Type]),
	show_list(MatList),
	nl, sleep(0.5),
	writef('Om %w %w van de %w schoon te maken moeten we deze dingen doen:\n',
		[Lw, Type, Animal]),
	show_list(StepList),
	nl, sleep(0.5),
	get_feeding(Animal, Gevaarlijk, Grootte, Eetgewoonte, Hoeveelheid,
		SoortEten),
	writef('De %w is een %w. Dit betekent dat hij ', [Animal, Eetgewoonte]),
	line_list(SoortEten),
	write('te eten krijgt.\n'),
	writef('De %w is %w. Daarom eet hij %w.\n',[Animal, Grootte, Hoeveelheid]),
	write_dng(Animal, Gevaarlijk),
	writef('Wil je zelf ook een %w hebben? Kijk dan even in de Artis shop!\n',
		[Animal]),
	nl, sleep(2).
	
ask_fam(Animal, [Type | RestTypeList]) :-	
	writef('Dit dier hoort bij de familie van de %wen.\n', [Type]),	
	writef('Wil je meer weten over de families waar de %w bij hoort? (ja. of nee.)\n', [Animal]),
	read(X),
	go_fam(X, Animal, RestTypeList).

go_fam(ja, _, []) :- !,
	write('Je hebt alle families van dit dier gezien. We gaan verder.\n\n').

go_fam(nee, _, _) :- !,
	write('We gaan verder.\n\n').

go_fam(ja, Animal, List) :-
	ask_fam(Animal, List).

go_fam(stop, _, _) :- !,
	menu(main).

go_fam(_, Animal, List) :-
	write('We snappen niet wat je bedoelt. Probeer het nog een keer.\n'),
	writef('Wil je meer weten over de families waar de %w bij hoort? (ja. of nee.)\n',
		[Animal]),
	read(X),
	go_fam(X, Animal, List).
	

det_lw(kooi, de) :-!.
det_lw(vijver, de) :-!.
det_lw(voliere, de) :-!.
det_lw(terrarium, het) :-!.
det_lw(aquarium, het) :-!.

line_list([X]) :- !,
	writef('%w ', [X]).
line_list([H|T]) :-
	writef('%w, ', [H]),
	line_list(T).

write_dng(Animal, gevaarlijk) :- !,
	writef('De %w is gevaarlijk. We mogen dus niet te dicht bij hem in de buurt komen. Daarom moeten we het eten van een afstand in zijn hok gooien.\n',
		[Animal]).
 
write_dng(Animal, _) :-
	writef('We kunnen het eten voor de %w in zijn hok leggen.\n', [Animal]).


% start 2 dieren vergelijken

info_profile(Animal1, Animal2, 1) :-
	info(Animal1, Animal2),
	sleep(2).

info_profile(Animal1, Animal2, 2) :-
	i_p_type(Animal1, Animal2),
	nl, sleep(0.5),
	i_p_clean(Animal1, Animal2),
	nl, sleep(0.5),
	i_p_feed(Animal1, Animal2),
	nl, sleep(0.5),
	writef('Dat was het! Wil je zelf ook een %w of een %w? Kijk dan even in onze Artis shop!\n', [Animal2, Animal1]),
	nl, sleep(2).
	
i_p_type(Animal1, Animal2) :-
	writef('Je wilt iets weten over de %w en de %w.\n', [Animal1, Animal2]),
	writef('We gaan eerst kijken naar de families van de %w.\n', [Animal1]),
	get_type(Animal1, TypeList1),
	ask_fam(Animal1, TypeList1),
	writef('Nu gaan we kijken naar de families van de %w.\n', [Animal2]),	
	get_type(Animal2, TypeList2),
	ask_fam(Animal2, TypeList2),
	writef('De %w en de %w horen allebei bij de familie van de \n', [Animal1,
		Animal2]),
	vergelijk_lijsten(TypeList1, TypeList2, OvList),
	line_list_en(OvList),
	write('.').

i_p_clean(Animal1, Animal2) :-
	prop(Animal1, verblijf, Loc1),
	isa(Loc1, Type1),
	prop(Animal2, verblijf, Loc2),
	isa(Loc2, Type2),
	check_sim(Type1, Type2, Sim),
	print_i_p_loc(Sim, Animal1, Type1, Animal2, Type2),	
	print_i_p_clean(Sim, Animal1, Type1, Animal2, Type2).


line_list_en([X]) :- !,
	writef('%wen ', [X]).

line_list_en([H|T]) :-
	writef('%wen, ', [H]),
	line_list_en(T).

check_sim(X, Y, same) :-
	X = Y,
	!.

check_sim(_, _, diff).

print_i_p_loc(same, Animal1, Type1, Animal2, _) :-
	!,
	writef('De %w en de %w wonen allebei in een %w.\n', [Animal1, Animal2, Type1]).

print_i_p_loc(diff, Animal1, Type1, Animal2, Type2) :-
	writef('De %w woont in een %w,\n',[Animal1, Type1]),
	writef('maar de %w woont in een %w.\n', [Animal2, Type2]).

print_i_p_clean(same, Animal1, Type1, Animal2, _) :-
	get_cleaning(Animal1, MatList1, StepList1),
	det_lw(Type1, Lw),
	writef('Om een %w schoon te maken hebben we deze dingen nodig:\n', 
		[Type1]),
	show_list(MatList1),
	nl, sleep(0.5),
	writef('Om %w %w van de %w en %w %w van de %w schoon te maken moeten we deze dingen doen:\n',
		[Lw, Type1, Animal1, Lw, Type1, Animal2]),
	show_list(StepList1).

print_i_p_clean(diff, Animal1, Type1, Animal2, Type2) :-
	get_cleaning(Animal1, MatList1, StepList1),
	det_lw(Type1, Lw1),
	get_cleaning(Animal2, MatList2, StepList2),
	det_lw(Type2, Lw2),
	vergelijk_lijsten(MatList1, MatList2, OvMatList),
	writef('Om %w %w en %w %w schoon te maken hebben we deze dingen nodig:\n', 
		[Lw1, Type1, Lw2, Type2]),
	show_list(OvMatList),
	verschillen(MatList1, MatList2, MatOnly1, MatOnly2),
	print_i_p_versch(mat, Animal1, Lw1, Type1, MatOnly1),
	print_i_p_versch(mat, Animal2, Lw2, Type2, MatOnly2),
	nl, sleep(0.5),
	vergelijk_lijsten(StepList1, StepList2, OvStepList),
	writef('Om %w %w van de %w en %w %w van de %w schoon te maken moeten we deze dingen doen:\n',
		[Lw1, Type1, Animal1, Lw2, Type2, Animal2]),
	show_list(OvStepList),
	verschillen(StepList1, StepList2, StepOnly1, StepOnly2),
	print_i_p_versch(step, Animal1, Lw1, Type1, StepOnly1),
	print_i_p_versch(step, Animal2, Lw2, Type2, StepOnly2).

print_i_p_versch(_, _, _, _, []) :- !.

print_i_p_versch(mat, Animal, Lw, Type, MatOnly) :-
	writef('Om %w %w van de %w schoon te maken hebben we ook nog ',
		[Lw, Type, Animal]),
	line_list(MatOnly),
	write('nodig.\n').

print_i_p_versch(step, Animal, Lw, Type, StepOnly) :-
	writef('Om %w %w van de %w schoon te maken moeten we ook nog deze dingen doen:\n', [Lw, Type, Animal]),
	show_list(StepOnly).

i_p_feed(Animal1, Animal2) :-
	get_feeding(Animal1, Gevaarlijk1, Grootte1, Eetgewoonte1, Hoeveelheid1,
		SoortEten1),
	get_feeding(Animal2, Gevaarlijk2, Grootte2, Eetgewoonte2, Hoeveelheid2,
		SoortEten2),
	check_sim(Eetgewoonte1, Eetgewoonte2, EWSim),
	print_ew(EWSim, Animal1, Eetgewoonte1, SoortEten1, Animal2, Eetgewoonte2,
		SoortEten2),
	check_sim(Grootte1, Grootte2, GrSim),
	print_hoev(GrSim, Animal1, Grootte1, Hoeveelheid1, Animal2, Grootte2, Hoeveelheid2),			
	check_sim(Gevaarlijk1, Gevaarlijk2, GevSim),
	print_dng(GevSim, Animal1, Gevaarlijk1, Animal2, Gevaarlijk2).
	
print_ew(same, Animal1, Eetgewoonte1, SoortEten1, Animal2, _, _) :-
	writef('De %w en de %w zijn allebei %w. Daarom krijgen ze allebei ',
		[Animal1, Animal2, Eetgewoonte1]),
	line_list(SoortEten1),
	write('te eten.\n').
	
print_ew(diff, Animal1, Eetgewoonte1, SoortEten1, Animal2, Eetgewoonte2,
		SoortEten2) :-
	writef('De %w is een %w, \n maar de %w is een %w.\n', [Animal1,
		Eetgewoonte1, Animal2, Eetgewoonte2]),
	vergelijk_lijsten(SoortEten1, SoortEten2, OvSrtEten),
	print_i_p_ov(srt, OvSrtEten),
	verschillen(SoortEten1, SoortEten2, SrtOnly1, SrtOnly2),
	print_i_p_versch(srt, Animal1, SrtOnly1),
	print_i_p_versch(srt, Animal2, SrtOnly2).

print_i_p_ov(srt, []) :- !.
print_i_p_ov(srt, List) :-
	write('Ze krijgen allebei '),
	line_list(List),
	write('te eten.\n').


print_i_p_versch(_,_,[]) :- !.	
print_i_p_versch(srt, Animal, SoortEten) :-
	writef('De %w krijgt ', [Animal]),
	line_list(SoortEten),
	write('te eten.\n').

print_dng(same, Animal1, gevaarlijk, Animal2, _) :-
	writef('De %w en de %w zijn allebei gevaarlijk. We mogen dus niet te dicht bij hen in de buurt komen. Daarom moeten we het eten van een afstand in hun hokken gooien.\n',
		[Animal1, Animal2]).
 
print_dng(diff, Animal1, Gevaarlijk1, Animal2, Gevaarlijk2) :-
	write_dng(Animal1, Gevaarlijk1),
	write_dng(Animal2, Gevaarlijk2).
		
print_hoev(same, Animal1, Grootte1, Hoeveelheid1, Animal2, _, _) :-
	writef('De %w en de %w zijn allebei %w. Dat betekent dat ze allebei %w eten.\n', [Animal1, Animal2, Grootte1, Hoeveelheid1]).

print_hoev(diff, Animal1, Grootte1, Hoeveelheid1, Animal2, Grootte2,
		Hoeveelheid2) :-
	writef('De %w is %w. Daarom eet hij %w,\n',[Animal2, Grootte2, Hoeveelheid2]),
	writef('maar de %w is %w. Hij eet dus %w.\n',[Animal1, Grootte1, Hoeveelheid1]).

	