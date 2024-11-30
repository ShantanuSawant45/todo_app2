import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';
import 'add_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final todos = _selectedIndex == 0
            ? todoProvider.pendingTodos
            : todoProvider.completedTodos;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
          ),
          body: Column(
            children: [
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Pending'),
                    icon: Icon(Icons.pending_actions),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Completed'),
                    icon: Icon(Icons.task_alt),
                  ),
                ],
                selected: {_selectedIndex},
                onSelectionChanged: (Set<int> newSelection) {
                  setState(() {
                    _selectedIndex = newSelection.first;
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return TodoItem(todo: todos[index]);
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
