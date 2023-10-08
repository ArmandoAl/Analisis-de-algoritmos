// ignore_for_file: avoid_print

import '../Models/Aresta.dart';
import '../Models/Grafo.dart';
import '../Models/Vertice.dart';

void kruskal(Grafo grafo) {
  // Ordena las aristas de G de menor a mayor peso.
  grafo.arestas!.sort((a, b) => a.peso!.compareTo(b.peso!));
  print(grafo.vertices!.length);

  Map<int, Set<int>> conjuntos = <int, Set<int>>{};

  for (Vertice vertice in grafo.vertices!) {
    conjuntos[vertice.id!] = {vertice.id!};
  }

  Grafo arbol = Grafo();
  arbol.arestas = <Aresta>[];

  for (Aresta aresta in grafo.arestas!) {
    if (conjuntos[aresta.origem!.id!] != conjuntos[aresta.destino!.id!]) {
      // Agrega e a la T.
      arbol.arestas?.add(aresta);

      // Une los conjuntos de los vértices de e.
      conjuntos[aresta.origem!.id!]?.addAll(conjuntos[aresta.destino!.id!]!);
    }
  }

  //imprime el arbol
  for (int i = 0; i < arbol.arestas!.length; i++) {
    print(
        "${arbol.arestas![i].origem!.id} - ${arbol.arestas![i].destino!.id} (peso: ${arbol.arestas![i].peso})");
  }
}
