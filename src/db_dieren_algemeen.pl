% Comunicatieve Interactie
% Database - Dieren
% versie 0.2
%
% Martijn: alle dieren met (wikipedia)eigenschappen toegevoegd
% Moos: Eigenschappen van klasses en subklasses toegevoegd.


/*
	Opmerkingen:
	
	* alle lagen zijn in enkelvoud (de namen)

	* Eigenschappen van de dieren:
		(hebben een interne naam, duidelijker dan nummer)
		- naam (voluit)
		- latijn (latijnse naam)
		- verblijf (nummer)
		- kleur
		- gewicht (kg) <- echt opgezocht!! respect voor wikipedia
		- grootte (cm, lengte oid) <- idem, maar geen respect voor apple
		  NB: hulppredicaatje grootte_orde geeft orde van grootte in woorden (tiny, klein, medium, groot, huge)
		- eten (omnivoor, carnivoor, herbivoor)
		- voortbewegen (vliegen, zwemmen, lopen, rennen, klimmen)
		- knuffelheidsfactor (gevaarlijk, neutraal, knuffelbaar, schattig)

	* NIeT GeiMPLeMEnTeERD, wel leuk:
		
		- hokgrootte (m^2) (nodig voor verblijf per dier) -> uitrekenen hoeveel dieren per hok
		- snelheid?
		- gemiddelde leeftijd?
	

	* Voorbeeld queries:
		- lijst met alle dieren:
		findall(C, (isa(A, dier), isa(B, A), isa(C, B)), Dieren), write(Dieren).
		- vind dieren zonder een bepaalde eigenschap (zet binnen not()):
		findall(C, (isa(A, dier), isa(B, A), isa(C, B), not(prop(C, naam, _))), Dieren), write(Dieren).
		findall(C, (isa(A, dier), isa(B, A), isa(C, B), not(prop(C, voortbewegen, lopen))), Dieren), write(Dieren).




*/



:-	dynamic(isa/2).
:-	dynamic(prop/3).





/************ layer 1: dier  *****************************/



/************ layer 2: klassen van dieren ************/
isa(zoogdier, dier).
isa(reptiel, dier).
isa(vogelachtig, dier).
isa(visachtig, dier).


/*********** layer 3: subklassen van klassen *********/
% zoogdieren
isa(roofdier, zoogdier).
isa(slurfdier, zoogdier).
isa(onevenhoevige, zoogdier).
isa(evenhoevige, zoogdier).
isa(knaagdier, zoogdier).
isa(primaat, zoogdier).
isa(buideldier, zoogdier).

% vogels
isa(roofvogel, vogelachtig).
isa(kraanvogelachtig, vogelachtig).
isa(ooievaarachtig, vogelachtig).
isa(hoender, vogelachtig).
isa(watervogel, vogelachtig).
isa(pinguinachtig, vogelachtig).

% reptielen
isa(krokodilachtig, reptiel).

% vissen
isa(haaiachtig, visachtig). % is eigenlijk geen subgroep, maar om diepte van boom te behouden deze 'hack'


/*********** layer 4: dieren *************************/

%% STRUCTUURBOOM

isa(leeuw, roofdier).
isa(wasbeer, roofdier).
isa(wolf, roofdier).
isa(olifant, slurfdier).
isa(zebra, onevenhoevige).
isa(tapir, onevenhoevige).
isa(nijlpaard, evenhoevige).
isa(kameel, evenhoevige).
isa(lama, evenhoevige).
isa(giraffe, evenhoevige).
isa(springbok, evenhoevige).
isa(bok, evenhoevige).
isa(bever, knaagdier).
isa(gibbon, primaat).
isa(gorilla, primaat).
isa(chimpansee, primaat).
isa(bredeweg, primaat).
isa(valk, roofvogel).
isa(kraanvogel, kraanvogelachtig).
isa(flamingo, ooievaarachtig).
isa(ibis, ooievaarachtig).
isa(kangoeroe, buideldier).
isa(antilope, evenhoevige).
isa(pinguin, pinguinachtig).
isa(bizon, evenhoevige).
isa(hyena, roofdier).
isa(tijger, roofdier).
isa(baviaan, primaat).
isa(fazant, hoender).
isa(eend, watervogel).
isa(pelikaan, watervogel).
isa(krokodil, krokodilachtig).
isa(haai, haaiachtig).



%% EIGENSCHAPPEN
%
/*********** layer 2: klasse ****************************/
 prop(zoogdier, nodig, land).
 prop(visachtig, nodig, water).
 prop(vogelachtig, voortbewegen, vliegen).
