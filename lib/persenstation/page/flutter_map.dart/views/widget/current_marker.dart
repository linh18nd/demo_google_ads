import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CurrentMarker extends StatefulWidget {
  const CurrentMarker({super.key});

  @override
  _RotatingWidgetState createState() => _RotatingWidgetState();
}

class _RotatingWidgetState extends State<CurrentMarker> {
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    // accelerometerEvents.listen((AccelerometerEvent event) {
    //   // setState(() {
    //   double x = event.x;
    //   double y = event.y;

    //   // Tính góc xoay
    //   double rotation = math.atan2(y, x);

    //   // Chuyển đổi từ radian sang độ
    //   _rotation = rotation * 180 / math.pi;
    //   log('x: $x, y: $y, ');
    // });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerEvents.drain();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: _rotation,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
          ),
          child: const CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(
              'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2020/8/21/829850/Bat-Cuoi-Truoc-Nhung-07.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
