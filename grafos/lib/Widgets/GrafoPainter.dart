// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../Models/Grafo.dart';

class GrafoPainter extends CustomPainter {
  Grafo? grafo;
  GrafoPainter({this.grafo});

  @override
  void paint(Canvas canvas, Size size) {
    //Dibuja las aristas.
    for (int i = 0; i < grafo!.arestas!.length; i++) {
      canvas.drawLine(
          Offset(grafo!.arestas![i].origem!.posX!.toDouble(),
              grafo!.arestas![i].origem!.posY!.toDouble()),
          Offset(grafo!.arestas![i].destino!.posX!.toDouble(),
              grafo!.arestas![i].destino!.posY!.toDouble()),
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2.0);
    }

    // Dibuja los círculos de los vértices.
    for (int i = 0; i < grafo!.vertices!.length; i++) {
      canvas.drawCircle(
        Offset(grafo!.vertices![i].posX!.toDouble(),
            grafo!.vertices![i].posY!.toDouble()),
        20,
        Paint()..color = Colors.red,
      );

      // Agrega el ID del vértice al círculo.
      // Verificación if
      if (grafo != null &&
          grafo!.vertices != null &&
          i < grafo!.vertices!.length) {
        final textSpan = TextSpan(
          text: grafo!.vertices![i].id!.toString(),
          style: const TextStyle(
              color: Color.fromARGB(255, 77, 9, 9), fontSize: 22),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            grafo!.vertices![i].posX!.toDouble() - 7,
            grafo!.vertices![i].posY!.toDouble() - 12,
          ),
        );
      }
    }

    // Dibuja los pesos de las aristas.
    for (int i = 0; i < grafo!.arestas!.length; i++) {
      // Verificación if
      if (grafo != null &&
          grafo!.arestas != null &&
          i < grafo!.arestas!.length) {
        final textSpan = TextSpan(
          text: grafo!.arestas![i].peso!.toString(),
          style: const TextStyle(
              color: Color.fromARGB(255, 77, 9, 9), fontSize: 22),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            ((grafo!.arestas![i].origem!.posX!.toDouble() +
                        grafo!.arestas![i].destino!.posX!.toDouble()) /
                    2) +
                3,
            ((grafo!.arestas![i].origem!.posY!.toDouble() +
                        grafo!.arestas![i].destino!.posY!.toDouble()) /
                    2) +
                5,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
