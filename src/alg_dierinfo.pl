% auteur: Moos Hueting

geefinfo:-
  getuser(Gebruiker),
  getanimal(Dier),
  getuserprops(Gebruiker, Props),
  geefinfo(Dier, Props).

getuser(Gebruiker):-
  writef('Wie ben je?\n'),
  read(Gebruiker).

getanimal(Dier):-
  writef('Over welk dier wil je informatie hebben?\n'),
  read(Dier).

geefinfo(Dier, [Weergave, Verbositeit]):-
  zoek_attributen(Dier, Attrib),
  niveau(Verbositeit, GewensteEigenschappen),
  verbos_stripper(Attrib, GewensteEigenschappen, [], NewAttrib),
  printinfo(NewAttrib, Weergave).
  
niveau(dom, [naam, verblijf, eten, knuffact, grootte_orde]).
niveau(normaal, [naam, verblijf, kleur, eten, gewicht, grootte, grootte_orde]).
niveau(ontwikkeld, [naam, latijn, verblijf, kleur, gewicht, grootte, eten, voortbewegen, knuffact, grootte_orde]).

verbos_stripper([], _, NewAttrib, NewAttrib):-
  !.

verbos_stripper([Eigenschap/Waarde | Tail], GewEig, Accum, NewAttrib):-
  select(Eigenschap, GewEig, Rest), !,
  verbos_stripper(Tail, Rest, [Eigenschap/Waarde | Accum], NewAttrib).

verbos_stripper([Eigenschap/_ | Tail], GewEig, Accum, NewAttrib):-
  \+ member(Eigenschap, GewEig), !,
  verbos_stripper(Tail, GewEig, Accum, NewAttrib).

printinfo([], _):-
  !.

printinfo([Eigenschap/Waarde | Tail], tabel):-
  sleep(0.1),
  writef('%19l: %w\n', [Eigenschap, Waarde]),
  printinfo(Tail, tabel).

printinfo([Eigenschap/Waarde | Tail], verhaal):-
  sleep(0.1),
  writef('De eigenschap %w heeft de waarde %w.\n', [Eigenschap, Waarde]),
  printinfo(Tail, verhaal).




getuserprops(Gebruiker, [Weergave, Niveau]):-
  user_getprops(Gebruiker, Props),
  member(opmaak/Weergave, Props),
  member(niveau/Niveau, Props).
