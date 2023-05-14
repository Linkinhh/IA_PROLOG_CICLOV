%Problema de Búsqueda No Informada
sol(A,V):- siguiente(e(1,1), [e(1,1)], V, [], A).

%Verifica si es estado final
siguiente(e(1,9),V,V,A,A):- !.
%Busca el siguiente estado
siguiente(e(X,Y),Lv,V,La,A):-
    accion(e(X,Y),e(Xs,Ys),Acc), %expande sucesores
    not(pertenece(e(Xs,Ys),Lv)), %verifica estados repetidos    
    not(muro(e(Xs,Ys))), %verifica estados repetidos
    siguiente(e(Xs,Ys),[e(Xs,Ys)|Lv],V,[Acc|La],A).

pertenece(X,[X|_]).
pertenece(X,[_|R]):- pertenece(X,R).

%derecha
accion(e(X,Y),e(Z,Y),'ir a la derecha'):- X < 5, Z is X + 1.
%izquierda
accion(e(X,Y),e(Z,Y),'ir a la izquierda'):- X > 1, Z is X - 1.
%subir
accion(e(X,Y),e(X,Z),'subir'):- Y < 9, Z is Y + 1.
%bajar
accion(e(X,Y),e(X,Z),'bajar'):- Y > 1, Z is Y - 1.

%restricciones
muro(e(5,1)).
muro(e(1,2)).
muro(e(2,2)).
muro(e(1,3)).
muro(e(5,4)).
muro(e(5,5)).
muro(e(5,6)).
muro(e(5,4)).
muro(e(3,6)).
muro(e(2,6)).
muro(e(2,7)).
muro(e(3,7)).
muro(e(1,8)).
muro(e(5,9)).