/*********** layer 3: subklasse *************************/
 prop(watervogel, nodig, water).
 noprop(pinguinachtig, voortbewegen, vliegen).
/*********** layer 4: dieren ****************************/
 prop(leeuw, naam, 'Leeuw').
 prop(leeuw, latijn, 'Panthera leo').
 prop(leeuw, verblijf, 26).
 prop(leeuw, kleur, lichtbruin).
 prop(leeuw, gewicht, 160).
 prop(leeuw, grootte, 210).
 prop(leeuw, eten, carnivoor).
 prop(leeuw, voortbewegen, lopen).
 prop(leeuw, voortbewegen, rennen).
 prop(leeuw, knuffelheidsfactor, gevaarlijk).


 prop(wasbeer, naam, 'Wasbeer').
 prop(wasbeer, latijn, 'Procyon lotor').
 prop(wasbeer, verblijf, 15).
 prop(wasbeer, kleur, lichtbruin).
 prop(wasbeer, gewicht, 12).
 prop(wasbeer, grootte, 80).
 prop(wasbeer, eten, carnivoor).
 prop(wasbeer, voortbewegen, lopen).
 prop(wasbeer, voortbewegen, klimmen).
 prop(wasbeer, knuffelheidsfactor, knuffelbaar).



 prop(wolf, naam, 'Alaska-wolf').
 prop(wolf, latijn, 'Canis lupus arctos').
 prop(wolf, verblijf, 11).
 prop(wolf, kleur, wit).
 prop(wolf, gewicht, 50).
 prop(wolf, grootte, 120).
 prop(wolf, eten, carnivoor).
 prop(wolf, voortbewegen, lopen).
 prop(wolf, voortbewegen, rennen).
 prop(wolf, knuffelheidsfactor, gevaarlijk).



 prop(olifant, naam, 'Indische olifant').
 prop(olifant, latijn, 'Canis lupus arctos').
 prop(olifant, verblijf, 23).
 prop(olifant, kleur, grijs).
 prop(olifant, gewicht, 5000).
 prop(olifant, grootte, 500).
 prop(olifant, eten, herbivoor).
 prop(olifant, voortbewegen, lopen).
 prop(olifant, knuffelheidsfactor, neutraal).



 prop(zebra, naam, 'Grevyzebra').
 prop(zebra, latijn, 'Equus grevyi').
 prop(zebra, verblijf, 3).
 prop(zebra, kleur, zwart).
 prop(zebra, kleur, wit).
 prop(zebra, gewicht, 400).
 prop(zebra, grootte, 275).
 prop(zebra, eten, herbivoor).
 prop(zebra, voortbewegen, lopen).
 prop(zebra, voortbewegen, rennen).
 prop(zebra, knuffelheidsfactor, neutraal).



 prop(tapir, naam, 'Indische tapir').
 prop(tapir, latijn, 'Tapirus indicus').
 prop(tapir, verblijf, 17).
 prop(tapir, kleur, zwart).
 prop(tapir, gewicht, 280).
 prop(tapir, grootte, 200).
 prop(tapir, eten, herbivoor).
 prop(tapir, voortbewegen, lopen).
 prop(tapir, knuffelheidsfactor, neutraal).



 prop(nijlpaard, naam, 'Nijlpaard').
 prop(nijlpaard, latijn, 'Hippopotamus amphibius').
 prop(nijlpaard, verblijf, 18).
 prop(nijlpaard, kleur, grijs).
 prop(nijlpaard, gewicht, 2000).
 prop(nijlpaard, grootte, 310).
 prop(nijlpaard, eten, omnivoor).
 prop(nijlpaard, voortbewegen, lopen).
 prop(nijlpaard, voortbewegen, zwemmen).
 prop(nijlpaard, knuffelheidsfactor, gevaarlijk).



 prop(kameel, naam, 'Huiskameel').
 prop(kameel, latijn, 'Camelus ferus').
 prop(kameel, verblijf, 30).
 prop(kameel, kleur, bruin).
 prop(kameel, gewicht, 600).
 prop(kameel, grootte, 200).
 prop(kameel, eten, herbivoor).
 prop(kameel, voortbewegen, lopen).
 prop(kameel, knuffelheidsfactor, neutraal).



 prop(lama, naam, 'Lama').
 prop(lama, latijn, 'Lama glama').
 prop(lama, verblijf, 14).
 prop(lama, kleur, bruin).
 prop(lama, gewicht, 140).
 prop(lama, grootte, 170).
 prop(lama, eten, herbivoor).
 prop(lama, voortbewegen, lopen).
 prop(lama, voortbewegen, rennen).
 prop(lama, knuffelheidsfactor, neutraal).



 prop(giraffe, naam, 'Netgiraffe').
 prop(giraffe, latijn, 'Giraffa camelopardalis reticulata').
 prop(giraffe, verblijf, 22).
 prop(giraffe, kleur, bruin).
 prop(giraffe, kleur, lichtbruin).
 prop(giraffe, kleur, wit).
 prop(giraffe, gewicht, 1700).
 prop(giraffe, grootte, 500).
 prop(giraffe, eten, herbivoor).
 prop(giraffe, voortbewegen, lopen).
 prop(giraffe, knuffelheidsfactor, neutraal).



 prop(springbok, naam, 'Springbok').
 prop(springbok, latijn, 'Antidorcas marsupialis').
 prop(springbok, verblijf, 21).
 prop(springbok, kleur, bruin).
 prop(springbok, kleur, wit).
 prop(springbok, gewicht, 40).
 prop(springbok, grootte, 75).
 prop(springbok, eten, herbivoor).
 prop(springbok, voortbewegen, lopen).
 prop(springbok, voortbewegen, rennen).
 prop(springbok, knuffelheidsfactor, gevaarlijk).



 prop(bok, naam, 'Alpensteenbok').
 prop(bok, latijn, 'Capra ibex ibex').
 prop(bok, verblijf, 5).
 prop(bok, kleur, bruin).
 prop(bok, gewicht, 95).
 prop(bok, grootte, 140).
 prop(bok, eten, herbivoor).
 prop(bok, voortbewegen, lopen).
 prop(bok, voortbewegen, rennen).
 prop(bok, knuffelheidsfactor, gevaarlijk).



 prop(bever, naam, 'Canadese bever').
 prop(bever, latijn, 'Castor canadensis').
 prop(bever, verblijf, 6).
 prop(bever, kleur, bruin).
 prop(bever, gewicht, 23).
 prop(bever, grootte, 70).
 prop(bever, eten, omnivoor).
 prop(bever, voortbewegen, zwemmen).
 prop(bever, voortbewegen, lopen).
 prop(bever, knuffelheidsfactor, knuffelbaar).
 prop(bever, nodig, water).



 prop(gibbon, naam, 'Witwanggibbon').
 prop(gibbon, latijn, 'Hylobates leucogenys').
 prop(gibbon, verblijf, 4).
 prop(gibbon, kleur, lichtbruin).
 prop(gibbon, kleur, zwart).
 prop(gibbon, gewicht, 35).
 prop(gibbon, grootte, 120).
 prop(gibbon, eten, omnivoor).
 prop(gibbon, voortbewegen, lopen).
 prop(gibbon, voortbewegen, klimmen).
 prop(gibbon, knuffelheidsfactor, knuffelbaar).



 prop(gorilla, naam, 'Westelijke laaglandgorilla').
 prop(gorilla, latijn, 'gorilla gorilla gorilla').
 prop(gorilla, verblijf, 16).
 prop(gorilla, kleur, zwart).
 prop(gorilla, gewicht, 80).
 prop(gorilla, grootte, 155).
 prop(gorilla, eten, omnivoor).
 prop(gorilla, voortbewegen, lopen).
 prop(gorilla, voortbewegen, klimmen).
 prop(gorilla, knuffelheidsfactor, neutraal).



 prop(chimpansee, naam, 'Chimpansee').
 prop(chimpansee, latijn, 'Pan troglodytes').
 prop(chimpansee, verblijf, 12).
 prop(chimpansee, kleur, donkerbruin).
 prop(chimpansee, gewicht, 50).
 prop(chimpansee, grootte, 150).
 prop(chimpansee, eten, omnivoor).
 prop(chimpansee, voortbewegen, lopen).
 prop(chimpansee, voortbewegen, klimmen).
 prop(chimpansee, knuffelheidsfactor, neutraal).



 prop(bredeweg, naam, 'Japanse slingerbredeweg').
 prop(bredeweg, latijn, 'Optas cmaptos').
 prop(bredeweg, verblijf, 12).
 prop(bredeweg, kleur, blank).
 prop(bredeweg, gewicht, 85).
 prop(bredeweg, grootte, 180).
 prop(bredeweg, eten, omnivoor).
 prop(bredeweg, voortbewegen, lopen).
 prop(bredeweg, voortbewegen, zwemmen).
 prop(bredeweg, knuffelheidsfactor, gevaarlijk).



 prop(valk, naam, 'Torenvalk').
 prop(valk, latijn, 'Falco tinnunculus').
 prop(valk, verblijf, 1).
 prop(valk, kleur, rood).
 prop(valk, kleur, bruin).
 prop(valk, kleur, grijs).
 prop(valk, gewicht, 0.5).
 prop(valk, grootte, 30).
 prop(valk, eten, carnivoor).
 prop(valk, voortbewegen, vliegen).
 prop(valk, knuffelheidsfactor, neutraal).



 prop(kraanvogel, naam, 'Paradijskraanvogel').
 prop(kraanvogel, latijn, 'Anthropoides paradiseus').
 prop(kraanvogel, verblijf, 19).
 prop(kraanvogel, kleur, grijs).
 prop(kraanvogel, gewicht, 5).
 prop(kraanvogel, grootte, 110).
 prop(kraanvogel, eten, herbivoor).
 prop(kraanvogel, voortbewegen, vliegen).
 prop(kraanvogel, knuffelheidsfactor, neutraal).



 prop(flamingo, naam, 'Chileense flamingo').
 prop(flamingo, latijn, 'Phoenicopterus chilensis').
 prop(flamingo, verblijf, 2).
 prop(flamingo, kleur, roze).
 prop(flamingo, gewicht, 15).
 prop(flamingo, grootte, 120).
 prop(flamingo, eten, carnivoor).
 prop(flamingo, voortbewegen, lopen).
 prop(flamingo, voortbewegen, vliegen).
 prop(flamingo, knuffelheidsfactor, neutraal).



 prop(ibis, naam, 'Rode ibis').
 prop(ibis, latijn, 'Eudocimes ruber').
 prop(ibis, verblijf, 10).
 prop(ibis, kleur, rood). % ik zocht het nog op ook..
 prop(ibis, gewicht, 0.7).
 prop(ibis, grootte, 60).
 prop(ibis, eten, carnivoor).
 prop(ibis, voortbewegen, vliegen).
 prop(ibis, knuffelheidsfactor, neutraal).



 prop(kangoeroe, naam, 'Kangoeroe').
 prop(kangoeroe, latijn, 'Macropodidae').
 prop(kangoeroe, verblijf, 7).
 prop(kangoeroe, kleur, bruin).
 prop(kangoeroe, gewicht, 15).
 prop(kangoeroe, grootte, 150).
 prop(kangoeroe, eten, herbivoor).
 prop(kangoeroe, voortbewegen, lopen).
 prop(kangoeroe, voortbewegen, rennen).
 prop(kangoeroe, knuffelheidsfactor, knuffelbaar).



 prop(antilope, naam, 'Vierhoornantilope').
 prop(antilope, latijn, 'Tetracerus quadricornis').
 prop(antilope, verblijf, 8).
 prop(antilope, kleur, bruin).
 prop(antilope, gewicht, 19).
 prop(antilope, grootte, 90).
 prop(antilope, eten, herbivoor).
 prop(antilope, voortbewegen, lopen).
 prop(antilope, voortbewegen, rennen).
 prop(antilope, knuffelheidsfactor, neutraal).



 prop(pinguin, naam, 'Ezelspinguin').
 prop(pinguin, latijn, 'Pygoscelis papua').
 prop(pinguin, verblijf, 13).
 prop(pinguin, kleur, zwart).
 prop(pinguin, kleur, wit).
 prop(pinguin, gewicht, 25).
 prop(pinguin, grootte, 60).
 prop(pinguin, eten, carnivoor).
 prop(pinguin, voortbewegen, zwemmen).
 prop(pinguin, voortbewegen, lopen).
 prop(pinguin, knuffelheidsfactor, neutraal).



 prop(bizon, naam, 'Europese bizon').
 prop(bizon, latijn, 'Bison bonasus').
 prop(bizon, verblijf, 20).
 prop(bizon, kleur, bruin).
 prop(bizon, gewicht, 800).
 prop(bizon, grootte, 260).
 prop(bizon, eten, herbivoor).
 prop(bizon, voortbewegen, lopen).
 prop(bizon, voortbewegen, rennen).
 prop(bizon, knuffelheidsfactor, gevaarlijk).



 prop(hyena, naam, 'Gevlekte hyena').
 prop(hyena, latijn, 'Crocuta crocuta').
 prop(hyena, verblijf, 24).
 prop(hyena, kleur, bruin).
 prop(hyena, kleur, lichtbruin).
 prop(hyena, gewicht, 60).
 prop(hyena, grootte, 140).
 prop(hyena, eten, carnivoor).
 prop(hyena, voortbewegen, lopen).
 prop(hyena, voortbewegen, rennen).
 prop(hyena, knuffelheidsfactor, gevaarlijk).



 prop(tijger, naam, 'Siberische tijger').
 prop(tijger, latijn, 'Panthera tigris altaica').
 prop(tijger, verblijf, 25).
 prop(tijger, kleur, oranje).
 prop(tijger, kleur, zwart).
 prop(tijger, kleur, wit).
 prop(tijger, gewicht, 325).
 prop(tijger, grootte, 205).
 prop(tijger, eten, carnivoor).
 prop(tijger, voortbewegen, lopen).
 prop(tijger, voortbewegen, rennen).
 prop(tijger, knuffelheidsfactor, gevaarlijk).



 prop(baviaan, naam, 'Bruine baviaan').
 prop(baviaan, latijn, 'Papio papio').
 prop(baviaan, verblijf, 31).
 prop(baviaan, kleur, bruin).
 prop(baviaan, gewicht, 40).
 prop(baviaan, grootte, 120).
 prop(baviaan, eten, omnivoor).
 prop(baviaan, voortbewegen, lopen).
 prop(baviaan, voortbewegen, klimmen).
 prop(baviaan, knuffelheidsfactor, knuffelbaar).


 prop(fazant, naam, 'Edwards fazant').
 prop(fazant, latijn, 'Lophura edwardsi').
 prop(fazant, verblijf, 9).
 prop(fazant, kleur, bruin).
 prop(fazant, kleur, rood).
 prop(fazant, gewicht, 2).
 prop(fazant, grootte, 63).
 prop(fazant, eten, omnivoor).
 prop(fazant, voortbewegen, vliegen).
 prop(fazant, knuffelheidsfactor, neutraal).


 prop(eend, naam, 'Muskuseend').
 prop(eend, latijn, 'Cairina moschata').
 prop(eend, verblijf, 27).
 prop(eend, kleur, zwart).
 prop(eend, kleur, wit).
 prop(eend, gewicht, 4).
 prop(eend, grootte, 85).
 prop(eend, eten, omnivoor).
 prop(eend, voortbewegen, vliegen).
 prop(eend, knuffelheidsfactor, neutraal).



