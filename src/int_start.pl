/*******************************
 * Start interface for testers *
 * use: go/0 or start/0.       *
 * Author: Martijn vd Veen     *
 *******************************/



/******* menu struikstructuur *******
 * mainmenu	% done
 * +users	% done
 * ++new	% done
 * ++del	% done
 * ++view	% done
 * ++view(usr)	% done
 * +route	% done
 * ++route a>b	% done
 * ++route user	% done
 * +buildings	% done
 * ++build_list	% done
 * ++getinfo	% done
 * +animals	% done
 * ++getinfo	% done
 * ++compare	% -
 * ++move	% -
 * +proc	% done
 * ++schoonmaken% done
 * ++voeren	% done
 * +game	% done
 * +exit	% done
 **************************************/





:-	write(' ---- type start om te beginnen ----').



go :- menu.
start :- menu.
fast :- menu(main). % skip intro text


% welcome
menu :-
	write('======================================================\n'),
	write('>> Administrator Testinterface v0.9.7a Home Edition <<\n'),
	write('======================================================\n'), sleep(0.5),
	write('Welkom in Artis!\n'), sleep(0.5),
	write('Alle commando\'s kunnen overal gebruikt worden,\n'), sleep(0.1),
	write('de menu\'s zijn enkel ter verduidelijking\n'), sleep(0.1),
	write('van de structuur (en voor de fun).\n\n'), sleep(0.5),
	write('De opties die om een naam vragen worden aangepast\n'), sleep(0.1),
	write('aan het profiel van de bezoeker. Probeer dus af en\n'), sleep(0.1),
	write('toe eens een andere persoonlijkheid uit\n'), sleep(0.1),
	write('(volgens ons sowieso goed om af en toe te doen).\n\n'), sleep(0.5),
	write('Merk op dat dit slechts een testinterface is,\n'), sleep(0.1),
	write('die gebruik maakt van de beschikbare informatie.\n'), sleep(0.1),
	write('Het is geen implementatie van de ontworpen interface\n'), sleep(0.1),
	write('die Artis-bezoekers te zien zouden krijgen\n'), sleep(0.1),
	write('(daar hebben we natuurlijk helemaal geen tijd voor).\n\n'), sleep(0.5),
	write('Rest ons enkel nog jullie veel plezier te wensen\n'), sleep(0.1),
	write('bij het bekijken van onze creatie -\n'), sleep(0.1),
	write('dat hadden wij ook bij het maken ervan. \n\n'), sleep(0.5),
	write('Martijn, Robrecht, Moos en Eva\n\n'), sleep(0.5),
	menu(main).


menu(help) :-	menu(main).
menu(back) :-	menu(main).

% 1
menu(main) :-
	write('\n 1 HOOFDMENU\n'), sleep(0.5),
	write('Kies een van de volgende opties:\n'), sleep(0.1),
	write('> users. - gebruikersbeheer\n'), sleep(0.1),
	write('> route. - plan een route\n'), sleep(0.1),
	write('> buildings. - info over gebouwen\n'), sleep(0.1),
	write('> animals. - info over dieren\n'), sleep(0.1),
	write('> proc. - procedures\n'), sleep(0.1),
	write('> game. - artis the game\n'), sleep(0.1),
	write('> help. - ga terug naar dit menu\n'), sleep(0.1),
	write('> exit. - verlaat de testinterface\n'), sleep(0.1),

	read(X),
	menu(X).

% 1-1
menu(users) :-
	write('\n 1-1 USERS\n'), sleep(0.5),
	write('Kies een van de volgende opties:\n'), sleep(0.1),
	write('> new. - maak nieuwe bezoeker aan\n'), sleep(0.1),
	write('> del. - wis bestaande bezoeker\n'), sleep(0.1),
	write('> view. - lijst van bestaande bezoekers\n'), sleep(0.1),
	write('> view(Name). - bekijk bezoeker met naam Name\n'), sleep(0.1),
	write('> back. - terug naar main-menu\n'), sleep(0.1),
	read(X),
	menu(X).


% 1-2
menu(route) :-
	write('\n 1-2 ROUTE\n'), sleep(0.5),
	write('Kies een van de volgende opties:\n'), sleep(0.1),
	write('> route_ab. - plan route van A naar B\n'), sleep(0.1),
	write('> route_profile. - plan route gebaseerd op userprofile\n'), sleep(0.1),
	write('> back. - terug naar main-menu\n'), sleep(0.1),
	read(X),
	menu(X).


% 1-3
menu(buildings) :-
	write('\n 1-3 BUILDINGS\n'), sleep(0.5),
	write('Kies een van de volgende opties:\n'), sleep(0.1),
	write('> building_list - lijst van mogelijke gebouwen\n'), sleep(0.1),
	write('> building_info - info over een bepaald gebouw\n'), sleep(0.1),
	write('> proc - jump naar procedures (o.a. voor gebouwen)\n'), sleep(0.1),
	write('> back - terug naar main-menu\n'), sleep(0.1),
	read(X),
	menu(X).



