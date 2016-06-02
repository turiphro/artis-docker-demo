/***********************************
Universiteit van Amsterdam
Bachelor Kunstmatige Intelligentie
jaar 1, blok 3: Communicatieve Interactie
Artis project
Groep 1

Auteur: Eva Greiner

Redeneren over de dieren en de procedurele kennis over de dieren.
Met het predicaat info/1 wordt informatie over een specifiek dier opgevraagd.
Met het predicaat info/2 wordt informatie over twee dieren opgevraagd en wordt
deze informatie met elkaar vergeleken.
***********************************/

% hulppredicaat:
% vergelijk twee lijsten met elkaar en geef twee lijsten terug met de items
% die in slechts een van de twee lijsten voorkomen.
% voor de overeenkomsten, zie het predicaat vergelijk_lijsten/3 in
% alg_dieropattribuut.pl
verschillen(L1, L2, Only1, Only2) :-
	findall(X, (member(X, L1), \+ member(X, L2)), Only1),
	findall(X, (member(X, L2), \+ member(X, L1)), Only2).

% interface voor een dier
info(Animal) :-
	get_type(Animal, TypeList),
	write('Dit dier behoort tot de volgende typen:\n'),
	show_list(TypeList),
	nl,	sleep(1),
	get_cleaning(Animal, MatList, StepList),
	writef('Om het verblijf van een %w schoon te maken zijn de volgende materialen nodig:\n', [Animal]),
	show_list(MatList),
	nl,	sleep(1),
	write('Voor het schoonmaken zijn de volgende stappen nodig:\n'),
	show_list(StepList),
	nl, sleep(1),
	voer(Animal).

% haal gegevens over het type van het dier op
get_type(Animal, TypeList) :-
	findall(Type, isfam(Animal, Type), TypeList).

% haal gegevens over het schoonmaken van het verblijf van het dier
% (zie db_schoonmaak.pl)
get_cleaning(Animal, MatList, StepList) :-
	prop(Animal, verblijf, Loc),
	get_danger_a(Animal, Gevaarlijk),
	isa(Loc, Type),
	get_nachthok(Loc, Nachthok),
	verzamel_materialen(Type, MList),
	danger_mat(MList, Gevaarlijk, Nachthok, MatList),
	stel_veilig(Gevaarlijk, Nachthok, SafeList),
	maak_schoon(Type, CleanList),
	sluit_af(Gevaarlijk, Nachthok, LockList),
	append([SafeList, CleanList, LockList], StepList).

% interface voor twee dieren
info(Animal1, Animal2) :-
	Animal1 = Animal2,
	!,
	write('Deze dieren zijn hetzelfde.\n'),
	info(Animal1).

info(Animal1, Animal2) :-
	info_type(Animal1, Animal2),
	nl, sleep(1),
	info_cleaning(Animal1, Animal2),
	nl, sleep(1),
	info_feeding(Animal1, Animal2).

% vergelijk de typen waar de dieren onder vallen
info_type(Animal1, Animal2) :-
	get_type(Animal1, List1),
	writef('De %w valt onder de volgende klassen:\n', [Animal1]),
	show_list(List1),
	get_type(Animal2, List2),
	writef('De %w valt onder de volgende klassen:\n', [Animal2]),
	show_list(List2),
	vergelijk_lijsten(List1, List2, CList),
	write('Ze komen overeen in de volgende klassen:\n'),
	show_list(CList).

% vergelijk de schoonmaakprocedures
info_cleaning(Animal1, Animal2) :-
	get_cleaning(Animal1, MatList1, StepList1),
	get_cleaning(Animal2, MatList2, StepList2),
	info_mat(Animal1, Animal2, MatList1, MatList2),
	info_steps(Animal1, Animal2, StepList1, StepList2).

% vergelijk de lijsten met benodigde materialen
info_mat(_, _, MatList1, MatList2) :-
	verschillen(MatList1, MatList2, [], []),
	!,
	vergelijk_lijsten(MatList1, MatList2, List),
	print_ov(mat, List).

info_mat(Animal1, Animal2, MatList1, MatList2) :-
	vergelijk_lijsten(MatList1, MatList2, List),
	print_ov(mat, List),
	verschillen(MatList1, MatList2, MatOnly1, MatOnly2),
	print_versch(mat, Animal1, MatOnly1),
	print_versch(mat, Animal2, MatOnly2).

% vergelijk de lijsten met benodigde stappen
info_steps(_, _, StepList1, StepList2) :-
	verschillen(StepList1, StepList2, [], []),
	!,
	vergelijk_lijsten(StepList1, StepList2, List),
	print_ov(step, List).

