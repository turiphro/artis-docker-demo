% Database met gebruikers in Artis, met hun profiel
% Auteur: Martijn van der Veen

% eigenschappen/[waarden]:
%  geboortejaar/[jaar]
%  niveau/[dom, normaal, ontwikkeld]
%  opmaak/[verhaal, tabel]
%  diereigenschappen/[lijstmeteigenschappen:[eigenschap/value]]
%  houdt_van/[voederen, schoonmaken, eten]
%  lievelingskleur/[kleur]



isa(martijn, bezoeker).
 prop(martijn, geboortejaar, 1989).
 prop(martijn, niveau, ontwikkeld).
 prop(martijn, opmaak, tabel).
 prop(martijn, diereigenschappen, 
[knuffact/knuffelbaar,grootte_orde/klein,grootte_orde/normaal,grootte_orde/groot,grootte_orde/huge,nodig/water,nodig/land]).
 prop(martijn, houdt_van, voederen).
 prop(martijn, lievelingskleur, oranje).



isa(yta, bezoeker).
 prop(yta, geboortejaar, 1985).
 prop(yta, niveau, dom).	% dom, normaal, ontwikkeld
 prop(yta, opmaak, verhaal).
 prop(yta, diereigenschappen, 
[knuffact/gevaarlijk,grootte_orde/groot,grootte_orde/huge,nodig/land]).
 prop(yta, houdt_van, schoonmaken).
 prop(yta, lievelingskleur, wit).


isa(cmap, bezoeker).
 prop(cmap, geboortejaar, 1813).
 prop(cmap, niveau, normaal).
 prop(cmap, opmaak, tabel).
 prop(cmap, diereigenschappen, [knuffact/gevaarlijk,grootte_orde/huge,nodig/water,nodig/cmap]).
 prop(cmap, houdt_van, cmap).
 prop(cmap, lievelingskleur, wit).


isa(leo, bezoeker).
 prop(leo, geboortejaar, 1970).
 prop(leo, niveau, ontwikkeld).
 prop(leo, opmaak, verhaal).
 prop(leo, diereigenschappen, [knuffact/knuffelbaar,grootte_orde/groot,grootte_orde/huge,nodig/land,nodig/water]).
 prop(leo, houdt_van, voederen).
 prop(leo, houdt_van, inparkeren).
 prop(leo, lievelingskleur, oranje).
 prop(leo, lievelingskleur, bruin).


isa(robrecht, bezoeker).
 prop(robrecht, geboortejaar, 1987).
 prop(robrecht, niveau, ontwikkeld).
 prop(robrecht, opmaak, tabel).
 prop(robrecht, diereigenschappen, [knuffact/gevaarlijk, nodig/land,nodig/water]).
 prop(robrecht, houdt_van, eten).
 prop(robrecht, lievelingskleur, zwart).
 prop(robrecht, lievelingskleur, blauw).

isa(eva, bezoeker).
 prop(eva, geboortejaar, 1985).
 prop(eva, niveau, ontwikkeld).
 prop(eva, opmaak, verhaal).
 prop(eva, diereigenschappen, 
[knuffact/knuffelbaar,grootte_orde/tiny,grootte_orde/klein,nodig/water,nodig/land]).
 prop(eva, houdt_van, voederen).
 prop(eva, lievelingskleur, paars).
 prop(eva, lievelingskleur, zwart).
