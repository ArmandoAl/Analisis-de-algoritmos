import 'package:grafos/Models/Arista.dart';
import 'package:grafos/Models/Grafo.dart';
import 'package:grafos/Models/Vertice.dart';

Grafo dijkstra(Grafo grafo, Vertice origen) {
  // Inicializar todas las distancias desde el origen a infinito, excepto la distancia al propio origen que es 0.
  for (Vertice vertice in grafo.vertices!) {
    vertice.pesoPermanente = vertice == origen ? 0 : 100000;
    vertice.anterior = null;
  }

  // Crear un conjunto vacío para almacenar los nodos visitados.
  List<Vertice> visitados = [];

  while (visitados.length < grafo.vertices!.length) {
    // Seleccionar el nodo no visitado con la distancia mínima.
    Vertice? verticeMinimo;
    for (Vertice vertice in grafo.vertices!) {
      if (!visitados.contains(vertice) &&
          (verticeMinimo == null ||
              vertice.pesoPermanente! < verticeMinimo.pesoPermanente!)) {
        verticeMinimo = vertice;
      }
    }

    // Marcar el nodo como visitado.
    visitados.add(verticeMinimo!);

    // Para cada vecino no visitado del nodo actual:
    for (Vertice vecino in verticeMinimo.adjacentes!) {
      if (!visitados.contains(vecino)) {
        // Calcular la nueva distancia desde el origen a través del nodo actual.
        Arista? aresta = _buscarAresta(grafo, verticeMinimo, vecino);
        int nuevaDistancia =
            verticeMinimo.pesoPermanente! + (aresta?.peso ?? 100000);

        // Si la nueva distancia es menor que la distancia almacenada, actualizarla.
        if (nuevaDistancia < vecino.pesoPermanente!) {
          vecino.pesoPermanente = nuevaDistancia;
          vecino.anterior = verticeMinimo;
        }
      }
    }
  }

  // Marcar los vértices y aristas que pertenecen a la ruta más corta.
  for (Vertice vertice in grafo.vertices!) {
    if (vertice.anterior != null) {
      vertice.marcado = true;
      Arista? aresta = _buscarAresta(grafo, vertice, vertice.anterior!);
      if (aresta != null) {
        aresta.marcada = true;
      }
    }
  }

  return grafo;
}

Arista? _buscarAresta(Grafo grafo, Vertice vertice1, Vertice vertice2) {
  for (Arista aresta in grafo.arestas!) {
    if ((aresta.origem == vertice1 && aresta.destino == vertice2) ||
        (aresta.origem == vertice2 && aresta.destino == vertice1)) {
      return aresta;
    }
  }
  return null;
}
