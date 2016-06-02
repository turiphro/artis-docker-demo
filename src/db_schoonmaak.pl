% stukje interface, voor test-doeleinden
% Auteur: Eva Greiner


maak_gebouw_schoon(Gebouw) :-
	get_stats_b(Gebouw, SoortGebouw, Nachthok, Gevaarlijk),
	writef('Om gebouw %w schoon te maken zijn de volgende materialen nodig:\n',
		[Gebouw]),
	verzamel_materialen(SoortGebouw, MatList),
	danger_mat(MatList, Gevaarlijk, Nachthok, NewMatList),
	show_list(NewMatList),
	writef('Om de veiligheid te waarborgen zijn de volgende stappen nodig:\n'),
	stel_veilig(Gevaarlijk, Nachthok, SafeList),
	show_safe(SafeList),
	write('Om het gebouw schoon te maken zijn de volgende stappen nodig:\n'),
	maak_schoon(SoortGebouw, CleanList),
	show_list(CleanList),
	write('Om het schoonmaken af te sluiten zijn de volgende stappen nodig:\n'),
	sluit_af(Gevaarlijk, Nachthok, LockList),	
	show_list(LockList).
	
show_safe([]) :- !,
	write('Veiligstellen niet nodig.\n').

show_safe(List) :-
	show_list(List).	

show_list([]).

show_list([H|T]) :-
	sleep(0.1),
	writef('- %w\n',[H]),
	show_list(T).

get_stats_b(Gebouw, SoortGebouw, Nachthok, Gevaarlijk) :-
	isa(Gebouw, SoortGebouw),
	get_nachthok(Gebouw, Nachthok),
	writef('Gebouw %w is een %w. Het heeft een %w.\n', [Gebouw, SoortGebouw,
		Nachthok]),
	get_danger_b(Gebouw, Gevaarlijk).

get_nachthok(Gebouw, nachthok) :-
	prop(Gebouw, attribute, nachthok),
	!.

get_nachthok(_, geen_nachthok).

get_danger_b(Gebouw, gevaarlijk) :-
	prop(Gebouw, resident, Animal),
	get_danger_a(Animal, gevaarlijk),
	!,
	writef('Er zit een %w in dit gebouw. Dit dier is gevaarlijk.\n', [Animal]).

get_danger_b(Gebouw, ongevaarlijk):-
	prop(Gebouw, resident, Animal),
	writef('Er zit een %w in gebouw %w. Dit dier is ongevaarlijk.\n',
		[Animal, Gebouw]). 
% einde interface

verzamel_materialen(aquarium, [spons, glasreiniger, emmer, slang, vuilniszak]).
verzamel_materialen(kooi, [hark, schep, emmer, bezem, bodembedekking,
	vuilniszak]).
verzamel_materialen(vijver, [schepnet, emmer, bezem, vuilniszak]).
verzamel_materialen(terrarium, [emmer, spons, glasreiniger, vuilniszak]).
verzamel_materialen(voliere, [hark, emmer, bezem, vuilniszak]).

danger_mat(L, gevaarlijk, geen_nachthok, [verdovingsgeweer|L]) :- !.
danger_mat(L,  _, nachthok,L) :- !.
danger_mat(L, ongevaarlijk, _, L) :- !.
	
stel_veilig(ongevaarlijk, _, []) :- !.
stel_veilig(gevaarlijk, nachthok, SafeList) :- !,
	jaag_dier_in_nachthok(JaagList),
	nachthok_afsluiten(NhLockList),
	append([JaagList, NhLockList], SafeList).
stel_veilig(gevaarlijk, geen_nachthok, SafeList) :- !,
	verdoof_dier(VerdList),
	append([VerdList], SafeList).

jaag_dier_in_nachthok(['het dier in het nachthok jagen']).
nachthok_afsluiten(['het nachthok afsluiten']).
verdoof_dier(['het dier verdoven']).

maak_schoon(kooi, KooiList) :-
	verwijder_bodembedekking(BodVerList),
	verwijder_uitwerpselen(UitVerList),
	maak_vloer_schoon(VloerList),
	nieuwe_bodembedekking(NwBodList),
	append([BodVerList, UitVerList, VloerList, NwBodList], KooiList).
