import 'package:flutter/material.dart';

class CosProgress extends StatelessWidget {
  const CosProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: const CircularProgressIndicator(color: Colors.white),
    );
  }
}
