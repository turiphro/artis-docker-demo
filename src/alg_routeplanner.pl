% Structurele redenering
% Auteur: Robrecht Jurriaans
% A* algoritme door Floris Linnenbank
% Routeplanner
% zoekalgoritme A*, heuristiek: straightline distance
% routeplanner maakt gebruik van lijst van dieren waar men naartoe wilt
% 
% Robrecht Jurriaans: move/3, estimate/2, showpath/1
%
% v0.1: A* ingevoegd, estimate/2 en move/3 ge-implementeerd
% * Wordt nog uitgebreid met showpath voor graphische weergave
%
% v0.2: showpath/1 ge-implementeerd, deze wordt nog uitgebreid met:
% * Vloeiender taalgebruik in showpath/1
%   - Herkenning van beginpositie
%   - Herkenning van eindpunt
%   - Informatie bij tussenstappen minder uitgebreid
%   
% v0.3:  showpath/1 verbeterd, showpath/2 gemaakt voor Userprofiling
%        


solve_astar(State, Path/Cost):-
	estimate(State, E),
	astar([[State]/0/E],RPath/Cost/_),
	reverse(RPath,Path).

astar(Paths,Path):-
	get_best(Paths,Path),
	Path = [Node|_]/_/_,
	goal(Node).

astar(Paths,SolutionPath):-
	get_best(Paths, BestPath),
	select(BestPath, Paths, OtherPaths),
	expand_astar(BestPath, ExpPaths),
	append(OtherPaths, ExpPaths, NewPaths),
	astar(NewPaths, SolutionPath).

get_best([Path],Path):-
	!.

get_best([P1/C1/E1, _/C2/E2|Paths], BestPath):-
	C1 + E1 =< C2 + E2,
	!,
	get_best([P1/C1/E1|Paths], BestPath).

get_best([_|Paths],BestPath):-
	get_best(Paths,BestPath).	

move_astar([Node|Path]/C/_,
		  [NewNode, Node|Path]/NewC/E):-
	move(Node,NewNode, StepC),
	\+ member(NewNode, Path),
	NewC is C + StepC,
	estimate(NewNode,E).

expand_astar(Path,Exp):-
	findall(New, move_astar(Path, New), Exp).

% making the goal/1 predicate dynamic to be able to set it dynamically
:- dynamic goal/1.

% Routeplan is een predikaat met 4 argumenten:
% Het eerste argument is de startlocatie voor A*
% Tweede argument staat voor alle overgebleven goals
% Derde argument is het pad tot nu toe
% vierde argument is het uiteindelijke antwoord

% Basecase for routeplan
% alle "goals" zijn op
routeplan(_, [], RevPath, Path):-
	reverse(RevPath, Path),!.

% Hoofdpredikaat voor routeplan
% Plant een route, haalt het gevonden gebouw uit de lijst
% en gebruikt deze om opnieuw een route te plannen vanaf daar
routeplan(Start, Currentlist, PathUntilNow, Path):-
	route(Start, Currentlist, Route, _),
	reverse(Route, [Found|_]),
	select(Found, Currentlist, Newgoals),
	routeplan(Found, Newgoals, [Route|PathUntilNow], Path).

% Route zet alle overgebleven goals neer
% en gebruikt A* om het volgende gebouw te vinden
route(CityA, CityB, Path, Cost):-
	set_goal(CityB),
	solve_astar(CityA, Path/Cost).


set_goal(GoalState):-
	retractall(goal(_)),
	go_asserta(GoalState).

go_asserta([]):-!.

go_asserta([H|T]):-
	asserta(goal(H)),
	go_asserta(T).

% standard direction
move(CityA, CityB, Cost):-
	street(CityA, CityB, Cost).

% reversed direction
move(CityA, CityB, Cost):-
	street(CityB, CityA, Cost).

% Estimate rekent de verwachtte afstanden uit
estimate(CityA, EstimatedCost):-
	goal(CityB),
	prop(CityA, loc, LatA/LongA),
	prop(CityB, loc, LatB/LongB),
	EstimatedCost is sqrt((LatA-LatB)^2 + (LongA-LongB)^2) * 0.75. 


% Test-interface onderdeel:
% Showpath
% Showpath toont het pad dat gelopen is
showpath([]):-
	write('Dit is de uitgang\nVergeet u niet langs onze artis-shop te gaan?\ntot ziens\nP.S. typ ; voor een alternatieve route.\n'),!.

showpath([H|T]):-
	showtmp(H,1),
	write('---------------------------------------------------------------------------------------------\n'),
	showpath(T).

showtmp([],_):-
	write('uw volgende bestemming\n'),!.	

showtmp([H|T],1):-
	!,
	prop(H, name, Name),
        writef('U bent bij gebouw %w: %w, loopt u verder naar\n', [H,Name]),
	showtmp(T,2).

showtmp([H|T],X):-
	residents(H, List),	
	prop(H, name, Name),
	writef('Gebouw %w, \"%w\" \nBewoners:\n', [H,Name]),
	showresidents(List),
	write('Loopt u verder naar\n'),
	showtmp(T,X).

