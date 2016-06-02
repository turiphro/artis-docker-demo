% What an animal wants
% Auteur: Robrecht Jurriaans

% Juiste grootte verblijf
prop(Ani, nodig, tiny):-
	isfam(Ani, dier),
	prop(Ani, grootte_orde, tiny).

prop(Ani, nodig, klein):-
	isfam(Ani, dier),
	prop(Ani, grootte_orde, klein).

prop(Ani, nodig, medium):-
	isfam(Ani, dier),
	prop(Ani, grootte_orde, medium).

prop(Ani, nodig, groot):-
	isfam(Ani, dier),
	prop(Ani, grootte_orde, groot).

prop(Ani, nodig, huge):-
	isfam(Ani, dier),
	prop(Ani, grootte_orde, huge).


prop(No, grootte_orde, tiny):-
	isfam(No, gebouw),
	prop(No, grootte_orde, klein);
	prop(No, grootte_orde, medium);
	prop(No, grootte_orde, groot);
	prop(No, grootte_orde, huge).

prop(No, grootte_orde, klein):-
	isfam(No, gebouw),
	prop(No, grootte_orde, medium);
	prop(No, grootte_orde, groot);
	prop(No, grootte_orde, huge).

prop(No, grootte_orde, medium):-
	isfam(No, gebouw),
	prop(No, grootte_orde, groot);
	prop(No, grootte_orde, huge).

prop(No, grootte_orde, groot):-
	isfam(No, gebouw),
	prop(No, grootte_orde, huge).
