import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_health_data.dart';
import 'notifiers/health_notifiers.dart';


final healthDataProvider =
    StateNotifierProvider<HealthDataNotifier, UserHealthData?>((ref) {
  return HealthDataNotifier();
});

final stepCountProvider = StateNotifierProvider<StepCountNotifier, int>((ref) {
  return StepCountNotifier();
});

final hydrationProvider = StateNotifierProvider<HydrationNotifier, int>((ref) {
  return HydrationNotifier();
});

final exercisesProvider = Provider<List<Exercise>>((ref) {
  return [
    Exercise(
      name: 'Push-ups',
      description: 'Basic upper body exercise',
      durationInSeconds: 60,
      animationPath: 'assets/animations/pushup.json',
    ),
    Exercise(
      name: 'Squats',
      description: 'Lower body strength exercise',
      durationInSeconds: 60,
      animationPath: 'assets/animations/squat.json',
    ),
    // Add more exercises
  ];
});
