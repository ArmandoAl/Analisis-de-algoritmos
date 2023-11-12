// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:grafos/Models/Dimensions.dart';

WindowDimensions generateDimensions(BuildContext context) {
  final double xi = MediaQuery.of(context).size.width * 0.03;
  final double yi = MediaQuery.of(context).size.height * 0.03;
  final double xf = (MediaQuery.of(context).size.width / 5) * 3.5;
  final double yf = MediaQuery.of(context).size.height * 0.85;
  const Color color = Colors.deepPurple;
  return WindowDimensions(color, xi: xi, yi: yi, xf: xf, yf: yf);
}
