import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.color = const Color(0xFF3F7DB2),
    this.size = 60.0,
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: color,
      size: size,
    );
  }
}
