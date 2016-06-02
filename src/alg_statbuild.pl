% Statistiek meters
% Auteur: Robrecht Jurriaans

statbuilding(No, List):-
	\+ var(No),
	findall(Att/Val, hasprop(No, Att, Val), List).

specifybuild(No):-
	\+ var(No),	
	statbuilding(No, List),
	prop(No, name, Name),
	isa(No, Type),
	writef('Stats for %w, %w\n',[No, Name]),
	writef('Type verblijf       : %w\n', [Type]),
	startprint(List),!.



startprint([]):-!.

startprint([Att/Val|Tail]):-
	\+ memberchk(Att/_, Tail),
        !,
	writef('%20l: %1l\n',[Att, Val]),
	startprint(Tail).

startprint([Att/Val|Tail]):-
	select(Att/Val2, Tail, Newtail),
	writef('%20l: %w en %w\n',[Att, Val, Val2]),
	startprint(Newtail).
	
exactbuild(No, No2:Building):-
	statbuilding(No, Attlist),
	select(loc/_, Attlist, Atts),
	isfam(No2, gebouw),
	number(No2),
	statbuilding(No2, Attlist2),
	select(loc/_, Attlist2, Atts2),
	compareatts(Atts, Atts2),
	prop(No2, name, Building).

comparebuild(No, Amount, No2:Building):-
	statbuilding(No, Attlist),
	select(loc/_, Attlist, Atts),
	isfam(No2, gebouw),
	number(No2),
	statbuilding(No2, Attlist2),
	select(loc/_, Attlist2, Atts2),
	remdup(Atts, NAtts),
	remdup(Atts2, NAtts2),
	compareatts(Amount, NAtts, NAtts2, Listing),
	write(Listing),
	prop(No2, name, Building).

% Compare attributes,
% succes als alle attributen gelijk zijn
compareatts(_, []):-!.

compareatts(Att, [H/Val|Tail]):-
	memberchk(H/Val, Att),!,
	compareatts(Att, Tail).

% Compare attributes met amount
% succes als het benodigd aantal overeenkomingen behaald wordt
compareatts(Count,_,[], []):-
	Count =< 0,
	!.

compareatts(Count, Att, [H/Val|Tail], [H/Val|Rest]):-
	Count >= 0,
	memberchk(H/Val, Att),!,
	Newc is Count-1,
	compareatts(Newc, Att, Tail, Rest).

compareatts(Count, Att, [_|Tail], Rest):-
	compareatts(Count, Att, Tail, Rest).

count(X,X).

count(X, Y):-
	X < 100,
	X2 is X+1,
	count(X2, Y).
	
