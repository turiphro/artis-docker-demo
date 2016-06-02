/***********************************
Universiteit van Amsterdam
Bachelor Kunstmatige Intelligentie
jaar 1, blok 3: Communicatieve Interactie
Artis project
Groep 1

Auteur: Eva Greiner, Robrecht Jurriaans

Interface om te werken met alg_info_profile.pl
***********************************/

go_proc_profile :-
	write('Hoe heet je?\n'),
	read(Name),
	info_proc_profile(Name).
	
info_proc_profile(stop) :- !,
	menu(main).

info_proc_profile(help) :- !,
	findall(Dier, isfam(Dier, dier), X),
	level_filter(X, 4, FX),
	show_list(FX),
	go_proc_profile.
	
info_proc_profile(User) :-
	global_var(datum, _/_/Currentyear),
	prop(User, geboortejaar, Birth),
	Age is Currentyear-Birth,
	ageclass_proc(Age, Class),
	if_info_profile(Class).

info_proc_profile(_) :-
	write('Onbekende gebruiker. Maak eerst een profiel aan.\n'),
	menu(users).

ageclass_proc(Age, 2):-
	Age < 12,!.
ageclass_proc(_, 1).

if_info_profile(1) :-
	write('\nWil je informatie over een dier (1.) of twee dieren met elkaar vergelijken (2.)?\n'),
	read(X),
	go_info_profile_1(X).

go_info_profile_1(stop) :- !.

go_info_profile_1(1) :- !,
	write('Over welk dier wil je informatie?\n'),
	read(X),
	go_1(X).

go_1(stop) :- !.

go_1(help) :-	!,
	findall(Dier, isfam(Dier, dier), X),
	level_filter(X, 4, FX),
	show_list(FX),
	go_info_profile_1(1).

go_1(Animal) :-
	isfam(Animal, dier),
	!,
	info_profile(Animal, 1).

go_1(_) :-
	write('Onbekende input. Je kunt kiezen uit deze dieren:\n'),
	!,
	go_1(help).

go_info_profile_1(2) :- !,
	write('Wat is het eerste dier?\n'),
	read(X),
	check_an(1, X),
	write('Wat is het tweede dier?\n'),
	read(Y),
	check_an(1, Y),
	info_profile(X, Y, 1).

go_info_profile_1(_) :-
	write('Onbekende input. Probeer opnieuw.\n'),
	!,
	if_info_profile(1).

check_an(_, stop) :- !,
	menu(main).

check_an(1, help) :- !,
	findall(Dier, isfam(Dier, dier), X),
	level_filter(X, 4, FX),
	show_list(FX),
	go_info_profile_1(2).


check_an(2, help) :- !,
	findall(Dier, isfam(Dier, dier), X),
	level_filter(X, 4, FX),
	write('Je kunt kiezen uit de dieren die er in Artis zijn. Dit zijn:\n'),
	show_list(FX),
	go_info_profile_2(2).

check_an(_, X) :-
	isfam(X, dier),
	!.

check_an(2, _) :-
	write('Dit is geen dier, of we hebben het dier niet.\n'),
	!,
	check_an(2, help).


check_an(1, _) :-
	write('Onbekende input. Je kunt kiezen uit deze dieren:\n'),
	!,
	check_an(1, help).

if_info_profile(2) :-
	write('Leuk dat je er bent! Wil je iets weten over een dier, of wil je iets weten over twee dieren tegelijk? Typ 1. of 2.\n'),
	read(X),
	go_info_profile_2(X).

go_info_profile_2(stop) :- !.

go_info_profile_2(1) :- !,
	write('Over welk dier wil je iets weten?\n'),
	read(X),
	go_2(X).

go_2(stop) :- !.

go_2(help) :-	!,
	findall(Dier, isfam(Dier, dier), X),
	level_filter(X, 4, FX),
	write('Je kunt kiezen uit de dieren die er in Artis zijn. Dit zijn:\n'),
	show_list(FX),
	go_info_profile_2(1).

go_2(Animal) :-
	isfam(Animal, dier),
	!,
	info_profile(Animal, 2).

go_2(_) :-
	write('Dit is geen dier, of we hebben het dier niet.\n'),
	!,
	go_2(help).

go_info_profile_2(2) :-
	write('Over welk dier wil je iets weten?\n'),
	read(X),
	check_an(2, X),
	write('Over welk dier wil je nog meer iets weten?\n'),
	read(Y),
	check_an(2, Y),
	info_profile(X, Y, 2).

go_info_profile_2(_) :-
	write('We snappen niet wat je bedoelt. Probeer het nog een keer.\n'),
	!,
	if_info_profile(2).


	