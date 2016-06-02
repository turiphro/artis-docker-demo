zoek_attributen(Dier, Attributen):-
  findall(Eigenschap/Waarde, hasprop(Dier, Eigenschap, Waarde), Attributen).
