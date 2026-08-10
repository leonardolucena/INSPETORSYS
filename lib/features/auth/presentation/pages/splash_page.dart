import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
