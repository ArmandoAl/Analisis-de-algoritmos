// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'Functions/generateGraft.dart';
import 'Models/Grafo.dart';
import 'Widgets/GrafoPainter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ilustracion de un grafo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Grafo? grafo;
  @override
  Widget build(BuildContext context) {
    grafo ??= generarGrafoAleatorio(5, 0.5, context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(widget.title),
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: const EdgeInsets.all(100),
              child: CustomPaint(
                painter: GrafoPainter(grafo: grafo),
              ),
            )));
  }
}
