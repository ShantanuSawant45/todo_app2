import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_selectedDate == null
                  ? 'No due date'
                  : 'Due date: ${_selectedDate.toString().split(' ')[0]}'),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final todo = Todo(
                    id: DateTime.now().toString(),
                    title: _titleController.text,
                    description: _descriptionController.text,
                    dueDate: _selectedDate,
                  );
                  context.read<TodoProvider>().addTodo(todo);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
