import 'dart:math';

import 'package:cos_challenge/snippet.dart';

class VinGenerator {
  static const String _allowedChars = 'ABCDEFGHJKLMNPRSTUVWXYZ0123456789';

  static String generate() {
    final random = Random();
    final buffer = StringBuffer();

    for (var i = 0; i < CosChallenge.vinLength; i++) {
      final index = random.nextInt(_allowedChars.length);
      buffer.write(_allowedChars[index]);
    }

    return buffer.toString();
  }
}
