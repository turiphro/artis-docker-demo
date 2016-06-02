/***********************************
Universiteit van Amsterdam
Bachelor Kunstmatige Intelligentie
jaar 1, blok 3: Communicatieve Interactie
Artis project
Groep 1

Auteur: Robrecht Jurriaans

De database met structurele kennis over de dierentuin

gebruik gemaakt van boomstructuur en overerving

isa/2 voor subtypes
prop/3 om properties toe te kennen

***********************************/

loc(X, Y):-
	prop(X, loc, Y).

naam(X, Y):-
	prop(X, name, Y).

listprops(X, Y):-
	findall(Z, prop(X, _, Z), Y).

distance(X, Y, Dist):-
	prop(X, loc, X1/Y1),!,
	prop(Y, loc, X2/Y2),!,
	Dist is sqrt(((X1-X2)**2)+((Y1-Y2)**2)).

isa(voliere, gebouw).
isa(terrarium, gebouw).
isa(vijver, gebouw).
isa(aquarium, gebouw).
isa(kooi, gebouw).

isa(1, voliere).
isa(2, vijver).
isa(3, kooi).
isa(4, kooi).
isa(5, kooi).
isa(6, kooi).
isa(7, kooi).
isa(8, kooi).
isa(9, kooi).
isa(10, kooi).
isa(11, kooi).
isa(12, kooi).
isa(13, kooi).
isa(14, kooi).
isa(15, kooi).
isa(16, kooi).
isa(17, kooi).
isa(18, kooi).
isa(19, vijver).
isa(20, kooi).
isa(21, kooi).
isa(22, kooi).
isa(23, kooi).
isa(24, kooi).
isa(25, kooi).
isa(26, kooi).
isa(27, vijver).
isa(28, vijver).
isa(29, terrarium).
isa(30, kooi).
isa(31, kooi).
isa(32, aquarium).

% Algemene feiten
prop(aquarium, materiaal, water).
prop(aquarium, afsluiting, glas).

prop(kooi, materiaal, land).

prop(terrarium, materiaal, land).
prop(terrarium, materiaal, water).
prop(terrarium, afsluiting, glas).

prop(voliere, afsluiting, gaas).

prop(vijver, materiaal, water).
prop(vijver, attribute, buiten).

% Specifieke kennis
prop(1, grootte_orde, medium).
prop(1, materiaal, land).
prop(1, attribute, buiten).
prop(1, loc, 160/140).   % Bertegraad keer hoogtegraad
prop(1, name, 'Birdhouse').

prop(2, grootte_orde, medium).
prop(2, afsluiting, hek).
prop(2, materiaal, land).
prop(2, loc, 275/100).
prop(2, name, 'Flamingo').

prop(3, grootte_orde, groot).
prop(3, afsluiting, hek).
prop(3, attribute, buiten).
prop(3, loc, 380/105).
prop(3, name, 'Zebra').

prop(4, grootte_orde, medium).
prop(4, afsluiting, tralies).
prop(4, materiaal, water).
prop(4, attribute, buiten).
prop(4, loc, 260/200).
prop(4, name, 'Gibbons').

prop(5, grootte_orde, groot).
prop(5, afsluiting, hek).
prop(5, materiaal, water).
prop(5, attribute, buiten).
prop(5, loc, 335/225).
prop(5, name, 'Ibex').

prop(6, grootte_orde, klein).
prop(6, afsluiting, glas).
prop(6, materiaal, water).
prop(6, attribute, binnen).
prop(6, loc, 445/230).
prop(6, name, 'Kleine zoogdieren').

prop(7, grootte_orde, medium).
prop(7, afsluiting, hek).
prop(7, attribute, buiten).
prop(7, loc, 450/175).
prop(7, name, 'Kangoeroes').

prop(8, grootte_orde, groot).
prop(8, afsluiting, hek).
prop(8, attribute, buiten).
prop(8, loc, 480/125).
prop(8, name, 'Antilopen').

prop(9, grootte_orde, klein).
prop(9, afsluiting, hek).
prop(9, attribute, buiten).
prop(9, loc, 650/130).
prop(9, name, 'Fazanten').

prop(10, grootte_orde, klein).
prop(10, afsluiting, hek).
prop(10, materiaal, water).
prop(10, attribute, buiten).
prop(10, loc, 650/175).
prop(10, name, 'Ibis').

