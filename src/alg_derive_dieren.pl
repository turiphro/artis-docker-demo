% Derive uit bezoekersbestand
% Auteur: Robrecht Jurriaans

userpref(X, List):-
	isa(X, bezoeker),
	derive(X, Animals),
	putinone(Animals, Tmp),
	pickanimal(Tmp, [], Tmp2),
	eigenwil(X, Tmp2, Tmp3),       % Eigen wil van systeem (system is sentient, friggin python)
	remdup(Tmp3, Tmp4),
	anitono(Tmp4, Tmp5),
	remdup(Tmp5, List).

derive(X, List):-
	prop(X, diereigenschappen, Atts),
	zetomnaardier(Atts, [], List).

zetomnaardier([], X, X):-!.

zetomnaardier([Eig/Waarde|T], Crt, List):-
	findall(Animal, prop(Animal, Eig, Waarde), List1),
	zetomnaardier(T, [List1|Crt], List).

putinone([H, H2|T], Crt):-
	!,
	append(H,H2, H3),
	putinone([H3|T], Crt).

putinone([H], H):-!.


pickanimal([], X, X):-!.

pickanimal([H|T], Crt, List):-
	memberchk(H, T),!,
	pickanimal(T, [H|Crt], List).

pickanimal([_|T], Crt, List):-
	pickanimal(T, Crt, List).


eigenwil(User, Tmp4, List):-
	willeeftijd(User, Tmp4, Tmp5),
	wilspecifiek(Tmp5, Tmp6),
%	write(Tmp5),nl,
%	write(Tmp6),nl,
	wilkleur(User, Tmp6, List).
	
	
willeeftijd(User, Tmp4, Tmp5):-
	prop(User, geboortejaar, Birth),
	global_var(datum_jaar, Year),
	Age is Year-Birth,
	agepick(Age, Tmp4, Tmp5).

agepick(Age, Tmp4, [tijger|Tmp4]):-
	Age < 15,!.
agepick(Age, Tmp4, [leeuw|Tmp4]):-
	Age < 30,!.
agepick(_, Tmp4, [olifant|Tmp4]).


wilspecifiek(Tmp5, List2):-
	global_var(datum_jaar, Year),
	findall(Animal, jongdier(Year, Animal), List),
	makeanimal(List, Tmp6),
	append(Tmp6, Tmp5, List2).

jongdier(Year, Animal):-
	prop(Animal, geboorte,  _/_/Birth),
	X is Year-Birth,
	X =< 1.

makeanimal([], []):-!.

makeanimal([H|T], [Animal|Rest]):-
	isa(H, Animal),
	makeanimal(T, Rest).


wilkleur(User, Tmp6, List):-
	findall(Color, prop(User, lievelingskleur, Color), Colors),
	colorpick(Colors, [], Colorlist),
	append(Colorlist, Tmp6, List).

colorpick([], List, List):-!.

colorpick([H|T], Crt, List):-
	findall(Animal, prop(Animal, kleur, H), Colorani),
	append(Colorani, Crt, New),
	colorpick(T, New, List).


% ANImal to No.
% genereert een lijst verblijven aan de hand van een lijst dieren
anitono([], []):-!.

anitono([H|T], [No|List]):-
	prop(H, verblijf, No),!,
	anitono(T, List).

anitono([H|T], [H|List]):-
	anitono(T, List).

% Remove duplicates
remdup([], []):-!.

remdup([H|T], [H|List]):-
	\+ memberchk(H, T),!,
	remdup(T, List).

remdup([_|T], List):-
	remdup(T, List).









