import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app2/screens/splash_screen.dart';
import 'Budget_tracker/providers/transaction_provider.dart';
import 'Budget_tracker/screens_budgettracker/budget_tracker.dart';
import 'Health_Tracker/pages/home_page.dart';
import 'Period_tracker/pages/home_page.dart';
import 'Period_tracker/providers/period_provider.dart';
import 'feature_screens/Todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('health_data');
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (_) => PeriodProvider(prefs),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => TransactionProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/todo-list': (context) => const TodoScreen(),
        '/period-tracker': (context) => const HomePage_PeriodTracker(),
        '/health-tracker': (context) => const HomePage_healthTracker(),
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
    );
  }
}
