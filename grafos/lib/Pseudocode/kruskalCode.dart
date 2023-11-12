// ignore_for_file: file_names

class KruscalCode {
  String text = '''Grafo kruskal(Grafo grafo) {
  // Ordena las aristas del grafo de menor a mayor peso.
  grafo.arestas!.sort((a, b) => a.peso!.compareTo(b.peso!));

  // Crea una tabla hash para almacenar los conjuntos disjuntos.
  ConjuntoDisjunto conjuntos = ConjuntoDisjunto();

  // Agrega cada vértice a su propio conjunto disjunto.
  for (Vertice vertice in grafo.vertices!) {
    conjuntos.crearConjunto(vertice.id!);
  }

  // Crea un árbol vacío.
  Grafo arbol = Grafo();
  arbol.arestas = <Arista>[];

  // Recorre las aristas del grafo en orden de menor a mayor peso.
  for (Arista aresta in grafo.arestas!) {
    // Si los dos vértices de la arista pertenecen al mismo conjunto disjunto, ignora la arista.
    if (conjuntos.estanEnElMismoConjunto(
        aresta.origem!.id!, aresta.destino!.id!)) {
      continue;
    }

    // Agrega la arista al árbol y une los dos conjuntos disjuntos.
    arbol.arestas!.add(aresta);
    conjuntos.unirConjuntos(aresta.origem!.id!, aresta.destino!.id!);
  }

  //agrega los vertices al arbol
  arbol.vertices = grafo.vertices;

  //haz un ciclo que revise si alguno de los vertices no tenga adyacentes, si no tiene adyacentes, agrega

  return arbol;
}
 ''';
}
