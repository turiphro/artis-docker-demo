% Routeplanner
% Auteur: Robrecht Jurriaans
% out-dated interface voor het opzetten van gebruikersprofiel
% en aan de hand van dat profiel wordt er een route bedacht.
% (is vervangen door globaal userprofiling)

% :-	write('Routeplanner \ntyp routestart\. om te beginnen\n').

routestart:-
	write('Er zijn 2 opties voor de routeplanner:\n'),
	write('Typ 1. om een route te plannen naar een bepaald punt.\n'),
	write('Typ 2. voor een advies voor een leuke route.\n'),
	read(X),
	goroute(X).

goroute(1):-
	!,
	routestartnormal.

goroute(2):-
	!,
	routestartpref.

goroute(help):-
	!,
	write('Typ 1 of 2 in gevolgd door een punt "."\n'),
	read(X),
	goroute(X).

goroute(X):-
	writef('%w is niet een optie, probeer opnieuw\n',[X]),
	read(Y),
	goroute(Y).

routestartnormal:-
	write('Welkom bij Artis-routeplanner\n'),
	write('Bij welk gebouw bent u nu? (typ help voor een lijst van gebouwnummers)\n'),
	read(X), 
	goroute1(X).

goroute1(X):-
	number(X),!,
	writef('U bent bij gebouw %w, naar welk gebouw wilt u?\n',[X]),
	read(Y),
	goroute2(X,Y).

goroute1(help):-
	!,
	findall(X, isfam(X, gebouw), List),
	showbuildinglist(List),nl,
	write('Dit zijn alle mogelijkheden, bij welk gebouw staat u nu?\n'),
	read(Y),
	goroute1(Y).

goroute1(quit):-!.

goroute1(X):-
	writef('%w is niet een mogelijkheid, typ help voor een lijst van de gebouwen\n',[X]),
	read(Y),
	goroute1(Y).

goroute2(X,Y):-
	number(Y),!,
	route(X, [Y], Path, _),
	shownormalpath(Path).

goroute2(Z,help):-
	findall(X, isfam(X, gebouw), List),
	showbuildinglist(List),nl,
	write('Dit zijn alle mogelijkheden, waar wilt u naar toe?\n'),
	read(Y),
	goroute2(Z, Y).

goroute2(_, quit):-!.

goroute2(X, X2):-
	writef('%w is niet een mogelijkheid, typ help voor een lijst van de gebouwen\n',[X2]),
	read(Y),
	goroute2(X,Y).


routestartpref:-
	write('Welkom bij Artis-routeplanner\n'),
	write('Bij welk gebouw bent u nu?\n'),
	read(X),
	gostart(X).

gostart(X):-
	number(X),!,
	write('Vraag 1:\nWelk type dier heeft uw voorkeur?
	\n1. Roofdier 2. Lieve dieren\n'),
	read(Cho),
	goquestion(X/Cho).

gostart(help):-
	!,
	findall(X, isfam(X, gebouw), List),
	showbuildinglist(List),
	read(Y),
	gostart(Y).

gostart(quit):-!.

gostart(X):-
	writef('%w is niet een optie, typ help voor een lijst van de gebouwen\n',[X]),
	read(Y),
	gostart(Y).
	

goquestion(X/Cho):-
	member(Cho, [1,2]),!,
	write('Vraag 2:\nWelk type dier heeft uw voorkeur?
	\n1. Grote dieren 2. Kleine dieren\n'),
	read(Cho2),
	goquestion2(X/Cho/Cho2).

goquestion(_/quit):-!.

goquestion(X/Cho):-
	writef('%w is niet een optie,\n',[Cho]),
	gostart(X).

goquestion2(X/Cho/Cho2):-
	member(Cho2, [1,2]),!,
	write('Vraag 3:\nWelk type dier heeft uw voorkeur?
	\n1. Land-dieren 2. Water-dieren\n'),
	read(Cho3),
	gochoice(X/Cho/Cho2/Cho3).

goquestion2(_/_/quit):-!.

goquestion2(X/Cho/Cho2):-
	writef('%w is niet een optie,\n',[Cho2]),
	goquestion(X/Cho).


% Stuurt de routeplanner aan met een gebruikersprofiel
gochoice(X/Y1/Y2/Y3):-
	member(Y3, [1,2]),!,
	derive1(Y1, List1),
	derive2(Y2, List2),
	derive3(Y3, List3),
	favourite(List1,List2,List3, Tmplist2),
%	append(List1,List2, Tmplist),
%	append(List3, Tmplist, Tmplist2),
	remdup(Tmplist2, AniList),
	anitono(AniList, List),
%	write(List).
	routeplan(X, List, [], Path),
	showpath(Path).

gochoice(_/_/_/quit):-!.

gochoice(X/Cho/Cho2/Cho3):-
	writef('%w is niet een optie,\n',[Cho3]),
	goquestion2(X/Cho/Cho2).



% derivepredikaten
% genereren een lijst op basis van attributen
% hoeveel dieren er ook zijn, dit predikaat werkt dynamisch
derive1(1, List):-
	match_attributen([knuffact/gevaarlijk], [], List, 4).

derive1(2, List):-
	match_attributen([knuffact/knuffelbaar], [], List, 4).

derive2(1, List):-
	match_attributen([grootte_orde/groot], [], List1, 4),
	match_attributen([grootte_orde/huge], [], List2, 4),
	append(List1, List2, List).

derive2(2, List):-
	match_attributen([grootte_orde/tiny], [], List1, 4),
	match_attributen([grootte_orde/klein], [], List2, 4),
	match_attributen([grootte_orde/medium], [], List3, 4),
	append(List1, List2, List4),
	append(List3, List4, List).


derive3(1, List):-
	match_attributen([nodig/land], [], List, 4).

derive3(2, List):-
	match_attributen([nodig/water], [], List, 4).



% Favourite-predikaat
% kiest uit 3 lijsten met dieren de leukste eruit,
% dit predikaat kan makkelijk aangepast worden om meer lijsten te
% vergelijken. Zo kan een langere lijst vragen gecreert worden
favourite(L1, L2, L3, List):-
	getdoubles(L1, L2, D1),
	getdoubles(L1, L3, D2),
	getdoubles(L2, L3, D3),
	append(D1, D2, D4),
	append(D3, D4, List).

% getdoubles vergelijkt 2 lijsten en genereert een lijst van
% objecten die in beide lijsten voorkomen.
getdoubles([], _ , []):-!.

getdoubles([H|T], List, [H|Rest]):-
	memberchk(H, List),!,
	getdoubles(T, List, Rest).

getdoubles([_|T], List, Rest):-
	getdoubles(T, List, Rest).


% Show building list
showbuildinglist([]):-!.

showbuildinglist([H|T]):-
	number(H),!,
	prop(H, name, Name),
	writef('Gebouw %3l:%w\n',[H,Name]),
	showbuildinglist(T).

showbuildinglist([_|T]):-
	showbuildinglist(T).


shownormalpath([X]):-
	prop(X, name, Name),
	writef('U bent bij uw eindbestemming: gebouw %w:%w\nTyp ; in voor een alternatieve route\n',[X,Name]),
	write('Een prettige dag nog verder!'),!.

shownormalpath([H,H2|T]):-
	prop(H, name, Name),
	prop(H2, name, Name2),
	writef('U bent bij gebouw %w:%w\n',[H,Name]),
	writef('Loopt u verder naar gebouw %w:%w\n',[H2,Name2]),
	write('-------------------------------------------------'),nl,
	shownormalpath([H2|T]).








