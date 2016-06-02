% Bepaling benodigdheden dier\
% Auteur: Robrecht Jurriaans
% 
% predikaten voor bepaling geschiktheid van verblijf voor dieren
% en bepaling geschikte verblijven voor specifieke dieren
% 

% Buildingcheck geeft lijst van dieren die in een verblijf kunnen
% Eerst zoekt het predikaat alle eigenschappen van een gebouw
% die worden vervolgens vergeleken met alle dieren en zo ontstaat er
% een lijst met alle mogelijke dieren
buildingcheck(No, Truelist):-
	findall(Mat, hasprop(No, _, Mat), Matlist),
	findall(Animals, findani(Matlist, Animals), List),
	remdup(List, Truelist).

%findani zoekt een dier waarvoor alle benodigheden aanwezig zijn.
findani(Mats, Animal):-
	prop(Animal, naam, _),
	findall(Need, hasprop(Animal, nodig, Need), Needs),
	remdup(Needs, Needlist),
        compare(Needlist, Mats).

% Animalcheck geeft lijst van gebouwen waar een dier in zou kunnen
% werkt in principe exact hetzelfde als buildingcheck alleen dan
% andersom
animalcheck(Ani, Truelist):-
	findall(Need, hasprop(Ani, nodig, Need), Needs),
	remdup(Needs, Needs2),
	findall(Buildings, findbuild(Needs2, Buildings), List),
	remdup(List, Truelist).

findbuild(Needs, Building):-
	prop(Building, loc, _),
	findall(Mat, hasprop(Building, _, Mat), Matlist),
	compare(Needs, Matlist).


% Kijkt of alle needs van een dier bij een gebouw aanwezig zijn
compare([], _):-!.
compare([H|T], Mats):-
	memberchk(H, Mats),
	compare(T, Mats).

















/*
needs(Animal, Needs):-
	isa(Animal, Type),
	findall(X, prop(Type, need, X), Needs).  % need moet worden: heeft_nodig


% Bepaling geschiktheid van verblijf

buildingcheck(Building, Animallist):-
	findall(X, prop(Building, materiaal, X), Matlist),
	findall(X2, prop(Building, attribute, X2), Attlist),
	prop(Building, afsluiting, Close),
	prop(Building, grootte, Size),
	gobcheck(Matlist/Attlist/Size/Close, Animallist).

gobcheck(Mlist/Alist/Size/Close, Anilist):-
	findall(Animal, needs(Animal, Mlist/Alist/Size/Close), Anilist).
	
needs(Ani, Mlist/Alist/Size/Close):-
	checkmaterial(Ani, Mlist),
	checkatt(Ani, Alist),
	prop(Ani, grootte_orde, Size),
	prop(Ani, afsluiting, Close).

checkmaterial(Ani, Mlist):-
	findall(Mats, hasprop(Ani, nodig, Mats), Mlist2),
	write(Mlist2),
	mchecker(Mlist, Mlist2).

mchecker(_, []).

mchecker(Mlist, [H|T]):-
	memberchk(H, Mlist),
	mchecker(Mlist, T).


checkatt(Ani, Alist):-
	findall(Atts, prop(Ani, atts, Atts), Alist2),
	mchecker(Alist, Alist2).

achecker(_, []).

achecker(Alist, [H|T]):-
	memberchk(H, Alist),
	mchecker(Alist, T).
*/
