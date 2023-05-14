%Problema de Búsqueda No Informada
%Las jarras de 12L, 5L y 3L, para medir 2L
sol(A,V):- siguiente(e(0,0,0), [e(0,0,0)], V, [], A).

%Verifica si es estado final
siguiente(e(1,_,_),V,V,A,A):- !.
%Busca el siguiente estado
siguiente(e(X,Y,J),Lv,V,La,A):-
accion(e(X,Y,J),e(Xs,Ys,Js),Acc), %expande sucesores
not(pertenece(e(Xs,Ys,Js),Lv)), %verifica estados repetidos
siguiente(e(Xs,Ys,Js),[e(Xs,Ys,Js)|Lv],V,[Acc|La],A).

pertenece(X,[X|_]).
pertenece(X,[_|C]):- pertenece(X,C).

%llenar 12L
accion(e(X,Y,J),e(12,Y,J),'llenar 12L'):- X < 12.
%llenar 5L
accion(e(X,Y,J),e(X,5,J),'llenar 5L'):- Y < 5.
%llenar3L
accion(e(X,Y,J),e(X,Y,3),'vaciar 3L'):- J < 3.
%vaciar 12L
accion(e(X,Y,J),e(0,Y,J),'vaciar 12L'):- X > 0.
%vaciar 5L
accion(e(X,Y,J),e(X,0,J),'vaciar 5L'):- Y > 0.
%vaciar 3L
accion(e(X,Y,J),e(X,Y,0),'vaciar 3L'):- J > 0.

%verter 12 a 5, 12 queda vacio
accion(e(X,Y,J),e(0,Z,J),'verter 12 a 5'):- X > 0,
Y < 5,
Z is X + Y,
Z =<5.

%verter 12 a 5, 5 queda lleno
accion(e(X,Y,J),e(Z,5,J),'verter 12 a 5'):- X > 0,
Y < 5,
Z is X - (5-Y),
Z >=0.

%verter 12 a 3, 12 queda vacio
accion(e(X,Y,J),e(0,Y,Z),'verter 12 a 3'):- X > 0,
J < 3,
Z is X + J,
Z =<3.

%verter 12 a 3, 3 queda lleno
accion(e(X,Y,J),e(Z,Y,3),'verter 12 a 3'):- X > 0,
J < 3,
Z is X - (3-J),
Z >=0.

%verter 5 a 12, 5 queda vacio
accion(e(X,Y,J),e(Z,0,J),'verter 5 a 12'):- Y > 0,
X < 12,
Z is X + Y,
Z =<12.

%verter 5 a 12, 12 queda lleno
accion(e(X,Y,J),e(12,Z,J),'verter 5 a 12'):- Y > 0,
X < 12,
Z is Y - (12-X),
Z >=0.

%verter 5 a 3, 5 queda vacio
accion(e(X,Y,J),e(X,0,Z),'verter 5 a 3'):- Y > 0,
X < 3,
Z is J + Y,
Z =<3.

%verter 5 a 3, 3 queda lleno
accion(e(X,Y,J),e(X,Z,3),'verter 5 a 3'):- Y > 0,
X < 5,
Z is Y - (3-J),
Z >=0.

%verter 3 a 5, 3 queda vacio
accion(e(X,Y,J),e(X,Z,0),'verter 3 a 5'):- J > 0,
Y < 5,
Z is J + Y,
Z =<5.

%verter 3 a 5, 5 queda lleno
accion(e(X,Y,J),e(X,5,Z),'verter 3 a 5'):- J > 0,
Y < 5,
Z is J - (5-Y),
Z >=0.

%verter 3 a 12, 3 queda vacio
accion(e(X,Y,J),e(Z,Y,0),'verter 3 a 12'):- J > 0,
X < 12,
Z is J + X,
Z =<12.

%verter 3 a 12, 12 queda lleno
accion(e(X,Y,J),e(12,Y,Z),'verter 3 a 12'):- J > 0,
X < 12,
Z is J - (12-X),
Z >=0.