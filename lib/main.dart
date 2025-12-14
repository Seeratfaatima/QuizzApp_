import 'package:flutter/material.dart';
import 'src/views/screens/splash_screen.dart'; // Ensure this file exists
import 'src/views/screens/login.dart';  // Ensure this file exists

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzy App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'Inter',
      ),
      // We set the SplashScreen as the home.
      // We pass the LoginScreen as the child, so the splash knows where to go next.
      home: const SplashScreen(
        child: LoginScreen(),
      ),
    );
  }
}