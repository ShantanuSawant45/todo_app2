import 'package:hive/hive.dart';
@HiveType(typeId: 0)
class UserHealthData extends HiveObject {
  @HiveField(0)
  final double height;

  @HiveField(1)
  final double weight;

  @HiveField(2)
  final int dailyStepGoal;

  @HiveField(3)
  final int dailyWaterGoal;

  UserHealthData({
    required this.height,
    required this.weight,
    this.dailyStepGoal = 10000,
    this.dailyWaterGoal = 8,
  });

  double get bmi => weight / ((height / 100) * (height / 100));
}

@HiveType(typeId: 1)
class Exercise extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final int durationInSeconds;

  @HiveField(3)
  final String animationPath;

  Exercise({
    required this.name,
    required this.description,
    required this.durationInSeconds,
    required this.animationPath,
  });
}
