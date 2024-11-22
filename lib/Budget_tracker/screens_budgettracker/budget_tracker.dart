import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/balance_card.dart';
import '../widgets/recent_transactions.dart';
import 'add_transaction_screen.dart';
import 'analytics_screen.dart';


class Budget_tracker_screen extends StatefulWidget {
  const Budget_tracker_screen({super.key});

  @override
  State<Budget_tracker_screen> createState() => _Budget_tracker_screenState();
}

class _Budget_tracker_screenState extends State<Budget_tracker_screen> {
  int _currentIndex = 0;
  final _pages = const [
    _HomePage(),
    AnalyticsScreen(),
    Placeholder(), // Budget screen (to be implemented)
    Placeholder(), // Profile screen (to be implemented)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your Budget',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
              ],
            ),
          ),
          const BalanceCard(),
          const RecentTransactions(),
        ],
      ),
    );
  }
}