% TODO: Fazant, eend, pelikaan, krokodil, haai

 prop(pelikaan, naam, 'Roze pelikaan').
 prop(pelikaan, latijn, 'Pelecanus onocrotalus').
 prop(pelikaan, verblijf, 28).
 prop(pelikaan, kleur, wit).
 prop(pelikaan, gewicht, 10).
 prop(pelikaan, grootte, 155).
 prop(pelikaan, eten, carnivoor).
 prop(pelikaan, voortbewegen, vliegen).
 prop(pelikaan, knuffelheidsfactor, neutraal).

 prop(krokodil, naam, 'Nijlkrokodil').
 prop(krokodil, latijn, 'Crocodylus niloticus').
 prop(krokodil, verblijf, 29).
 prop(krokodil, kleur, groen).
 prop(krokodil, gewicht, 700).
 prop(krokodil, grootte, 620).
 prop(krokodil, eten, carnivoor).
 prop(krokodil, voortbewegen, zwemmen).
 prop(krokodil, voortbewegen, lopen).
 prop(krokodil, knuffelheidsfactor, gevaarlijk).


 prop(haai, naam, 'Luipaardhaai').
 prop(haai, latijn, 'Triakis semifasciata').
 prop(haai, verblijf, 32).
 prop(haai, kleur, grijs).
 prop(haai, gewicht, 32).
 prop(haai, grootte, 210).
 prop(haai, eten, carnivoor).
 prop(haai, voortbewegen, zwemmen).
 prop(haai, knuffelheidsfactor, gevaarlijk).








/************ shortcuts  *****************************/


prop(A, knuffact, B) :-
 prop(A, knuffelheidsfactor, B).

% grootte_orde: zet grootte (cm) om in orde van grootte
% note: geeft dieren in volgorde van grootte
prop(A, grootte_orde, tiny) :- prop(A, grootte, B), B < 30.
prop(A, grootte_orde, klein) :- prop(A, grootte, B), B >= 30, B < 75.
prop(A, grootte_orde, medium) :- prop(A, grootte, B), B >= 75, B < 200.
prop(A, grootte_orde, groot) :- prop(A, grootte, B), B >= 200, B < 300.
prop(A, grootte_orde, huge) :- prop(A, grootte, B), B > 300.

% gewicht_orde: net zoiets? nodig?



