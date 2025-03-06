import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:helperconffeti/card_colors/card_color_model.dart';
import 'package:helperconffeti/card_colors/card_colors.dart';
import 'package:helperconffeti/enums/confetti_enums.dart';
import 'package:helperconffeti/helpers/confetti_helper.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confetti Example',
      home: Scaffold(
        body: ConfettiTestPage(),
      ),
    );
  }
}

class ConfettiTestPage extends StatelessWidget {
  const ConfettiTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confetti Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Panggil dialog confetti:
            await ConfettiHelper.showConfettiDialog(
                context: context,
                confettiType: ConfettiType.celebration,
                confettiStyle: ConfettiStyle.star,
                animationStyle: AnimationConfetti.falling,
                useController: false, // pakai internal controller
                durationInSeconds: 3,
                colorTheme: ConfettiColorTheme.purple,
                density: ConfettiDensity.low,
                message: "Selamat! 🎉",
                isColorMixedFromModel: true);
          },
          child: const Text('Show Confetti'),
        ),
      ),
    );
  }
}
