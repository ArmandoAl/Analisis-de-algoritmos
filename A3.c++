#include <iostream>
#include <vector>
#include <random>
using namespace std;

vector<vector<int>> generarGrafoAleatorio(int n, float p) {
  vector<vector<int>> grafo(n, vector<int>(n, 0));
  // Generar las conexiones
  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      if (random() < p) {
        grafo[i][j] = 1;
        grafo[j][i] = 1;
      }
    }
  }
  return grafo;
}

int main() {
  // Generar un grafo aleatorio con 10 vértices y una probabilidad de conexión de 0.5
  vector<vector<int>> grafo = generarGrafoAleatorio(10, 0.5);

  // Imprimir el grafo
  for (int i = 0; i < grafo.size(); i++) {
    for (int j = 0; j < grafo[i].size(); j++) {
      cout << grafo[i][j] << " ";
    }
    cout << endl;
  }

  return 0;
}
