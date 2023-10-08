import 'dart:math';

class Aresta {
  int? id;
  Vertice? origem;
  Vertice? destino;
  int? peso;
}

class Vertice {
  int? id;
}

class Grafo {
  List<Vertice>? vertices;
  List<Aresta>? arestas;
}

//generar grafo aleatorio con n vertices y una probabilidad p de que exista una arista entre dos vertices, si ya hay una arista entre dos vertices no se genera otra arista entre ellos
Grafo generarGrafoAleatorio(int n, double p) {
  Grafo grafo = Grafo();
  grafo.vertices = [];
  grafo.arestas = [];
  for (int i = 0; i < n; i++) {
    Vertice vertice = Vertice();
    vertice.id = i;
    grafo.vertices!.add(vertice);
  }
  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      Random random = Random();
      double probabilidad = random.nextDouble();
      if (probabilidad <= p) {
        Aresta aresta = Aresta();
        aresta.id = grafo.arestas!.length;
        aresta.origem = grafo.vertices![i];
        aresta.destino = grafo.vertices![j];
        aresta.peso = random.nextInt(100);
        grafo.arestas!.add(aresta);
      }
    }
  }
  return grafo;
}

void main() {
  Grafo grafo = generarGrafoAleatorio(4,
      0.5); //genera un grafo aleatorio con 5 vertices y una probabilidad de 0.5 de que exista una arista entre dos vertices

  //impime el grafo con este formato
  // 0 - 3 (peso: 96)
  // 1 - 2 (peso: 46)
  // 1 - 3 (peso: 78)

  for (int i = 0; i < grafo.arestas!.length; i++) {
    print(grafo.arestas![i].origem!.id.toString() +
        " - " +
        grafo.arestas![i].destino!.id.toString() +
        " (peso: " +
        grafo.arestas![i].peso.toString() +
        ")");
  }
}
