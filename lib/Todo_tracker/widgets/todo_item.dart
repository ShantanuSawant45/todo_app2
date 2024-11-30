import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<TodoProvider>().deleteTodo(todo.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              context.read<TodoProvider>().toggleTodoStatus(todo.id);
            },
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (todo.description.isNotEmpty) Text(todo.description),
              if (todo.dueDate != null)
                Text(
                  'Due: ${todo.dueDate.toString().split(' ')[0]}',
                  style: TextStyle(
                    color: todo.dueDate!.isBefore(DateTime.now())
                        ? Colors.red
                        : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
