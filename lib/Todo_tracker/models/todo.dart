import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime? dueDate;

  Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    DateTime? createdAt,
    this.dueDate,
  }) : createdAt = createdAt ?? DateTime.now();
}
