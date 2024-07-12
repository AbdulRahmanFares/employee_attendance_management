import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  final String emplId;

  const Confirmation({
    required this.emplId,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        body: Center(
          child: Image.asset(
            "assets/images/tick.png",
            height: 100
          )
        )
      )
    );
  }
}

