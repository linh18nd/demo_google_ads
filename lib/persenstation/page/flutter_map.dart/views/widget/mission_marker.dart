import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MissionMarker extends StatelessWidget {
  final Function() onTap;
  final bool isShow;
  final String distance;
  const MissionMarker(
      {super.key,
      this.distance = '',
      required this.onTap,
      this.isShow = false});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Chỉ cho phép chế độ portrait
    ]);

    double rotation = 0.0;
    switch (MediaQuery.of(context).orientation) {
      case Orientation.portrait:
        rotation = isDarkMode ? 0.0 : 90.0;
        break;
      case Orientation.landscape:
        rotation = 180.0;
        break;
      case Orientation.portrait:
        rotation = 270.0;
        break;
      default:
        rotation = 0.0;
    }

    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: rotation * 3.14159 / 180,
        child: Stack(
          children: [
            isShow
                ? Transform.translate(
                    offset: const Offset(-25, -25),
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            distance,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  )
                : Container(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              top: 0,
              child: Icon(
                Icons.circle_rounded,
                color: isShow ? Colors.purple : Colors.orange,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