maak_schoon(aquarium, AqList) :-
	maak_aquarium_schoon(Aq1List),
	ververs_water(WaterList),
	append([Aq1List, WaterList], AqList).
maak_schoon(voliere, VolList) :-
	verwijder_uitwerpselen(UitVerList),
	verwijder_veren(VeerVerList),
	maak_vloer_schoon(VloerList),
	append([UitVerList, VeerVerList, VloerList], VolList).
maak_schoon(terrarium, TerList) :- 
	verwijder_bodembedekking(BodVerList),
	maak_terrarium_schoon(Ter1List),
	nieuwe_bodembedekking(NwBodList),
	append([BodVerList, Ter1List, NwBodList], TerList).
maak_schoon(vijver, VijList) :-
	haal_zooi_uit_water(VijList).

verwijder_bodembedekking(BodVerList) :-
	hark_bodembedekking(HarkList),
	doe_in_vuilniszak(bodembedekking, ZakList),
	append([HarkList, ZakList], BodVerList).
hark_bodembedekking(['bodembedekking harken']).
doe_in_vuilniszak(X, [X' 'H]) :-
	H = 'in vuilniszak doen'.

verwijder_uitwerpselen(UVList) :-
	schep_uitwerpselen(SUList),
	doe_in_vuilniszak(uitwerpselen, ZakList),
	append([SUList, ZakList], UVList).
schep_uitwerpselen(['uitwerpselen scheppen']).

verwijder_veren(VVList) :-
	pluk_veren(PVList),
	raap_veren(RVList),
	doe_in_vuilniszak(veren, ZakList),
	append([PVList, RVList, ZakList], VVList).
pluk_veren(['veren uit gaas plukken']).
raap_veren(['veren oprapen']).	
	
nieuwe_bodembedekking(['nieuwe bodembedekking neerleggen']).

maak_vloer_schoon(VloerList) :-
	spuit_vloer_nat(SVList),
	borstel_vloer(BVList),
	water_weglopen(WWList),
	append([SVList, BVList, WWList], VloerList).
spuit_vloer_nat(['vloer natspuiten']).
borstel_vloer(['vloer borstelen']).
water_weglopen(['water laten weglopen']).
maak_aquarium_schoon(AqList) :-
	poets_ruit(RList),
	poets_muren(MList),
	poets_bodem(BList),
	append([RList, MList, BList], AqList).
poets_ruit(['ruit poetsen']).
poets_muren(['muren poetsen']).
poets_bodem(['bodem poetsen']).

maak_terrarium_schoon(TerList) :-
	poets_ruit(RList),
	poets_muren(MList),
	append([RList, MList], TerList).

ververs_water(VWList) :-
	pomp_weg(PList),
	vul_aan(VList),
	append([PList, VList], VWList).
pomp_weg(['een derde deel van het water wegpompen']).
vul_aan(['aanvullen met vers water']).

haal_zooi_uit_water(ZWList) :-
	schep_zooi(ZList),
	doe_in_vuilniszak(zooi, ZakList),
	append([ZList, ZakList], ZWList).
schep_zooi(['zooi uit water scheppen']).

sluit_af(gevaarlijk, nachthok, LockList) :- !,
	laat_uit_nh(LUList),
	maak_nachthok_schoon(NhList),
	sluit(SList),
	append([LUList, NhList, SList], LockList).

sluit_af(_, _, LockList) :- !,
	sluit(LockList).

laat_uit_nh(LUList) :-
	uit_nh_laten(UNList),
	nachthok_sluiten(SNList),
	append([UNList, SNList], LUList).
uit_nh_laten(['dier uit nachthok in hok laten']).
nachthok_sluiten(['nachthok sluiten']).

maak_nachthok_schoon(NhList) :-
	verwijder_bodembedekking(BodVerList),
	maak_vloer_schoon(VloerList),
	nieuwe_bodembedekking(NwBodList),
	append([BodVerList, VloerList, NwBodList], List),
	add_to_item('nachthok:', List, NhList).
	
add_to_item(_, [], []) :- !.

add_to_item(X, [H|T], [X' 'H|NT]) :-
	add_to_item(X, T, NT).

sluit(['hok afsluiten']).	

