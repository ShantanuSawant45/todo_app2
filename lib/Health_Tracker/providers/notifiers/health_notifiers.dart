import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_health_data.dart';

class HealthDataNotifier extends StateNotifier<UserHealthData?> {
  HealthDataNotifier() : super(null);

  void updateHealthData(UserHealthData data) {
    state = data;
  }
}

class StepCountNotifier extends StateNotifier<int> {
  StepCountNotifier() : super(0);

  void updateStepCount(int steps) {
    state = steps;
  }
}

class HydrationNotifier extends StateNotifier<int> {
  HydrationNotifier() : super(0);

  void addWaterGlass() {
    state = state + 1;
  }

  void resetWaterCount() {
    state = 0;
  }
}
