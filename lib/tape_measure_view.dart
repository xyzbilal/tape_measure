import 'package:flutter/material.dart';

import 'tape_measure_painter.dart';

class TapeMeausureView extends StatefulWidget {
  const TapeMeausureView({super.key});

  @override
  State<TapeMeausureView> createState() => _TapeMeausureViewState();
}

class _TapeMeausureViewState extends State<TapeMeausureView> {
  late double value;
  late double min;
  late double max;
  late double step;
  late String unit;

  @override
  void initState() {
    super.initState();
    value = 0;
    min = 0;
    max = 100;
    step = 1;
    unit = "cm";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              value = value - details.delta.dx;
              if (value < min) {
                value = min;
              }
              if (value > max) {
                value = max;
              }
            });
          },
          child: Center(
            child: SizedBox(
              height: 100,
              width: 300,
              child: CustomPaint(
                painter: TapeMeasurePainter(value, min, max, step, unit),
                child: Container(),
              ),
            ),
          ),
        ));
  }
}
