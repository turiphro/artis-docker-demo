% Communicatieve interactie
% 
% Artis project
%
% alg_dieropattribuut.pl, v0.3
%
% Moos Hueting: match_attributen, match_attribuut, vergelijk_lijsten,
% zoek_dier_op_attribuut, krijg_attributen, proces_attribuut.
%
% v0.2: match_attribuut aangepast dat hij alleen dieren vindt van level 4, met
% behulp van predicaat level_filter.
%
% v0.3: match_attribuut aangepast dat hij vindt op een gespecificeerd niveau.
%
% Gegeven een lijst met eigenschappen van een dier, zoek de dieren erbij die aan
% deze eigenschappen voldoen.


% he, niet binnen de files andere files consulten gekkie!
% je kan beter load_everything consulten en van daaruit werken.
% anders komen er van die vervelende loops, en dubbele facts.
%:- include('alg_overerving.pl').
%:- include('alg_vindlevel.pl').


% Zoek bij een gegeven eigenschap/value combinatie een lijst met dieren die deze
% eigenschap hebben.

match_attribuut(Eigenschap/Value, DierLijst, Level):-
  findall(Dier, hasprop(Dier, Eigenschap, Value), DierLijstZonderFilter),
  level_filter(DierLijstZonderFilter, Level, DierLijst).

match_attributen([], MatchLijst, MatchLijst, _):-
  !.
match_attributen([Head|Tail], [], EindLijst, Level):-
  !,
  match_attribuut(Head, MatchLijst, Level),
  match_attributen(Tail, MatchLijst, EindLijst, Level).

% Maak een lijst met dieren met een bepaalde attribuut en match deze lijst tegen
% de lijst met dieren van de vorige attribu(u)t(en).

match_attributen([Head|Tail], MatchLijst, EindLijst, Level):-
  match_attribuut(Head, DierLijst, Level),
  vergelijk_lijsten(DierLijst, MatchLijst, NMatchLijst),
  match_attributen(Tail, NMatchLijst, EindLijst, Level).

vergelijk_lijsten(Lijst1, Lijst2, ResLijst):-
  vergelijk_lijsten(Lijst1, Lijst2, [], RevResLijst),
  reverse(RevResLijst, ResLijst).

% Als een element uit 
vergelijk_lijsten([Head|Tail], Lijst2, AccumLijst, ResLijst):-
  select(Head, Lijst2, NLijst2), !,
  vergelijk_lijsten(Tail, NLijst2, [Head | AccumLijst], ResLijst).

vergelijk_lijsten([Head|Tail], Lijst2, AccumLijst, ResLijst):-
  \+ member(Head, Lijst2), !,
  vergelijk_lijsten(Tail, Lijst2, AccumLijst, ResLijst).

vergelijk_lijsten([], _, AccumLijst, AccumLijst):-
  !.

vergelijk_lijsten(_, [], AccumLijst, AccumLijst).

zoek_dier_op_attribuut:-
  krijg_attributen(LijstAttr),
  match_attributen(LijstAttr, [], EindLijst, 4),
  write('De gevonden dieren zijn:'),
  write(EindLijst).
  
krijg_attributen(Result):-
  writef('Geef een lijst met attributen van het dier in het format eigenschap/value.\n'),
  writef('Wanneer je klaar bent, geef je \'klaar\'.\n'),
  krijg_attr([], Result).

krijg_attr(Lijst, Result):-
  read(Attr),
  proces_attribuut(Attr, Lijst, Result).

proces_attribuut(klaar, Lijst, Lijst):-
  !.

proces_attribuut(Attr, Lijst, Result):-
  NewLijst = [Attr | Lijst],
  krijg_attr(NewLijst, Result).

