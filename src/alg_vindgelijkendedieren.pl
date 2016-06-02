% Communicatieve interactie
% 
% Artis project
%
% alg_vindgelijkendedieren.pl, v0.1
%
% Moos Hueting: vraag_welke_eigenschappen, filter_attributen,
% vind_matchende_dieren.
%
% vraag_welke_eigenschappen: kleine interface die vraagt welke
% eigenschappen gematched moeten worden.
%
% filter_attributen: laat uit lijst met eigenschap/waarde values alleen de
% paren door waarvan eigenschap ook in Eigenschappen voor komt.
%
% vind_matchende_dieren: vindt alle dieren die voldoen aan dezelfde
% waardes voor de gegeven eigenschappen van het gegeven dier.
%

vraag_welke_eigenschappen(Dier, AttrList):-
  findall(Eigenschap, hasprop(Dier, Eigenschap, _), EigList),
  writef('De entiteit \'%q\' heeft de volgende eigenschappen:\n', [Dier]),
  write(EigList), nl,
  writef('Geef de eigenschappen waar je op wilt matchen:\n'),
  read(GewensteEigenschappen),
  zoek_attributen(Dier, Attributen),
  filter_attributen(Attributen, GewensteEigenschappen, AttrList).

filter_attributen([], _, []):-
  !.

% Als eigenschap member is van  Eigenschappen moet hij ook in de
% uiteindelijke lijst komen, anders niet.

filter_attributen([Eigenschap/Waarde|Tail], Eigenschappen, [Eigenschap/Waarde|FilterTail]):-
  member(Eigenschap, Eigenschappen), !,
  filter_attributen(Tail, Eigenschappen, FilterTail).

filter_attributen([Eigenschap/_|Tail], Eigenschappen, FilterTail):-
  \+ member(Eigenschap, Eigenschappen), !,
  filter_attributen(Tail, Eigenschappen, FilterTail).

% We willen alleen matchende entiteiten op hetzelfde niveau vinden,
% vandaar vind_level.

vind_matchende_dieren(Dier, Lijst):-
  vind_level(Dier, Level),
  vraag_welke_eigenschappen(Dier, AttrList),
  match_attributen(AttrList, [], Lijst, Level).
