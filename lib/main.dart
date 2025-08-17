import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const SuriApp());
}

class SuriApp extends StatelessWidget {
  const SuriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '수리모아',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2600FF)),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
