// ignore_for_file: file_names

class ConjuntoDisjunto {
  Map<int, Set<int>> conjuntos = <int, Set<int>>{};

  void crearConjunto(int id) {
    conjuntos[id] = {id};
  }

  void unirConjuntos(int id1, int id2) {
    conjuntos[id1]!.addAll(conjuntos[id2]!);
    for (var element in conjuntos[id2]!) {
      conjuntos[element] = conjuntos[id1]!;
    }
  }

  bool estanEnElMismoConjunto(int id1, int id2) {
    return conjuntos[id1] == conjuntos[id2];
  }
}
