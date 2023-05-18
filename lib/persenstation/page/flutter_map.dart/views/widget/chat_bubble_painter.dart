import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final double containerSize;
  final Color containerColor;

  const ChatBubble(
      {super.key, required this.containerSize, required this.containerColor});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _RoundedBottomClipper(),
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _RoundedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(_RoundedBottomClipper oldClipper) => false;
}
