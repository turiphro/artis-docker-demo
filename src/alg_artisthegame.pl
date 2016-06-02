% Auteur: Robrecht Jurriaans
% comment: als dit geen wow-effect oplevert..
% Er zit een cheat in, of eigenlijk een glitch
% in het stop-predikaat is er mogelijkheid om te backtracken,
% dit resulteerd dus eerst in dat het stoppredikaat zegt welk dier
% geraden moest worden en vervolgens vraagt hij na backtracken of je een
% hint wil kopen of wilt raden. Dit is natuurlijk erg makkelijk eruit te
% halen maar ik vond het wel grappig.


artisgame:-
	write('Welkom bij Artis the Game\n'),
	write('Je begint bij level 1 en je hebt 100 Arto\'s in de bank\n'),
	write('Het systeem kiest een dier en je kan hints krijgen uit 5 categorieen\n'),
	findall(Animal, vind_level(Animal, 4), List),
	generateanimal(List, Choice, Rest),
	givehint(Choice, 5, _),
	write('Wil je raden of een hint kopen?\nTyp raad\. of hint\.\n'),
	read(X),
	artisquestion(X, Choice, Rest, 1, 100).

artisquestion(raad, Choice, List, Level, Arto):-
	write('Welk dier denk je dat het is?\n'),
	read(Guess),
	Choice = Guess,!,
	write('Gefeliciteerd, u heeft het goed!\n'),
	Newlevel is Level+1,
	Newarto is Arto+20,
	write('Ik neem een nieuw dier\n'),
	generateanimal(List, Newchoice, Rest),
	givehint(Newchoice, 5, _),
	write('Wil je raden of een hint kopen?\nTyp raad\. of hint\.\n'),
	read(X),
	artisquestion(X, Newchoice, Rest, Newlevel, Newarto)
	;
	write('Dit was helaas niet het goede antwoord\n'),
	Newarto is Arto-5,
	write('Wil je nog een keer raden of toch maar een hint kopen?\nTyp raad\. of hint\. of typ stat\. voor statistieken\n'),
	read(X),
	artisquestion(X, Choice, List, Level, Newarto).
	

artisquestion(hint, Choice, List, Level, Arto):-
	!,
	write('U wilt een hint kopen\nDat kan uit 5 categorieen:\n'),
	write('1\. In welke familie zit het dier?          Kosten: 15 Arto\n'),
	write('2\. Kleuren van dier?                       Kosten: 12 Arto\n'),
	write('3\. In welk verblijf zit het dier?          Kosten: 10 Arto\n'),
	write('4\. Wat voor eigenschappen heeft het dier?  Kosten:  7 Arto\n'),
	write('5\. Een willekeurige hint?                  Kosten:  5 Arto\n'),
	read(X),
	givehint(Choice, X, Cost),
	Newarto is Arto-Cost,
	write('Wil je raden of een hint kopen?\nTyp raad\. of hint\.\n'),
	read(Y),
	artisquestion(Y, Choice, List, Level, Newarto).

artisquestion(stat, Choice, List, Level, Arto):-
	writef('Je bent op level %w en je hebt nog %w Artos\n',[Level, Arto]),
	write('Wil je raden of een hint kopen?\nTyp raad\. of hint\.\n'),
	read(Y),
	artisquestion(Y, Choice, List, Level, Arto).

	
artisquestion(stop, Choice, _List, Level, Arto):-
	writef('U was op level %w en u had nog %w Arto\'s over\nHet dier wat u als laatst zocht was een %w\n',[Level,Arto,Choice]).
	
artisquestion(Fail, Choice, List, Level, Arto):-
%       Fail \= stop, %dit zou de glitch verhelpen
	writef('%w is niet een optie, probeer opnieuw:\nTyp raad\. of hint\.\n',[Fail]),
	read(X),
	artisquestion(X, Choice, List, Level, Arto).

generateanimal(List, Choice, Rest):-
	length(List, Remain),
	No is random(Remain),
	generator(List, No, Choice),
	select(Choice, List, Rest).

generator([H|_], 0, H):-!.

generator([_|List], No, Choice):-
	New is No-1,
	generator(List, New, Choice).

generateanimal([],_,_):-
	write('U heeft het spel uitgespeeld\nU kunt uwzelf nu koning van Artis noemen\n').

givehint(Animal, 1, 15):-
	write('Hint uit categorie 1:\n'),
	isfam(Animal, Fam),
	vind_level(Fam, 3),
	writef('Het dier zit in de familie van %w\n',[Fam]).

givehint(Animal, 2, 12):-
	write('Hint uit categorie 2:\n'),
	findall(Color, hasprop(Animal, kleur, Color), Colors),
	write('Het dier heeft de volgende kleuren:\n'),
	showcolors(Colors),nl.

showcolors([]):-!.

showcolors([H|T]):-
	write(H),tab(1),
	showcolors(T).

givehint(Animal, 3, 10):-
	write('Hint uit categorie 3:\n'),
	hasprop(Animal, verblijf, No),
	writef('Het dier zit in verblijf %w\n',[No]).

givehint(Animal, 4, 7):-
	write('Hint uit categorie 4:\n'),
	hasprop(Animal, knuffact, X),
	hasprop(Animal, grootte_orde, Y),
	writef('Het dier is %w en %w\n', [X,Y]).

givehint(Animal, 5, 5):-
	write('Hint uit categorie 5:\n'),
	findall(Prop/Value, hasprop(Animal, Prop, Value), List),
	randompick(List, X/Y),
	X \= naam,
	X \= latijn,
	X \= verblijf,
	X \= kleur,
	X \= knuffact,
	X \= grootte_orde,
	writef('Het dier heeft als eigenschap %w, de waarde %w\n', [X,Y]).

randompick(List, X/Y):-
	length(List, Length),
	Counter is random(Length),
	randompick(List,List, Counter, X/Y).

randompick([X/Y|_], _, Count, X/Y):-
	Count =< 0.

randompick(_, List, Count, X/Y):-
	Count =< 0,
	length(List, Length),
	Counter is random(Length),
	randompick(List,List, Counter, X/Y).

randompick([_|T], List, Count, X/Y):-
	Count > 0,
	New is Count-1,
	randompick(T, List, New, X/Y).
	
randompick([], List, Count, X/Y):-
	randompick(List, List, Count, X/Y).
