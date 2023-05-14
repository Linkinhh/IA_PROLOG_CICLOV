% Problema de Búsqueda No Informada
% Misioneros y Caníbales: Hay 3 misioneros y 3 caníbales a 
% la orilla de un río. Tienen una canoa con capacidad para
% dos personas como máximo. Se desea que los seis crucen
%  el río, pero hay que considerar que no debe haber más
%   caníbales que misioneros en ningún sitio porque entonces
%    los caníbales se comerían a los misioneros. Además,
%     la canoa siempre debe ser conducida por alguien
%      (no puede cruzar el río sola).

% Planteamiento:
% Estado(num_m_A,num_c_A, num_m_B,num_c_B, canoa)
% Estado inicial: (3,3,0,0,0)
% Estado objetivo: (0,0,3,3,1)
% 	Lleva 2 caníbales: (3,1,0,2,1)
% 	Regresa 1 caníbal: (3,2,0,1,0)
% 	Lleva 2 caníbales: (3,0,0,3,1)
% 	Regresa 1 caníbal: (3,1,0,2,0)
% 	Lleva 2 misioneros: (1,1,2,2,1)
% 	Regresa 1,1: (2,2,1,1,0)
% 	Lleva 2 misioneros: (0,2,3,1,1)
% 	Regresa 1 caníbal: (0,3,3,0,0)
% 	Lleva 2 caníbales: (0,1,3,2,1)
% 	Regresa caníbal: (0,2,3,1,0)
% 	Lleva 2 caníbales: (0,0,3,3,1)

sol(A,V):- siguiente(e(3,2,0,1,0), [e(3,2,0,1,0), e(3,1,0,2,1), e(3,3,0,0,0)], V, [], A).

%Verifica si es estado final
siguiente(e(0,0,3,3,1),V,V,A,A):- !.

%Busca el siguiente estado
siguiente(e(NMA,NCA,NMB,NCB,C),Lv,V,La,A):-
	accion(e(NMA,NCA,NMB,NCB,C),
           e(NMAs,NCAs,NMBs,NCBs,Cs),
           Acc), %expande sucesores
	not(pertenece(e(NMAs,NCAs,NMBs,NCBs,Cs),Lv)), %verifica estados repetidos
	siguiente(e(NMAs,NCAs,NMBs,NCBs,Cs),
              [e(NMAs,NCAs,NMBs,NCBs,Cs)|Lv],
              V,[Acc|La],A).

pertenece(X,[X|_]).
pertenece(X,[_|C]):- pertenece(X,C).

% Lleva 2 caníbales
accion(e(NMA,NCA,NMB,NCB,0),e(NMA,X,NMB,Y,1),'Lleva 2 caníbales'):- NCA > 1,
    Y is NCB+2,
    X is NCA-2,
    Y =< NMB.
accion(e(NMA,NCA,0,NCB,0),e(NMA,X,0,Y,1),'Lleva 2 caníbales'):- NCA > 1,
    Y is NCB+2,
    X is NCA-2.
% Regresa 2 caníbales
accion(e(NMA,NCA,NMB,NCB,1),e(NMA,X,NMB,Y,0),'Regresa 2 caníbales'):- NCB > 1,
    Y is NCB-2,
    X is NCA+2,
    X =< NMA.
accion(e(0,NCA,NMB,NCB,1),e(0,X,NMB,Y,0),'Regresa 2 caníbales'):- NCB > 1,
    Y is NCB-2,
    X is NCA+2.

% Lleva 1 caníbal
accion(e(NMA,NCA,NMB,NCB,0),e(NMA,X,NMB,Y,1),'Lleva 1 caníbal'):- NCA >= 1,
    Y is NCB+1,
    X is NCA-1,
    Y =< NMB.
accion(e(NMA,NCA,0,NCB,0),e(NMA,X,0,Y,1),'Lleva 1 caníbal'):- NCA >= 1,
    Y is NCB+1,
    X is NCA-1.
% Regresa 1 caníbal
accion(e(NMA,NCA,NMB,NCB,1),e(NMA,X,NMB,Y,0),'Regresa 1 caníbal'):- NCB >= 1,
    Y is NCB-1,
    X is NCA+1,
    X =< NMA.
accion(e(0,NCA,NMB,NCB,1),e(0,X,NMB,Y,0),'Regresa 1 caníbal'):- NCB >= 1,
    Y is NCB-1,
    X is NCA+1.
%----------------------------------

% Lleva 2 misioneros
accion(e(NMA,NCA,NMB,NCB,0),e(X,NCA,Y,NCB,1),'Lleva 2 misioneros'):- NMA > 1,
    Y is NMB+2,
    X is NMA-2,
    Y >= NCB,
    X >= NCA.
accion(e(NMA,NCA,NMB,NCB,0),e(X,NCA,Y,NCB,1),'Lleva 2 misioneros'):- NMA > 1,
    Y is NMB+2,
    X is NMA-2,
    Y >= NCB,
    X == 0.
% Regresa 2 misioneros
accion(e(NMA,NCA,NMB,NCB,1),e(X,NCA,Y,NCB,0),'Regresa 2 misioneros'):- NMB > 1,
    Y is NMB-2,
    X is NMA+2,
    X >= NCA,
    Y >= NCB.
accion(e(NMA,NCA,NMB,NCB,1),e(X,NCA,Y,NCB,0),'Regresa 2 misioneros'):- NMB > 1,
    Y is NMB-2,
    X is NMA+2,
    X >= NCA,
    Y == 0.
% Lleva 1 misionero
accion(e(NMA,NCA,NMB,NCB,0),e(X,NCA,Y,NCB,1),'Lleva 1 misionero'):- NMA >= 1,
    Y is NMB+1,
    X is NMA-1,
    Y >= NCB,
    X >= NCA.
accion(e(NMA,NCA,NMB,NCB,0),e(X,NCA,Y,NCB,1),'Lleva 1 misionero'):- NMA >= 1,
    Y is NMB+1,
    X is NMA-1,
    Y >= NCB,
    X == 0.
% Regresa 1 misionero
accion(e(NMA,NCA,NMB,NCB,1),e(X,NCA,Y,NCB,0),'Regresa 1 misionero'):- NMB >= 1,
    Y is NMB-1,
    X is NMA+1,
    Y == 0,
    X >= NCA.

% Lleva 1 canibal lleva 1 misionero

accion(e(NMA,NCA,NMB,NCB,0),e(W,X,Y,Z,1),'Lleva 1 canibal lleva 1 misionero'):- 
    NMA >= 1,
    NCA >= 1,
    W is NMA-1,
    X is NCA-1,
    Y is NMB+1,
    Z is NCB+1,
    Y >= Z.

% Traer 1 canibal lleva 1 misionero

accion(e(NMA,NCA,NMB,NCB,1),e(W,X,Y,Z,0),'Regrsa 1 canibal Regresa 1 misionero'):- 
    NMB >= 1,
    NCB >= 1,
    W is NMA+1,
    X is NCA+1,
    Y is NMB-1,
    Z is NCB-1,
	W >= X.