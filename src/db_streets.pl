% Stratenlijst
% Auteurs: Robrecht Jurriaans, Moos Hueting
% lijst van bewandelbare wegen inclusief algemene lengte


street(1, 2, 127).
street(1, 4, 122).
street(1, 31, 102).
street(2, 3, 110).
street(2, 4, 106).
street(3, 5, 133).
street(3, 7, 104).
street(3, 8, 107).
street(4, 5, 84).
street(4, 28, 105).
street(5, 6, 115).
street(5, 27, 57).
street(6, 7, 60).
street(6, 24, 112).
street(6, 27, 110).
street(7, 8, 63).
street(7, 24, 130).
street(8, 9, 175).
street(9, 10, 50).
street(10, 11, 94).
street(10, 24, 130).
street(11, 12, 65).
street(11, 21, 94).
street(12, 14, 75).
street(13, 14, 65).
street(13, 32, 70).
street(14, 15, 116).
street(14, 16, 95).
street(15, 16, 94).
street(15, 17, 69).
street(15, 19, 102).
street(16, 17, 50).
street(16, 18, 45).
street(17, 18, 50).
street(17, 19, 51).
street(18, 19, 61).
street(18, 20, 65).
street(20, 22, 151).
street(21, 22, 81).
street(21, 23, 117).
street(22, 23, 94).
street(23, 24, 81).
street(23, 25, 138).
street(24, 27, 207).
street(25, 26, 110).
street(26, 27, 80).
street(26, 29, 70).
street(28, 29, 63).
street(28, 31, 101).
street(30, 31, 62).
	
/*
% beetje smokkelen

calc:-
	street(X, Y),
	distance(X,Y,Dist),
	Dist2 is round(Dist+5),
	writef('street(%w\, %w\, %w)\.', [X,Y,Dist2]),nl,fail.

street(1,2).
street(1,4).
street(1,31).
street(2,3).
street(2,4).
street(3,5).
street(3,7).
street(3,8).
street(4,5).
street(4,28).
street(5,6).
street(5,27).
street(6,7).
street(6,24).
street(6,27).
street(7,8).
street(7,24).
street(8,9).
street(9,10).
street(10,11).
street(10,24).
street(11,12).
street(11,21).
street(12,14).
street(13,14).
street(13,32).
street(14,15).
street(14,16).
street(15,16).
street(15,17).
street(15,19).
street(16,17).
street(16,18).
street(17,18).
street(17,19).
street(18,19).
street(18,20).
street(20,22).
street(21,22).
street(21,23).
street(22,23).
street(23,24).
street(23,25).
street(24,27).
street(25,26).
street(26,27).
street(26,29).
street(28,29).
street(28,31).
street(30,31).
*/
