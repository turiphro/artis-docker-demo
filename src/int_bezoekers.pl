% Interfaces voor bezoekers
% Versie 1.0
% Martijn vd Veen


% gebruik startuser om van de huidige
% gebruiker zijn naam en eigenschappen
% te krijgen. De gebruiker moet zijn naam
% opgeven en de eigenschappen worden geladen.
% Bestaat de gebruiker nog niet, dan worden
% vragen gesteld om de gebruiker aan te maken.



startuser(Naam, Props) :-
	write('Wat is je naam?\n'),
	read(Naam_draft),
	startuser_step1(Naam, Props, Naam_draft).

startuser_step1(Naam, Props, Naam_draft) :-
	isa(Naam_draft, bezoeker),		% user bestaat: props opvragen
	!,
	Naam = Naam_draft,
	user_getprops(Naam_draft, Props).

startuser_step1(Naam, Props, Naam_draft) :-
	item_exists(Naam_draft, 1),			% user bestaat niet, naam wel (= dier)
	isa(Naam_draft, Diernaam),
	!,
	writef('Sorry, we hebben al een %w die %w heet.\n', [Diernaam, Naam_draft]),
	write('Kan je een andere tijdelijke naam verzinnen?\n'),
	read(Naam_draft1),
	startuser_step1(Naam, Props, Naam_draft1).

startuser_step1(Naam, Props, Naam) :-
	writef('Welkom in Artis, %w\n', [Naam]),	% user bestaat niet, dus aanmaken
	write('Om je een perfect verblijf in artis te garanderen,\n'),
	write('willen we graag een aantal dingen van je weten.\n'),
	write('De rest van je dag hoef je enkel nog je naam te vertellen.\n\n'),
	startuser_quest2(Naam, Props).

%40
startuser_quest2(Naam, Props) :-
	write('In welk jaar ben je geboren?\n'),
	read(Arg),
	startuser_check2(Naam, Props, [], Arg).

startuser_check2(Naam, Props, Props_draft, Arg) :-
	number(Arg),
	global_var(datum_jaar, Jaar),
	Arg > 1800,			% neem t ruim
	Arg =< Jaar,
	!,
	startuser_quest3(Naam, Props, [geboortejaar/Arg|Props_draft]).
startuser_check2(Naam, Props, _, _) :-
	write('Dat is geen jaartal, of onwaarschijnlijk.\n'),
	startuser_quest2(Naam, Props).

startuser_quest3(Naam, Props, Props_draft) :-
	write('Hoe hoog is je IQ?\n'),
	read(Arg),
	startuser_check3(Naam, Props, Props_draft, Arg).

startuser_check3(Naam, Props, Props_draft, Arg) :-
        number(Arg),
        Arg < 90,
	!,
        startuser_quest4(Naam, Props, [niveau/dom|Props_draft]).
startuser_check3(Naam, Props, Props_draft, Arg) :-
        number(Arg),
        Arg >= 90,                                    %70
	Arg < 125,
        !,
        startuser_quest4(Naam, Props, [niveau/normaal|Props_draft]).
startuser_check3(Naam, Props, Props_draft, Arg) :-
        number(Arg),
        Arg >= 125,
        !,
        startuser_quest4(Naam, Props, [niveau/ontwikkeld|Props_draft]).
startuser_check3(Naam, Props, Props_draft, _):-
	write('Vul alsjeblieft een nummer in.\n'),
        startuser_quest3(Naam, Props, Props_draft).  


startuser_quest4(Naam, Props, Props_draft) :-
        write('Lees je liever een boek, of liever de samenvatting?\n'),
        read(Arg),
        startuser_check4(Naam, Props, Props_draft, Arg).

startuser_check4(Naam, Props, Props_draft, boek) :-
	!,
        startuser_quest5(Naam, Props, [opmaak/verhaal|Props_draft]).
startuser_check4(Naam, Props, Props_draft, samenvatting) :-
        !,
	startuser_quest5(Naam, Props, [opmaak/tabel|Props_draft]).  
startuser_check4(Naam, Props, Props_draft, _) :-
	write('kies voor \'boek\' of \'samenvatting\'.\n'),
        startuser_quest4(Naam, Props, Props_draft).


startuser_quest5(Naam, Props, Props_draft) :-
        write('Wat is je lievelingskleur?\n'),
        read(Arg),
        startuser_check5(Naam, Props, Props_draft, Arg).


startuser_check5(Naam, Props, Props_draft, Arg) :-
        prop(_, kleur, Arg),
	!,
        startuser_quest6(Naam, Props, [lievelingskleur/Arg|Props_draft]).
startuser_check5(Naam, Props, Props_draft, _) :-
        write('Noem nog eens een mooie kleur?\n'),
	read(Arg),
        startuser_check5(Naam, Props, Props_draft, Arg).




startuser_quest6(Naam, Props, Props_draft) :-
	write('\nTijd voor de dieren!\n'),
	write('Kies steeds 1. of 2.\n'),
        write('1. Roofdier, 2. Lieve dieren\n'),
        read(Arg),
        startuser_check6(Naam, Props, Props_draft, Arg).

startuser_check6(Naam, Props, Props_draft, 1) :-
	!,
        startuser_quest7(Naam, Props, [[knuffact/gevaarlijk]|Props_draft]).
startuser_check6(Naam, Props, Props_draft, 2) :-
	!,
        startuser_quest7(Naam, Props, [[knuffact/knuffelbaar]|Props_draft]).
startuser_check6(Naam, Props, Props_draft, _) :-
        write('Typ 1 of 2, gevolgd door een punt\n'),
	read(Arg),
        startuser_check6(Naam, Props, Props_draft, Arg).



startuser_quest7(Naam, Props, Props_draft) :-
        write('1. Grote dieren, 2. Kleine dieren\n'),
        read(Arg),
        startuser_check7(Naam, Props, Props_draft, Arg).

startuser_check7(Naam, Props, [Head | Props_draft], 1) :-
	!,
        startuser_quest8(Naam, Props, [[grootte_orde/groot, grootte_orde/huge | Head] | Props_draft]).
startuser_check7(Naam, Props, [Head | Props_draft], 2) :-
	!,
        startuser_quest8(Naam, Props, [[grootte_orde/tiny, grootte_orde/klein, grootte_orde/medium | Head] | Props_draft]).
startuser_check7(Naam, Props, Props_draft, _) :-
        write('Typ 1 of 2, gevolgd door een punt\n'),
	read(Arg),
        startuser_check7(Naam, Props, Props_draft, Arg).



startuser_quest8(Naam, Props, Props_draft) :-
        write('1. Dieren op het land, 2. Dieren in het water\n'),
        read(Arg),
        startuser_check8(Naam, Props, Props_draft, Arg).

startuser_check8(Naam, Props, [Head | Props_draft], 1) :-
	!,
        startuser_quest9(Naam, Props, [diereigenschappen/[nodig/land | Head] | Props_draft]).
startuser_check8(Naam, Props, [Head | Props_draft], 2) :-
	!,
        startuser_quest9(Naam, Props, [diereigenschappen/[nodig/water | Head] | Props_draft]).
startuser_check8(Naam, Props, Props_draft, _) :-
        write('Typ 1 of 2, gevolgd door een punt\n'),
	read(Arg),
        startuser_check8(Naam, Props, Props_draft, Arg).


startuser_quest9(Naam, Prop, Prop) :-
	writef('Dat waren de vragen, %w!\n\n', [Naam]),
	user_add(Naam, Prop).