prop(11, grootte_orde, medium).
prop(11, attribute, nachthok).
prop(11, afsluiting, hek).
prop(11, attribute, buiten).
prop(11, loc, 735/200).
prop(11, name, 'Wolven').

prop(12, grootte_orde, medium).
prop(12, afsluiting, muur).
prop(12, attribute, buiten).
prop(12, loc, 795/195).
prop(12, name, 'Chimpansees').

prop(13, grootte_orde, medium).
prop(13, afsluiting, muur).
prop(13, materiaal, water).
prop(13, attribute, buiten).
prop(13, loc, 840/135).
prop(13, name, 'Penguins').

prop(14, grootte_orde, groot).
prop(14, afsluiting, hek).
prop(14, attribute, buiten).
prop(14, loc, 865/190).
prop(14, name, 'Guanacos').

prop(15, grootte_orde, groot).
prop(15, attribute, nachthok).
prop(15, afsluiting, hek).
prop(15, attribute, buiten).
prop(15, loc, 955/255).
prop(15, name, 'Bruine beren').

prop(16, grootte_orde, groot).
prop(16, attribute, nachthok).
prop(16, afsluiting, tralies).
prop(16, materiaal, water).
prop(16, attribute, buiten).
prop(16, loc, 870/280).
prop(16, name, 'Gorilla\'s').

prop(17, grootte_orde, medium).
prop(17, afsluiting, hek).
prop(17, attribute, buiten).
prop(17, loc, 910/300).
prop(17, name, 'Tapirs').

prop(18, grootte_orde, huge).
prop(18, attribute, nachthok).
prop(18, afsluiting, glas).
prop(18, materiaal, water).
prop(18, attribute, buiten).
prop(18, attribute, binnen).
prop(18, loc, 870/320).
prop(18, name, 'Nijlpaarden').

prop(19, grootte_orde, medium).
prop(19, afsluiting, hek).
prop(19, materiaal, land).
prop(19, loc, 920/345).
prop(19, name, 'Kraanvogel').

prop(20, grootte_orde, groot).
prop(20, afsluiting, hek).
prop(20, attribute, buiten).
prop(20, loc, 810/325).
prop(20, name, 'Bizon').

prop(20, grootte_orde, medium).
prop(21, afsluiting, hek).
prop(21, materiaal, water).
prop(21, attribute, buiten).
prop(21, loc, 680/270).
prop(21, name, 'Chamois').

prop(22, grootte_orde, huge).
prop(22, afsluiting, hek).
prop(22, attribute, buiten).
prop(22, loc, 665/345).
prop(22, name, 'Giraffes').

prop(23, grootte_orde, huge).
prop(23, afsluiting, hek).
prop(23, attribute, buiten).
prop(23, loc, 580/320).
prop(23, name, 'Olifanten').

prop(24, grootte_orde, medium).
prop(24, afsluiting, tralies).
prop(24, attribute, buiten).
prop(24, loc, 550/250).
prop(24, name, 'Wolven en Hyenas').

prop(25, grootte_orde, medium).
prop(25, afsluiting, tralies).
prop(25, attribute, buiten).
prop(25, loc, 450/350).
prop(25, name, 'Tijgers en Panters').

prop(26, grootte_orde, groot).
prop(26, afsluiting, muur).
prop(26, materiaal, water).
prop(26, attribute, buiten).
prop(26, attribute, nachthok).
prop(26, loc, 345/350).
prop(26, name, 'Leeuwen').

prop(27, grootte_orde, groot).
prop(27, afsluiting, hek).
prop(27, materiaal, land).
prop(27, loc, 350/275).
prop(27, name, 'Flamingo\'s en eenden').

prop(28, grootte_orde, medium).
prop(28, afsluiting, hek).
prop(28, loc, 250/300).
prop(28, name, 'Pelikanen').

prop(29, grootte_orde, groot).
prop(29, attribute, binnen).
prop(29, attribute, nachthok).
prop(29, loc, 280/350).
prop(29, name, 'Reptielenhuis').

prop(30, grootte_orde, groot).
prop(30, afsluiting, hek).
prop(30, attribute, buiten).
prop(30, loc, 125/250).
prop(30, name, 'Kamelen').

prop(31, grootte_orde, medium).
prop(31, afsluiting, muur).
prop(31, materiaal, water).
prop(31, attribute, buiten).
prop(31, loc, 180/235).
prop(31, name, 'Monkey rock').

prop(32, grootte_orde, huge).
prop(32, attribute, binnen).
prop(32, loc, 815/75).
prop(32, name, 'Aquarium').