showresidents([]):-!.

showresidents([H|Tail]):-
	isa(H, Animal),
	hasprop(H, geboorte, Birth),
	hasprop(H, geslacht, Gend),
	writef('* %15l %20l is geboren op %15l en is een %w\n', [Animal, H, Birth, Gend]),
	showresidents(Tail).

residents(H, List):-
	findall(Animal, hasprop(Animal, verblijf, H), Residents),
	clearunspecific(Residents, [], List).

residents2(H, Animal):-
	hasprop(Animal, verblijf, H),
	prop(Animal, specific, _),!.


clearunspecific([], List, List):-!.

clearunspecific([H|Tail], Crt, List):-
	prop(H, specific, _),!,
	clearunspecific(Tail, [H|Crt], List).

clearunspecific([_H|Tail], Crt, List):-
	clearunspecific(Tail, Crt, List).

% Showpaths voor verschillende leeftijdsgroepen
showpath(List, User):-
	global_var(datum, _/_/Currentyear),
	prop(User, geboortejaar, Birth),
	Age is Currentyear-Birth,
	ageclassify(Age, Class),
	showpath(List, User, Class).

ageclassify(Age, 1):-
	Age < 12,!.
ageclassify(Age, 2):-
	Age < 25,!.
ageclassify(_, 3).


% Klasse 1, Kleine kinderen
% Simpele weergave, gezellige naampjes van dieren
% eventueel educatief?

showpath([],User, 1):-
	writef('onze artis shop, want daar zijn leuke knuffels te vinden\ntot snel, %w\n',[User]),!.

showpath([H|T],User, 1):-
	showtmp1(H,1),
	write('---------------------------------------------------------------------------------------------\n'),
	showpath(T, User, 1).

showtmp1([Last],_):-
	residents2(Last, Animal),	
	isa(Animal, Name),
	prop(Animal, geslacht, Gender),
	writef('Het verblijf van %w de %w \n%w is een %w\n', [Animal, Name,Animal, Gender]),
	write('Dat was leuk he? loop nu verder naar:\n'),!.	

showtmp1([H|T],1):-
	!,
	prop(H, name, Name),
        writef('Je bent nu bij het verblijf %w, ga verder naar\n', [Name]),
	showtmp1(T,2).

showtmp1([H|T],X):-
	residents2(H, Animal),	
	isa(Animal, Name),
	prop(Animal, geslacht, Gender),
	writef('Het verblijf van %w de %w \n%w is een %w\n', [Animal, Name,Animal, Gender]),
	write('Vanaf hier kan je naar het volgende dier\n'),
	showtmp1(T,X).


% Klasse 2, Tieners en Net-volwassenen
% Iets meer info, minder kinderlijk

showpath([],_, 2):-
	writef('Dit is de uitgang, ga nog even langs 1 van onze Experience-zuilen om je foto\'s te uploaden\n'),!.

showpath([H|T],User, 2):-
	showtmp2(H,1),
	write('---------------------------------------------------------------------------------------------\n'),
	showpath(T, User, 2).

showtmp2([Last],_):-
	prop(Animal, verblijf, Last),
	residents(Last, List),
	length(List, Number),
	writef('gebouw %w, ',[Last]),
	writef('het verblijf van de %w, wij hebben %w van deze dieren\n', [Animal, Number]),
	write('Vanaf hier kan je verder naar je volgende bestemming\n'),!.	

showtmp2([H|T],1):-
	!,
	writef('Je was bij gebouw %w\n',[H]),
        writef('ga vanaf hier verder naar\n'),
	showtmp2(T,2).

showtmp2([H|T],X):-
	prop(Animal, verblijf, H),
	residents(H, List),
	length(List, Number),
	writef('Gebouw %w, ',[H]),
	writef('het verblijf van de %w, hier zijn er %w van\n', [Animal, Number]),
	write('Vanaf hier kan je naar het volgende verblijf\n'),
	showtmp2(T,X).

% Klasse 3, Volwassenen
% Kale informatie, vooral functioneel
 
showpath([],_, 3):-
	writef('Dit is de uitgang, dank u wel voor uw bezoek en tot ziens\n'),!.

showpath([H|T],User, 3):-
	showtmp3(H,1),
	write('---------------------------------------------------------------------------------------------\n'),
	showpath(T, User, 3).

showtmp3([Last],_):-
	prop(Animal, verblijf, Last),
	writef('Gebouw %w, %w\.\n',[Last, Animal]),
	write('Vanaf hier kunt u verder naar de volgende bestemming\n'),!.	

showtmp3([H|T],1):-
	!,
	writef('U bent bij gebouw %w\n',[H]),
        writef('ga vanaf hier verder naar\n'),
	showtmp3(T,2).

showtmp3([H|T],X):-
	prop(Animal, verblijf, H),
	writef('Gebouw %w, %w\.\n',[H, Animal]),
	write('Vanaf hier kunt u verder naar\n'),
	showtmp3(T,X).
