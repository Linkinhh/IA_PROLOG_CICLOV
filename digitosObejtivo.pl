% Trabajaremos con números de 3 cifras (de 100 a 999). Inicialmente, tenemos
% dos números prefijados, que denotaremos por S (Start) y G (Goal), y un
% conjunto de números que denotaremos por P (de Prohibidos). En cada
% turno, podemos transformar un número en otro añadiendo/sustrayendo 1 a
% uno de sus dígitos (por ejemplo, pasando de 678 a 679, o de 234 a
% 134). El coste de cada movimiento es 1. Adicionalmente, tenemos estas
% restricciones: (a) No se permite añadir 1 a 9, ni sustraer 1 a 0.
% (b) No se permite convertir un número en un elemento de P (están
% prohibidos). (c) No se puede cambiar un mismo dígito 2 veces
% seguidas. Además de dar la representación general, resuelve el
% caso particular S=567, G=777 y P={666,667}.

sol(A,V):- siguiente(e(567,737,[666,627,557]), [e(567,777,[666,667])], V, [], A).

%Verifica si es estado final
siguiente(e(E,E,_),V,V,A,A):- !.

%Busca el siguiente estado
siguiente(e(Ni,Nf,P),Lv,V,La,A):-
    accion(e(Ni,Nf,P),
           e(Nis,Nfs,P),
           Acc), %expande sucesores
	not(pertenece(e(Nis,Nfs,P),Lv)), %verifica estados repetidos
	siguiente(e(Nis,Nfs,P),
              [e(Nis,Nfs,P)|Lv],
              V,[Acc|La],A).

pertenece(X,[X|_]).
pertenece(X,[_|C]):- pertenece(X,C).

% Suma unidad pasa a mayor
accion(e(Ni,Nf,P),e(X,Nf,P),'Suma 1 unidad'):- Ni mod 10 < 9,
    X is Ni+1,
    C1 is X mod 10,
    C2 is Nf mod 10,
    C1 =< C2,
	not(member(X,P)).

% Resta unidad pasa a menor
accion(e(Ni,Nf,P),e(X,Nf,P),'Resta 1 unidad'):- Ni mod 10 < 9,
    X is Ni-1,
    C1 is X mod 10,
    C2 is Nf mod 10,
    C2 =< C1,
	not(member(X,P)).
        
% Suma decena pasa a mayor
accion(e(Ni,Nf,P),e(X,Nf,P),'Suma 1 decena'):- (Ni mod 100 - Ni mod 10)/10 < 9,
    X is Ni+10,
    C1 is (X mod 100 - X mod 10)/10,
    C2 is (Nf mod 100 - Nf mod 10)/10,
    C1 =< C2,
	not(member(X,P)).

% Resta decena pasa a menor
accion(e(Ni,Nf,P),e(X,Nf,P),'Resta 1 decena'):- (Ni mod 100 - Ni mod 10)/10 < 9,
    X is Ni-10,
    C1 is (X mod 100 - X mod 10)/10,
    C2 is (Nf mod 100 - Nf mod 10)/10,
    C2 =< C1,
	not(member(X,P)).

% Suma centena pasa a mayor
accion(e(Ni,Nf,P),e(X,Nf,P),'Suma 1 centena'):- (Ni - Ni mod 100)/100 < 9,
    X is Ni+100,
    C1 is (X - X mod 100)/100,
    C2 is (Nf - Nf mod 100)/100,
    C1 =< C2,
	not(member(X,P)).

% Resta centena pasa a menor
accion(e(Ni,Nf,P),e(X,Nf,P),'Resta 1 centena'):- (Ni - Ni mod 100)/100 < 9,
    X is Ni-100,
    C1 is (X - X mod 100)/100,
    C2 is (Nf - Nf mod 100)/100,
    C2 =< C1,
	not(member(X,P)).