% Database met globale variabelen
% zoals: huidige datum etc
% handig voor: dynamisch artis, waarin de globale vars
% steeds worden geassert (en opgeslagen in dit bestand),
% dieren dood gaan en geboren worden en gebouwen
% gerenoveerd moeten worden na enige tijd.
% 
% Dit is niet geimplementeerd (hoewel de vars wel
% gebruikt worden), maar bied die mogelijkheid wel.
%
% Auteur: Martijn van der Veen


% changable
global_var(datum_dag, 1).
global_var(datum_maand, 1).
global_var(datum_jaar, 2009).
global_var(tijd_uur, 10).
global_var(tijd_min, 0).
global_var(vermogen_artis, 50000000).
global_var(medewerkers, 200).



% do not change!
global_var(datum, A/B/C) :-
	global_var(datum_dag, A),
	global_var(datum_maand, B),
	global_var(datum_jaar, C).
global_var(tijd, A/B) :-
	global_var(tijd_uur, A),
	global_var(tijd_min, B).

