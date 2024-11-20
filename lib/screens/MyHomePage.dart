import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<FeatureCard> _features = [
    FeatureCard(
      title: 'Period Tracker',
      icon: Icons.calendar_today,
      color: Colors.pink.shade400,
      description: 'Track your menstrual cycle and get predictions',
      route: '/period-tracker',
    ),
    FeatureCard(
      title: 'Health Tracker',
      icon: Icons.favorite,
      color: Colors.green.shade400,
      description: 'Monitor your health metrics and activities',
      route: '/health-tracker',
    ),
    FeatureCard(
      title: 'To-Do List',
      icon: Icons.check_circle,
      color: Colors.blue.shade400,
      description: 'Manage your tasks and stay organized',
      route: '/todo-list',
    ),
    FeatureCard(
      title: 'Budget Tracker',
      icon: Icons.account_balance_wallet,
      color: Colors.purple.shade400,
      description: 'Track your expenses and manage budget',
      route: '/budget-tracker',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose a feature to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: _features.length,
                  itemBuilder: (context, index) {
                    return _buildFeatureCard(_features[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(FeatureCard feature) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, feature.route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: feature.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                feature.icon,
                size: 32,
                color: feature.color,
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              feature.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                feature.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FeatureCard {
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final String route;

  FeatureCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.route,
  });
}