menu(animals) :-
	write('\n 1-4 ANIMALS\n'),
	geefinfo,
	menu(main).
	
menu(proc) :-
	write('\n 1-5 PROCEDURES\n'),
	write('N.B.: Ondanks pogingen tot het inbouwen van error handling verdient het aanbeveling geen typfouten te maken op het moment dat gevraagd wordt twee dieren in te voeren. Ook \'stop.\' en \'help.\' lijken in eerste instantie goed te werken, maar leveren later problemen op. In de interface die slechts met een dier werkt zijn de makers dit probleem nog niet tegengekomen.\nDe makers bieden hun welgemeende excuses aan voor dit ongemak.\n\n'),	
	write('Je kunt op elk moment terug naar het hoofdmenu met het commando \'stop.\'.\n'),
	write('Typ \'help.\' voor een lijst met beschikbare dieren.\n\n'),	
	sleep(0.5),
	go_proc_profile,
	menu(main).
	
menu(game) :-
	write('\n 1-6 ARTIS THE GAME\n'), sleep(0.5),
	write('LET OP: Artis the game is nog in een alpha-stadium,\n'),
	write('en werkt niet altijd correct. Toch leuk om te proberen!\n\n'),
	artisgame,
	menu(main).


menu(exit) :-
	!,
	write('==================================\n'),
	write('       EINDE TESTINTERFACE        \n'),
	write('==================================\n').







% 1-1-1
menu(new) :-
	write('\n 1-1-1 NEW USER\n'), sleep(0.5),
	write('Vul deze vragen in voor de nieuwe bezoeker:\n'), sleep(0.5),
	startuser(_, _),
	write('Bezoeker aangemaakt!\n'), sleep(0.5),
	menu(users).	%backto 1-1

% 1-1-2
menu(del) :-
	write('\n 1-1-2 DEL USER\n'), sleep(0.5),
	write('Type de username die verwijderd moet worden:\n'), sleep(0.5),
	read(X),
	menu_del(X).
menu_del(X) :-
	isa(X, bezoeker),
	!,
	user_del(X),
	menu(users).	%backto 1-1
menu_del(_) :-
	write('User bestaat niet!\n'),
	menu(del).



% 1-1-3
menu(view) :-
	write('\n 1-1-3 VIEW USER LIST\n'), sleep(0.5),
	findall(Usr, isa(Usr, bezoeker), Usrs),
	show_list(Usrs),
	write('\n'), sleep(0.5),
	menu(users).	%backto 1-1

% 1-1-4
menu(view(Usr)) :-
	write('\n 1-1-4 VIEW USER\n'), sleep(0.5),
	writef('Bezoeker: %w\n', [Usr]), sleep(0.5),
	menu_view(Usr),
	menu(users).	%backto 1-1
menu_view(Usr) :-
	isa(Usr, bezoeker),
	!,
	findall(Prop/Value, prop(Usr, Prop, Value), List),
	printinfo(List, tabel),
	menu(users).	%backto 1-1
menu_view(_) :-
	write('Die naam is ons niet bekend.\n'),
	menu(users).	%backto 1-1






% 1-2-1
menu(route_ab) :-
	write('\n 1-2-1 ROUTE A -> B\n'), sleep(0.5),
	routestartnormal,
	menu(route).	%backto 1-2




% 1-2-2
menu(route_profile) :-
	write('\n 1-2-2 ROUTE PERSONAL PROFILE\n'), sleep(0.5),
	write('Hoe heet je?\n'), sleep(0.1),
	read(Usr),
	write('Bij welk nummer gebouw (1-32) ben je nu?:\n'), sleep(0.1),
	read(Start),
	routestart(Start, Usr),
	menu(route).	%backto 1-2




% 1-3-1
menu(building_list) :-
	write('\n 1-3-1 BUILDING LIST\n'), sleep(0.5),
	write('Gebouwen in Artis:\n'), sleep(0.1),
        findall(X, isfam(X, gebouw), List),
        showbuildinglist(List),nl,
	menu(buildings).

% 1-3-2
menu(building_info) :-
	write('\n 1-3-2 BUILDING INFO\n'), sleep(0.5),
	write('Welk gebouw wil je informatie over?\n'), sleep(0.1),
	read(X),
	menu(building_info(X)).
menu(building_info(X)) :-
	number(X),
	!,
	specifybuild(X),
	menu(buildings). %backto 1-3
menu(building_info(_)) :-
	write('Typ een gebouwnummer.\n'),
	menu(building_info).











