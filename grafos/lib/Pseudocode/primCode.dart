// ignore_for_file: file_names

class PrimCode {
  String text = ''' Grafo prim(Grafo grafo) {
  Grafo grafoPrim = Grafo();
  grafoPrim.vertices = List.from(grafo.vertices!);
  grafoPrim.arestas = [];

  List<Vertice> vertices = [];
  Vertice verticeInicial = grafo.vertices![0];
  verticeInicial.pesoPermanente = 0;
  vertices.add(verticeInicial);

  // Inicializar una cola de prioridad para almacenar las aristas del grafo
  List<Arista> colaPrioridad = [];

  // Agregar todas las aristas adyacentes al vértice inicial en la cola de prioridad
  for (Arista aresta in grafo.arestas!) {
    if (aresta.origem == verticeInicial || aresta.destino == verticeInicial) {
      colaPrioridad.add(aresta);
    }
  }

  // Ordenar la cola de prioridad
  colaPrioridad.sort((a, b) => a.peso!.compareTo(b.peso!));

  while (vertices.length < grafo.vertices!.length) {
    // Obtener la arista con el peso mínimo de la cola de prioridad
    Arista arestaMenor = colaPrioridad.removeAt(0);

    // Obtener los vértices conectados por la arista
    Vertice vertice1 = arestaMenor.origem!;
    Vertice vertice2 = arestaMenor.destino!;

    // Si ambos vértices ya están en el árbol de expansión mínima, continuar al siguiente bucle
    if (vertices.contains(vertice1) && vertices.contains(vertice2)) {
      continue;
    }

    // Agregar el vértice que no está en el árbol al árbol de expansión mínima
    Vertice verticeNuevo = vertices.contains(vertice1) ? vertice2 : vertice1;
    vertices.add(verticeNuevo);

    // Agregar la arista al árbol de expansión mínima
    grafoPrim.arestas!.add(arestaMenor);

    // Agregar todas las aristas adyacentes al nuevo vértice en la cola de prioridad
    for (Arista aresta in grafo.arestas!) {
      if (aresta.origem == verticeNuevo || aresta.destino == verticeNuevo) {
        colaPrioridad.add(aresta);
      }
    }

    // Ordenar la cola de prioridad
    colaPrioridad.sort((a, b) => a.peso!.compareTo(b.peso!));
  }

  return grafoPrim;
}
 ''';
}
