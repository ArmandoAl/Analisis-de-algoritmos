// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grafos/Functions/dijkstra.dart';
import 'package:grafos/Functions/generateDimensions.dart';
import 'package:grafos/Functions/generateGrapt.dart';
import 'package:grafos/Functions/kruskal.dart';
import 'package:grafos/Functions/prim.dart';
import 'package:grafos/Models/Dimensions.dart';
import 'package:grafos/Models/Grafo.dart';
import 'package:grafos/Models/Vertice.dart';
import 'package:grafos/Pseudocode/dijkstraCode.dart';
import 'package:grafos/Pseudocode/kruskalCode.dart';
import 'package:grafos/Pseudocode/primCode.dart';
import 'package:grafos/Widgets/GrafoPainter.dart';
import 'package:grafos/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  WindowDimensions? windowDimensions;
  bool isInitialized = false;
  bool isGenerated = false;
  bool isDijkstra = false;
  bool isTree = false;
  TextEditingController verticesController = TextEditingController();
  TextEditingController probabilidadController = TextEditingController();
  TextEditingController pseudocodigoController = TextEditingController();
  String text = 'Inicialice el grafo';
  Map<Vertice, Vertice> a = {};

  @override
  Widget build(BuildContext context) {
    windowDimensions ??= generateDimensions(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 175, 173, 179),
          title: Text(widget.title),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 57, 59, 61),
          child: Stack(
            children: [
              isInitialized
                  ? CustomPaint(
                      painter: GrafoPainter(grafo: grafo),
                      child: Container(),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: Text(
                          text,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 48),
                        ),
                      ),
                    ),
              _positionedWidget(),
            ],
          ),
        ));
  }

  Widget _positionedWidget() {
    return Positioned(
        top: 20,
        right: 20,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width / 4,
              padding: const EdgeInsets.all(10),
              child: isTree == true
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isTree = false;
                          isGenerated = false;
                          pseudocodigoController.clear();
                          isInitialized = false;
                        });
                      },
                      child: const Text('Generar otro grafo',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    )
                  : isGenerated == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  grafo = prim(grafo!);
                                  isGenerated = false;
                                  isTree = true;
                                  pseudocodigoController.text = PrimCode().text;
                                });
                              },
                              child: const Text('Prim',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  grafo = kruskal(grafo!);
                                  isTree = true;
                                  isGenerated = false;
                                  pseudocodigoController.text =
                                      KruscalCode().text;
                                });
                              },
                              child: const Text('Kruskal',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  grafo = dijkstra(grafo!, grafo!.vertices![0]);
                                  //imprimir el mapa
                                  isGenerated = false;
                                  isTree = true;
                                  pseudocodigoController.text =
                                      DijkstraCode().text;
                                });
                              },
                              child: const Text('Dijkstra',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 9,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Numero de vertices',
                                    ),
                                    controller: verticesController,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 9,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Probabilidad de aristas',
                                    ),
                                    controller: probabilidadController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (verticesController.text == "" ||
                                      probabilidadController.text == "") {
                                    setState(() {
                                      text = 'Ingrese los datos';
                                    });
                                  } else {
                                    if (validarVertices(
                                            verticesController.text) ==
                                        false) {
                                      setState(() {
                                        text =
                                            'Ingrese un numero de vertices valido';
                                      });
                                      return;
                                    }
                                    if (validarProbabilidad(
                                            probabilidadController.text) ==
                                        false) {
                                      setState(() {
                                        text =
                                            'Ingrese una probabilidad valida. Ej: 0.5';
                                      });
                                      return;
                                    }

                                    setState(() {
                                      grafo = generarGrafoAleatorio(
                                          int.parse(verticesController.text),
                                          double.parse(
                                              probabilidadController.text),
                                          context,
                                          windowDimensions!);

                                      isGenerated = true;
                                      text = 'Generar grafo';
                                    });
                                    verticesController.clear();
                                    probabilidadController.clear();
                                    if (isInitialized == false) {
                                      setState(() {
                                        isInitialized = true;
                                      });
                                    }
                                  }
                                },
                                child: const Text(
                                  'Generar grafo',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ))
                          ],
                        ),
            ),
            const SizedBox(
              height: 30,
            ),
            isTree
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: pseudocodigoController,
                      readOnly: true,
                      maxLines: null,
                    ),
                  )
                : Container(),
          ],
        ));
  }
}

bool validarVertices(String text) {
  try {
    int.parse(text);
    return true;
  } catch (e) {
    return false;
  }
}

bool validarProbabilidad(String text) {
  //solo pueden ingresar numeros entre 0.1 y 1
  try {
    double probabilidad = double.parse(text);
    if (probabilidad >= 0.1 && probabilidad <= 1) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
