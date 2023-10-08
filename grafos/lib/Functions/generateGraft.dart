// ignore_for_file: avoid_print, file_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grafos/Functions/kruskal.dart';

import '../Models/Aresta.dart';
import '../Models/Grafo.dart';
import '../Models/Vertice.dart';

Grafo generarGrafoAleatorio(int n, double p, BuildContext context) {
  Grafo grafo = Grafo();
  grafo.vertices = [];
  grafo.arestas = [];
  for (int i = 0; i < n; i++) {
    Vertice vertice = Vertice();
    vertice.id = i;
    vertice.posX =
        Random().nextInt(MediaQuery.of(context).size.width.toInt()).toDouble() *
            0.6;
    vertice.posY = Random()
            .nextInt(MediaQuery.of(context).size.height.toInt())
            .toDouble() *
        0.6;
    grafo.vertices!.add(vertice);
  }
  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      Random random = Random();
      double probabilidad = random.nextDouble();
      if (probabilidad < p) {
        Aresta aresta = Aresta();
        aresta.id = grafo.arestas!.length;
        aresta.origem = grafo.vertices![i];
        aresta.destino = grafo.vertices![j];
        aresta.peso = random.nextInt(100);
        grafo.arestas!.add(aresta);
      }
    }
  }

  //impime el grafo con este formato
  // 0 - 3 (peso: 96)
  // 1 - 2 (peso: 46)

  for (int i = 0; i < grafo.arestas!.length; i++) {
    print(
        "${grafo.arestas![i].origem!.id} - ${grafo.arestas![i].destino!.id} (peso: ${grafo.arestas![i].peso})");
  }

  kruskal(grafo);

  return grafo;
}
