% corr tie
ufo(balloon).
ufo(kite).
ufo(fighter).
ufo(cloud).

% corr mr
cdt(smith).
cdt(jones).
cdt(garcia).
cdt(chen).

% corr relative
day(tue).
day(wed).
day(thu).
day(fri).

solve :-
    ufo(SmithUfo), ufo(JonesUfo), ufo(GarciaUfo), ufo(ChenUfo),
    all_different([SmithUfo, JonesUfo, GarciaUfo, ChenUfo]),
    
    day(SmithDay), day(JonesDay), day(GarciaDay), day(ChenDay),
    all_different([SmithDay, JonesDay, GarciaDay, ChenDay]),
    
    Triples = [ [smith, SmithUfo, SmithDay],
                [jones, JonesUfo, JonesDay],
                [garcia, GarciaUfo, GarciaDay],
                [chen, ChenUfo, ChenDay] ],
    
    %C4C Smith did not see a weather balloon, nor kite.
    \+ member([smith, balloon, _], Triples),
    \+ member([smith, kite, _], Triples),

    %The one who saw the kite isn’t C4C Garcia.
    \+ member([garcia, kite, _], Triples),

    %Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    (   member([chen, _, fri], Triples); member([_, fighter, fri], Triples)),

    %The kite was not sighted on Tuesday.
    \+ member([_, kite, tue], Triples),

    %Neither C4C Garcia nor C4C Jones saw the weather balloon.
    \+ member([garcia, balloon, _], Triples),
    \+ member([jones, balloon, _], Triples),

    %C4C Jones did not make their sighting on Tuesday.
    \+ member([jones, _, tue], Triples),

    %C4C Smith saw an object that turned out to be a cloud.
    member([smith, cloud, _], Triples),

    %The fighter aircraft was spotted on Friday.
    member([_, fighter, fri], Triples),

    %The weather balloon was not spotted on Wednesday.
    \+ member([_, balloon, wed], Triples),

    tell(tue, Triples),
    tell(wed, Triples),
    tell(thu, Triples),
    tell(fri, Triples),
	nl.

%from hw
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(D, Triples) :-
    member([C, U, D], Triples), !,
    write(D), write(': '), write(C), write(' saw '), write(U), nl.
    	

