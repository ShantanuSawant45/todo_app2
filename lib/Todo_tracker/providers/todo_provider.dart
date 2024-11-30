import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/todo.dart';

class TodoProvider with ChangeNotifier {
  final Box<Todo> _todoBox;
  List<Todo> _todos = [];

  TodoProvider(this._todoBox) {
    _loadTodos();
  }

  List<Todo> get todos => _todos;
  List<Todo> get completedTodos =>
      _todos.where((todo) => todo.isCompleted).toList();
  List<Todo> get pendingTodos =>
      _todos.where((todo) => !todo.isCompleted).toList();

  void _loadTodos() {
    _todos = _todoBox.values.toList();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
    _loadTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
    _loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await _todoBox.delete(id);
    _loadTodos();
  }

  Future<void> toggleTodoStatus(String id) async {
    final todo = _todoBox.get(id);
    if (todo != null) {
      todo.isCompleted = !todo.isCompleted;
      await _todoBox.put(id, todo);
      _loadTodos();
    }
  }
}
