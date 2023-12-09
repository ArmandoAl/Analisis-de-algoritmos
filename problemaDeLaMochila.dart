int mochila(
    int capacidad, List<int> pesos, List<int> valores, int numeroElementos) {
  // Crear una matriz para almacenar resultados intermedios
  List<List<int>> matriz = List.generate(
      numeroElementos + 1, (_) => List<int>.filled(capacidad + 1, 0));

  // Llenar la matriz utilizando programación dinámica
  for (int i = 1; i <= numeroElementos; i++) {
    for (int j = 0; j <= capacidad; j++) {
      if (pesos[i - 1] <= j) {
        matriz[i][j] = matriz[i - 1][j].compareTo(
                    matriz[i - 1][j - pesos[i - 1]] + valores[i - 1]) >
                0
            ? matriz[i - 1][j]
            : matriz[i - 1][j - pesos[i - 1]] + valores[i - 1];
      } else {
        matriz[i][j] = matriz[i - 1][j];
      }
    }
  }

  // Recuperar la solución óptima
  int resultado = matriz[numeroElementos][capacidad];
  int pesoActual = capacidad;
  List<int> elementosSeleccionados = [];

  for (int i = numeroElementos; i > 0; i--) {
    if (resultado <= 0) {
      break;
    }
    if (resultado != matriz[i - 1][pesoActual]) {
      elementosSeleccionados.add(i - 1);
      resultado -= valores[i - 1];
      pesoActual -= pesos[i - 1];
    }
  }

  print("Elementos seleccionados: $elementosSeleccionados");

  return matriz[numeroElementos][capacidad];
}

void main() {
  int capacidadMochila = 10;
  List<int> pesos = [2, 3, 4, 5];
  List<int> valores = [3, 4, 5, 6];
  int numeroElementos = pesos.length;

  int resultadoOptimo =
      mochila(capacidadMochila, pesos, valores, numeroElementos);
  print("Valor máximo obtenido: $resultadoOptimo");
}
