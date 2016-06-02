% Communicatieve interactie
% Overerving
% v0.3
%
% Moos Hueting: isa overerving
% Robrecht Jurriaan: prop overerving (hoger nivo geldt ook voor lager nivo)
% Martijn vd Veen: prop overruling (lager nivo kan hoger nivo uitschakelen)


hasprop(Dier, Eigenschap, Waarde) :-
  prop(Dier, Eigenschap, Waarde).

hasprop(Dier, Eigenschap, Waarde) :-
	isa(Dier, Voorouder),
	hasprop(Voorouder, Eigenschap, Waarde),
	\+ noprop(Dier, Eigenschap, Waarde).
	% overruling werkt zo:
	% je kan een specifieke eigenschap met spec. waarde
	% uitzetten, door toe te voegen:
	% noprop(pinguin, voortbewegen, vliegen).
	% De andere waarden (bijv. dat een pinguin kan lopen)
	% blijven gewoon behouden.

isfam(X, Z):-
  isa(X, Z).

isfam(X, Z):-
        isa(X, Y),
	isfam(Y, Z).

