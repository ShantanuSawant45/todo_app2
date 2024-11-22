import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/health_providers.dart';

class HydrationPage extends ConsumerWidget {
  const HydrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterCount = ref.watch(hydrationProvider);
    final healthData = ref.watch(healthDataProvider);
    final goal = healthData?.dailyWaterGoal ?? 8;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydration Tracker'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(

            children: [
              Text(
                '$waterCount / $goal glasses',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 200,
                width: 200,
                child: CircularProgressIndicator(
                  value: waterCount / goal,
                  strokeWidth: 12,
                  backgroundColor: colorScheme.surfaceVariant,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(hydrationProvider.notifier).addWaterGlass();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Add Water Glass'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
