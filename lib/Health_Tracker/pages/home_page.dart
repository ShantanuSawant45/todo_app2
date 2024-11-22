import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app2/Health_Tracker/pages/profile_page.dart';
import 'package:todo_app2/Health_Tracker/pages/workout_page.dart';



import 'dashboard_page.dart';
import 'hydration_page.dart';


class HomePage_healthTracker extends ConsumerStatefulWidget {
  const HomePage_healthTracker({super.key});

  @override
  ConsumerState<HomePage_healthTracker> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage_healthTracker> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const WorkoutPage(),
    const HydrationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          NavigationDestination(
            icon: Icon(Icons.water_drop),
            label: 'Hydration',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
