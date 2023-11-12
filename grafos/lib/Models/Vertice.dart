// ignore_for_file: file_names

class Vertice {
  int? id;
  double? posX;
  double? posY;
  Vertice? anterior;
  int? pesoActual;
  int? pesoPermanente;
  bool visitado = false;
  List<Vertice>? adjacentes = [];
  Vertice? siguiente;
  bool marcado = false;
}
