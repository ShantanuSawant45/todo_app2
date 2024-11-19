import 'package:flutter/material.dart';
import 'feature_screens/BudgetTracker_screen.dart';
import 'feature_screens/HealthTracker_screen.dart';
import 'feature_screens/Periodtracker.dart';
import 'feature_screens/Todo_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/todo-list': (context) => const  TodoScreen(),
        '/period-tracker': (context) => const Periodtracker(),
        '/health-tracker': (context) => const HealthtrackerScreen(),
        '/budget-tracker': (context) => const BudgettrackerScreen (),
      },
      home: const SplashScreen(), // The initial screen of the app
    );
  }
}
