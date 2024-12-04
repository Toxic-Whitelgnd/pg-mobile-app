import 'package:flutter/material.dart';
import 'package:pgapp/di/locator.dart';
import 'package:pgapp/features/home/presentation/Home_page.dart';
import 'package:pgapp/services/MongoDB.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the DI
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// TODO: food menu, Github actions - sonarcloud connections
// TODO: GHEE MODIFICATIONS REQUIRED - TODAY NIGHT


