#include <iostream>
#include <vector>
#include <algorithm>
#include <set>

using namespace std;


struct Arista {
  int u, v, peso;

  Arista(int u, int v, int peso) : u(u), v(v), peso(peso) {}
};

struct Vertice {
  int etiqueta;
  vector<Arista> vecinos;

  Vertice(int etiqueta) : etiqueta(etiqueta) {}
};


vector<Vertice *> generarGrafoAleatorio(int nVertices, int nAristas) {
  // Crea un vector de vértices.
  vector<Vertice *> vertices;
  for (int i = 0; i < nVertices; i++) {
    vertices.push_back(new Vertice(i));
  }

  // Crea las aristas.
  for (int i = 0; i < nAristas; i++) {
    // Elige dos vértices aleatorios.
    int v1 = rand() % nVertices;
    int v2 = rand() % nVertices;

    // Crea una nueva arista.
    Arista arista(v1, v2, rand() % 100);

    // Agrega la arista al vértice u.
    vertices[v1]->vecinos.push_back(arista);

    // Agrega la arista al vértice v.
    vertices[v2]->vecinos.push_back(arista);
  }

  return vertices;
}

// Algoritmo de Kruskal
vector<Arista> kruskal(vector<Vertice *> vertices) {
  // Crea un conjunto para cada vértice
  vector<set<int>> conjuntos(vertices.size());
  for (int i = 0; i < vertices.size(); i++) {
    conjuntos[i].insert(i);
  }

  // Ordena las aristas por peso
  vector<Arista> aristas = vector<Arista>();
  for (Vertice *vertice : vertices) {
    for (Arista arista : vertice->vecinos) {
      aristas.push_back(arista);
    }
  }
  sort(aristas.begin(), aristas.end(), [](Arista a, Arista b) {
    return a.peso < b.peso;
  });

  // Agrega las aristas al árbol de expansión mínima
  vector<Arista> arbol;
  for (Arista arista : aristas) {
    int u = arista.u;
    int v = arista.v;

    // Verifica que los vértices u y v no pertenezcan al mismo conjunto
    if (conjuntos[u] != conjuntos[v]) {
      // Agrega la arista al árbol de expansión mínima
      arbol.push_back(arista);

      // Combina los conjuntos de u y v
      set_union(conjuntos[u].begin(), conjuntos[u].end(),
                conjuntos[v].begin(), conjuntos[v].end(),
                inserter(conjuntos[u], conjuntos[u].end()));
      conjuntos[v].clear();
    }
  }

  return arbol;
}

int main() {
  // Crea un grafo aleatorio con 10 vértices y 20 aristas.
  vector<Vertice *> vertices = generarGrafoAleatorio(4, 8);


   //make this for (Vertice *vertice : vertices) {
    for (Vertice *vertice : vertices) {
        for (Arista arista : vertice->vecinos) { 
        cout << vertice->etiqueta << " - " << arista.v << " (peso: " << arista.peso
            << ")" << endl;
        }
    } 

    // Ejecuta el algoritmo de Kruskal


  vector<Arista> arbol = kruskal(vertices);
    // Imprime el árbol de expansión mínima
    for (Arista arista : arbol) {
        cout << arista.u << " " << arista.v << " " << arista.peso << endl;
        }

  return 0;
}