info_steps(Animal1, Animal2, StepList1, StepList2) :-
	vergelijk_lijsten(StepList1, StepList2, List),
	print_ov(step, List),
	verschillen(StepList1, StepList2, StepOnly1, StepOnly2),
	print_versch(step, Animal1, StepOnly1),
	print_versch(step, Animal2, StepOnly2).

% vergelijk de informatie over het eten geven
info_feeding(Animal1, Animal2) :-
	get_feeding(Animal1, Gev1, _, Eetg1, Hoev1, Srt1),
	get_feeding(Animal2, Gev2, _, Eetg2, Hoev2, Srt2),
	info_eetg(Animal1, Animal2, Eetg1, Eetg2),
	info_srt(Animal1, Animal2, Srt1, Srt2),
	info_hoev(Animal1, Animal2, Hoev1, Hoev2),
	info_gev(Animal1, Animal2, Gev1, Gev2).

% vergelijk de eetgewoonten van de dieren
info_eetg(_, _, Eetg1, Eetg2) :-
	Eetg1 = Eetg2,
	!,
	writef('Beide dieren zijn %w.\n', [Eetg1]).
info_eetg(Animal1, Animal2, Eetg1, Eetg2) :-
	writef('De %w is een %w, maar de %w is een %w.\n', [Animal1, Eetg1, Animal2,
		Eetg2]).

% vergelijk informatie over wat de dieren te eten krijgt
info_srt(_, _, Srt1, Srt2) :-
	verschillen(Srt1, Srt2, [], []),
	!,
	vergelijk_lijsten(Srt1, Srt2, List),
	print_ov(srt, List).
info_srt(Animal1, Animal2, Srt1, Srt2) :- 
	vergelijk_lijsten(Srt1, Srt2, List),
	print_ov(srt, List),
	verschillen(Srt1, Srt2, Only1, Only2),
	print_versch(srt, Animal1, Only1),
	print_versch(srt, Animal2, Only2).

% vergelijk informatie over hoeveel de dieren te eten krijgen
info_hoev(_, _, Hoev1, Hoev2) :-
	Hoev1 = Hoev2,
	!,
	writef('Beide dieren krijgen %w te eten.\n', [Hoev1]).
info_hoev(Animal1, Animal2, Hoev1, Hoev2) :-
	writef('De %w krijgt %w te eten en de %w krijgt %w te eten.\n', [Animal1, 
		Hoev1, Animal2, Hoev2]).

% vergelijk informatie over of de dieren gevaarlijk zijn
info_gev(_, _, gevaarlijk, gevaarlijk) :-
	!,
	write('Beide dieren zijn gevaarlijk. Het eten dient bij beide van een afstand in de kooi gegooid te worden.\n').
info_gev(_, _, ongevaarlijk, ongevaarlijk) :-
	!,
	write('Beide dieren zijn ongevaarlijk. Het eten kan in de verblijven gelegd worden.\n').
info_gev(Animal1, Animal2, Gev1, Gev2) :-
	writef('De %w is %w. ', [Animal1, Gev1]),
	print_dng(Animal1, Gev1),
	writef('De %w is %w. ', [Animal2, Gev2]),
	print_dng(Animal2, Gev2).

print_dng(Animal, gevaarlijk) :-
	!,
	writef('Zijn of haar eten dient daarom van een afstand in het verblijf gegooid te worden.\n', [Animal]).
print_dng(Animal, _) :-
	writef('Zijn of haar eten kan daarom in het verblijf gelegd worden.\n', [Animal]).

% print overeenkomsten tussen dieren
print_ov(_, []) :- !.

print_ov(mat, List) :-
	write('Voor het schoonmaken van de verblijven van beide dieren zijn de volgende materialen nodig:\n'),
	show_list(List).

print_ov(step, List) :-
	write('Voor het schoonmaken van de verblijven van beide dieren zijn de volgende stappen nodig:\n'),
	show_list(List).

print_ov(srt, List) :-
	write('Beide dieren krijgen het volgende te eten:\n'),
	show_list(List).

% print verschillen tussen dieren
print_versch(_, _, []) :- !.

print_versch(mat, Animal, List) :-
	writef('Voor de %w zijn de volgende materialen nodig:\n',
		[Animal]),
	show_list(List).

print_versch(step, Animal, List) :-
	writef('Voor de %w zijn de volgende stappen nodig:\n',
		[Animal]),
	show_list(List).

print_versch(srt, Animal, List) :-
	writef('De %w krijgt:\n', [Animal]),
	show_list(List).


