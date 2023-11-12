// ignore_for_file: avoid_print, file_names
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grafos/Models/Dimensions.dart';
import '../Models/Arista.dart';
import '../Models/Grafo.dart';
import '../Models/Vertice.dart';

Grafo generarGrafoAleatorio(
    int n, double p, BuildContext context, WindowDimensions windowDimensions) {
  Grafo grafo = Grafo();
  grafo.vertices = [];
  grafo.arestas = [];

  //inicializa un vertice principal

  for (int i = 0; i < n; i++) {
    Vertice vertice = Vertice();
    vertice.id = i;

    // La posición del vértice se genera aleatoriamente pero debe estar dentro de los límites de la pantalla y no debe estar muy cerca de los bordes.
    // Debe de estar dentro de el rango entre windowDimensions.xi y windowDimensions.xf
    // Asegúrate de que los vértices estén a una distancia mínima entre sí
    bool posicionValida = false;
    while (!posicionValida) {
      vertice.posX = Random().nextInt(windowDimensions.xf.toInt()) +
          windowDimensions.xi.toInt().toDouble();
      vertice.posY = Random().nextInt(windowDimensions.yf.toInt()) +
          windowDimensions.yi.toInt().toDouble();

      posicionValida = true;
      for (Vertice v in grafo.vertices!) {
        double dx = v.posX! - vertice.posX!;
        double dy = v.posY! - vertice.posY!;
        double distancia = sqrt(dx * dx + dy * dy);

        if (distancia < 50.0) {
          // Cambia este valor según tus necesidades
          posicionValida = false;
          break;
        }
      }
    }

    grafo.vertices!.add(vertice);
  }

  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      Random random = Random();
      double probabilidad = random.nextDouble();
      if (probabilidad < p) {
        Arista aresta = Arista();
        aresta.origem = grafo.vertices![i];
        aresta.destino = grafo.vertices![j];
        aresta.peso = random.nextInt(100);
        grafo.arestas!.add(aresta);

        grafo.vertices![i].adjacentes!.add(grafo.vertices![j]);
        grafo.vertices![j].adjacentes!.add(grafo.vertices![i]);
      }
    }
  }

  Vertice verticePrincipal = Vertice();
  for (Vertice vertice in grafo.vertices!) {
    if (vertice.adjacentes!.length > 1) {
      verticePrincipal = grafo.vertices![grafo.vertices!.indexOf(vertice)];
      break;
    }
    //si no hay ningun vertice con mas de 1 adyacente, se toma el primer vertice como vertice principal
  }
  if (verticePrincipal.id == null) {
    verticePrincipal = grafo.vertices![0];
  }

  //si un vertice no tiene adyacentes, se le agrega el vertice principal
  for (Vertice vertice in grafo.vertices!) {
    if (vertice.adjacentes!.isEmpty) {
      vertice.adjacentes!.add(verticePrincipal);
      verticePrincipal.adjacentes!.add(vertice);
      Arista aresta = Arista();
      aresta.origem = vertice;
      aresta.destino = verticePrincipal;
      aresta.peso = Random().nextInt(100);
      grafo.arestas!.add(aresta);
    }
  }

  //ahora, checar que siempre haya una conexcion con el vertice principal, si no, agregarla, si hay una conexcion entre 2 y 4, pero ni 2 ni 4 tienen conexcion con el vertice principal, se agrega una arista entre 2 y 4 y se agrega una arista entre 2 y el vertice principal
  for (Vertice vertice in grafo.vertices!) {
    if (vertice.adjacentes!.isEmpty) {
      Arista aresta = Arista();
      aresta.origem = vertice;
      aresta.destino = verticePrincipal;
      aresta.peso = Random().nextInt(100);
      grafo.arestas!.add(aresta);
      vertice.adjacentes!.add(verticePrincipal);
      verticePrincipal.adjacentes!.add(vertice);
    }
  }

  // //ahora eliminar las aristas repetidas
  List<Arista> arestasRepetidas = [];
  for (int i = 0; i < grafo.arestas!.length; i++) {
    for (int j = i + 1; j < grafo.arestas!.length; j++) {
      if (grafo.arestas![i].origem == grafo.arestas![j].destino &&
          grafo.arestas![i].destino == grafo.arestas![j].origem) {
        if (!arestasRepetidas.contains(grafo.arestas![i])) {
          arestasRepetidas.add(grafo.arestas![i]);
        }
      }
    }
  }

  for (Arista aresta in arestasRepetidas) {
    //elimina solo la mitad de las aristas repetidas
    grafo.arestas!.remove(aresta);

    //elimina la arista repetida de los vertices
    aresta.origem!.adjacentes!.remove(aresta.destino);
    aresta.destino!.adjacentes!.remove(aresta.origem);
  }

  return grafo;
}
//0
