import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webspark_test_task/presentation/pages/home_screen.dart';
import 'data/data_sources/local/preferences_helper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesHelper.instance.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
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