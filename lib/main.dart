
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app2/screens/splash_screen.dart';
import 'package:todo_app2/screens_budgettracker/budget_tracker.dart';
import 'feature_screens/HealthTracker_screen.dart';
import 'feature_screens/Periodtracker.dart';
import 'feature_screens/Todo_screen.dart';
import 'providers/transaction_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionProvider(),
      child: MaterialApp(
        title: 'Budget Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/todo-list': (context) => const  TodoScreen(),
          '/period-tracker': (context) => const Periodtracker(),
          '/health-tracker': (context) => const HealthtrackerScreen(),
          '/budget-tracker': (context) => const Budget_tracker_screen(),
        },
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
