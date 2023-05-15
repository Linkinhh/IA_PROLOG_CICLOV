from collections import deque

# Función para intercambiar las posiciones de las ranas
def intercambiar_posiciones(estado, i, j):
    estado[i], estado[j] = estado[j], estado[i]

# Función para encontrar el movimiento válido dado un estado
def encontrar_movimiento(estado):
    n = len(estado) // 2

    # Cola para realizar el recorrido en anchura
    cola = deque([(estado, 0, [])])

    # Diccionario para almacenar los estados visitados
    visitados = {tuple(estado)}

    while cola:
        estado_actual, costo, movimientos = cola.popleft()

        if estado_actual == objetivo:
            return estado_actual, costo, movimientos

        espacio_vacio = estado_actual.index('_')

        # Movimiento hacia la izquierda
        if espacio_vacio > 0 and estado_actual[espacio_vacio - 1] == 'r':
            nuevo_estado = estado_actual[:]
            intercambiar_posiciones(nuevo_estado, espacio_vacio, espacio_vacio - 1)
            nuevo_costo = costo + 1
            nuevos_movimientos = movimientos + [(espacio_vacio - 1, espacio_vacio)]

            if tuple(nuevo_estado) not in visitados:
                cola.append((nuevo_estado, nuevo_costo, nuevos_movimientos))
                visitados.add(tuple(nuevo_estado))

        # Movimiento hacia la derecha
        if espacio_vacio < len(estado_actual) - 1 and estado_actual[espacio_vacio + 1] == 'v':
            nuevo_estado = estado_actual[:]
            intercambiar_posiciones(nuevo_estado, espacio_vacio, espacio_vacio + 1)
            nuevo_costo = costo + 1
            nuevos_movimientos = movimientos + [(espacio_vacio + 1, espacio_vacio)]

            if tuple(nuevo_estado) not in visitados:
                cola.append((nuevo_estado, nuevo_costo, nuevos_movimientos))
                visitados.add(tuple(nuevo_estado))

        # Salto hacia la izquierda
        if espacio_vacio > 1 and estado_actual[espacio_vacio - 2] == 'r':
            nuevo_estado = estado_actual[:]
            intercambiar_posiciones(nuevo_estado, espacio_vacio, espacio_vacio - 2)
            nuevo_costo = costo + 2
            nuevos_movimientos = movimientos + [(espacio_vacio - 2, espacio_vacio)]

            if tuple(nuevo_estado) not in visitados:
                cola.append((nuevo_estado, nuevo_costo, nuevos_movimientos))
                visitados.add(tuple(nuevo_estado))

        # Salto hacia la derecha
        if espacio_vacio < len(estado_actual) - 2 and estado_actual[espacio_vacio + 2] == 'v':
            nuevo_estado = estado_actual[:]
            intercambiar_posiciones(nuevo_estado, espacio_vacio, espacio_vacio + 2)
            nuevo_costo = costo + 2
            nuevos_movimientos = movimientos + [(espacio_vacio + 2, espacio_vacio)]

            if tuple(nuevo_estado) not in visitados:
                cola.append((nuevo_estado, nuevo_costo, nuevos_movimientos))
                visitados.add(tuple(nuevo_estado))

    return None

# Estado inicial y objetivo
estado_inicial = ['r', 'r', 'r','r', '_','v', 'v', 'v', 'v']
objetivo = ['v', 'v', 'v', 'v',  '_', 'r', 'r', 'r', 'r']

# Resolución del juego de las ranas
resultado = encontrar_movimiento(estado_inicial)

if resultado:
    estado_final, costo_total, movimientos = resultado
    print(f"Estado final: {estado_final}")
    print(f"Costo total: {costo_total}")
    print("Movimientos:")
    for movimiento in movimientos:
        rana, espacio_vacio = movimiento
        if rana < espacio_vacio:
            print(f"Mover la rana {rana} hacia la derecha")
        else:
            print(f"Mover la rana {rana} hacia la izquierda")
else:
    print("No se encontró solución para el juego de las ranas.")
