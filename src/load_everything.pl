% Load_everything.pl
% (consult everything here)
% Author: Martijn, Robrecht, Eva, Moos
% Version 82.7


% no irritating messages about 'not together in source-file'
:-	style_check(-discontiguous).

% nodig voor het in vuilniszak doen van afval (zodat het er netjes uitziet
:-	op(500, yfy, ' ').

% Databases / knowledge bases
:-	include('db_dieren_algemeen.pl').	% algemene diersoorten (leeuw, etc)
:-	include('db_dieren_artis.pl').		% specifieke dieren in artis (bv.simba)
:-	include('db_gebouwen_artis.pl').	% gebouwen in artis met eigenschappen
:-	include('db_schoonmaak.pl').		% informatie over hoe schoon te maken
:-	include('db_voeding.pl').		% informatie over hoe dieren te voeden
:-	include('db_streets.pl').		% straten/paden in artis, met cost
:-	include('db_globalvars.pl').		% globale variabelen (datum etc)
:-      include('db_nodig.pl').			% regels voor property's (voorouders)
:-	include('db_bezoekers_artis.pl').	% (dynamische) database met bezoekers


% Algoritmes
:-	include('alg_overerving.pl').		% overervingsregels
:-	include('alg_routeplanner.pl').		% route over wegen plannen
:-	include('alg_alterverblijf.pl').	% zoek alternatief verblijf voor dier x
:-	include('alg_statbuild.pl').		% geeft huidige statistieken
:-      include('alg_dieropattribuut.pl').      % zoek dier op gegeven attributen
:-      include('alg_vindlevel.pl').		% 
:-      include('alg_zoekattributen.pl').	% ..
:-      include('alg_vindgelijkendedieren.pl').	% lijstjes met dieren die op elkaar lijken
:-      include('alg_dierinfo.pl').		% inf over dieren (gebaseerd op user)
:- 	include('alg_info.pl').			% info over dieren en procedurele kennis
:-	include('alg_info_profile.pl').	% info over dieren en procedurele kennis, toegespitst op de gebruiker
:-	include('alg_bezoekers.pl').		% user add/remove/getinfo
:-	include('alg_derive_dieren.pl').	% geeft lijst met dieren die gebruiker leuk vindt

:-	include('alg_artisthegame.pl').         % obscuur bestand waar niemand de oorsprong van weet


% Testinterfaces & go-predicaten
:-      include('int_start.pl').		% algemeen testmenu. open met 'menu.' voor alle opties
:-      include('int_start_route_user.pl').     % Routeplannen aan de hand van gebruikersdatabase
:-	include('int_routeplan.pl').		% route plannen voor bezoekers Test interface
:-	include('int_bezoekers.pl').		% testpredicaten voor gebruikers
:-	include('int_info_profile.pl').		% interface voor informatie over procedurele kennis
