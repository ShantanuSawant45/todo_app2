import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/health_providers.dart';
import '../widgets/health_metric_card.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthData = ref.watch(healthDataProvider);
    final stepCount = ref.watch(stepCountProvider);
    final waterCount = ref.watch(hydrationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (healthData != null) ...[
              HealthMetricCard(
                title: 'BMI',
                value: healthData.bmi.toStringAsFixed(1),
                icon: Icons.monitor_weight,
              ),
              const SizedBox(height: 16),
            ],
            HealthMetricCard(
              title: 'Steps Today',
              value: stepCount.toString(),
              icon: Icons.directions_walk,
            ),
            const SizedBox(height: 16),
            HealthMetricCard(
              title: 'Water Intake',
              value: '$waterCount glasses',
              icon: Icons.water_drop,
            ),
          ],
        ),
      ),
    );
  }
}
