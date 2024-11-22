import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../providers/health_providers.dart';
import '../widgets/exercise_timer.dart';

class WorkoutPage extends ConsumerWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exercisesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(exercise.name),
              subtitle: Text(exercise.description),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Lottie.asset(
                          exercise.animationPath,
                          repeat: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ExerciseTimer(
                        duration: Duration(seconds: exercise.durationInSeconds),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
