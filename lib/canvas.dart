import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class DrawingCanvas extends StatelessWidget {
  const DrawingCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotPainter = Paint()
      ..color = const Color.fromARGB(255, 36, 128, 39)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    //plotting the fern
    Random random = Random();
    double x = 0;
    double y = 0;
    const randomPoints = PointMode.points;
    final randomPointsCoordinates = [
      Offset(x, y),
    ];
    for (var i = 0; i <= 100000; i++) {
      int probabilty = random.nextInt(100);
      //play with all numbers to change the drawing
      double scaleX = size.width * 0.15; //scale in x axis
      double scaleY = size.height * 0.092; //scale in y axis
      double translateX = size.width / 2; //translate in x axis
      double translateY = size.height * 0.95; //translate in y axis
      double customX =
          x * scaleX + translateX; //to implement x custom from above
      double customY =
          -y * scaleY + translateY; //to implement y custom from above
      randomPointsCoordinates.add(Offset(customX, customY));
      if (probabilty < 1) {
        //draws stem
        x = 0;
        y = 0.17 * y;
      } else if (probabilty < 86) {
        //draws successively smaller leaflets
        x = 0.85 * x + 0.04 * y;
        y = -0.04 * x + 0.85 * y + 1.6;
      } else if (probabilty < 93) {
        //draws largest left leaflet
        x = 0.2 * x - 0.26 * y;
        y = 0.23 * x + 0.22 * y + 1.6;
      } else {
        //draws largest right leaflet
        x = -0.15 * x + 0.28 * y;
        y = 0.26 * x + 0.24 * y + 0.44;
      }
    }
    canvas.drawPoints(randomPoints, randomPointsCoordinates, dotPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
