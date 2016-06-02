% Communicatieve interactie
% 
% Artis project
%
% alg_vindlevel.pl, v0.1
%
% Moos Hueting: vind_level, level_filter
% Robrecht: specific (laagste level/onderste node in boom)
%
%
% vind_level: vindt het niveau van een gegeven entiteit, bijvoorbeeld
% zoogdier/2, kameel/4, etc.
%
% level_filter: filtert een lijst met entiteiten en geeft dan alleen de
% entiteiten van level Level terug.


specific(X):-
        isa(X,_ ),
        \+ isa(_, X).


vind_level(dier, 1):-
  !.

vind_level(Ding, Level):-
  isa(Ding, HogerDing),
  vind_level(HogerDing, HogerLevel),
  Level is HogerLevel + 1.

level_filter([], _, []):-
  !.

level_filter([Head | Tail], Level, [Head | FilteredTail]):-
  vind_level(Head, Level), !,
  level_filter(Tail, Level, FilteredTail).

level_filter([Head | Tail], Level, FilteredTail):-
  \+ vind_level(Head, Level),
  level_filter(Tail, Level, FilteredTail).

