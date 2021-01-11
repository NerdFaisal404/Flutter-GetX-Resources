import 'package:flutter/material.dart';
import 'package:food_cafe/resource/colors.dart';

class FancyBackground extends StatelessWidget {
  final Widget child;
  final Color color;

  FancyBackground({this.child, this.color: Colors.white});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: LoginPainter(color), child: child);
  }
}

class LoginPainter extends CustomPainter {
  final Color color;
  LoginPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final sw = size.width;
    final sh = size.height;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = color;
    canvas.drawPath(mainBackground, paint);

    Path yellowWave = Path();
    yellowWave.lineTo(sw * 0.7, 0);
    yellowWave.cubicTo(
        sw * 0.6, sh * 0.05, sw * 0.27, sh * 0.01, sw * 0.18, sh * 0.12);
    yellowWave.quadraticBezierTo(sw * 0.12, sh * 0.2, 0, sh * 0.2);
    yellowWave.close();
    paint.color = appBarTitleColor;
    canvas.drawPath(yellowWave, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
