import 'dart:collection';

class Graph {
  Map<int, List<int>> adjacencyList = {};

  Graph() {
    this.adjacencyList = {};
  }

  void addEdge(int u, int v) {
    adjacencyList.putIfAbsent(u, () => []);
    adjacencyList.putIfAbsent(v, () => []);

    adjacencyList[u]!.add(v);
    adjacencyList[v]!.add(u);
  }

  Map<int, int> bfs(int start) {
    Queue<int> queue = Queue();
    Map<int, int> distance = {start: 0};

    queue.add(start);

    while (queue.isNotEmpty) {
      int current = queue.removeFirst();

      for (int neighbor in adjacencyList[current]!) {
        if (!distance.containsKey(neighbor)) {
          distance[neighbor] = distance[current]! + 1;
          queue.add(neighbor);
        }
      }
    }

    return distance;
  }

  int calculateEccentricity(int vertex) {
    Map<int, int> distances = bfs(vertex);
    return distances.values.reduce((max, value) => value > max ? value : max);
  }

  int calculateRadius() {
    int minEccentricity = adjacencyList.keys
        .map((vertex) => calculateEccentricity(vertex))
        .reduce((min, value) => value < min ? value : min);

    return minEccentricity;
  }

  int calculateDiameter() {
    int maxEccentricity = adjacencyList.keys
        .map((vertex) => calculateEccentricity(vertex))
        .reduce((max, value) => value > max ? value : max);

    return maxEccentricity;
  }
}

void main() {
  Graph graph = Graph();

  graph.addEdge(1, 2);
  graph.addEdge(2, 3);
  graph.addEdge(2, 4);
  graph.addEdge(3, 5);
  graph.addEdge(4, 5);

  final Stopwatch stopwatch = Stopwatch()..start(); // Inicia el temporizador

  int radius = graph.calculateRadius();
  int diameter = graph.calculateDiameter();

  stopwatch.stop(); // Detiene el temporizador

  print("Radio del grafo: $radius");
  print("Diámetro del grafo: $diameter");
  print("Tiempo de ejecución: ${stopwatch.elapsedMilliseconds} ms");
}
