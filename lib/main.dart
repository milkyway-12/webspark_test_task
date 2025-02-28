import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webspark_test_task/presentation/pages/home_screen.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Цвет фона статус-бара
      statusBarIconBrightness: Brightness.light, // Цвет иконок (light — белые, dark — черные)
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WEBSPARK',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}