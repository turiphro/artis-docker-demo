% Robrecht Jurriaans


routestart(Startingpoint, User):-
	userpref(User, Animals),
	routeplan(Startingpoint, Animals, [], Path),
	showpath(Path, User).
