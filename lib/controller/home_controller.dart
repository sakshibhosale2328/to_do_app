import 'package:get/get.dart';
import '../model/todo_model.dart';

class HomeController extends GetxController {
  var todos = <Todo>[].obs;
  var filteredTodos = <Todo>[].obs;
  int nextId = 1;

  @override
  void onInit() {
    super.onInit();
    filteredTodos.assignAll(todos);
    ever(todos, (_) => filteredTodos.assignAll(todos));
  }

  void addTodo(String title, String description) {
    todos.add(Todo(
      id: nextId++,
      title: title,
      description: description,
    ));
  }

  void updateTodo(int id, String title, String description) {
    final idx = todos.indexWhere((t) => t.id == id);
    if (idx != -1) {
      final old = todos[idx];
      todos[idx] = old.copyWith(title: title, description: description);
    }
  }

  void toggleDone(int id) {
    final idx = todos.indexWhere((t) => t.id == id);
    if (idx != -1) {
      final old = todos[idx];
      todos[idx] = old.copyWith(isDone: !old.isDone);
    }
  }

  void deleteTodo(int id) => todos.removeWhere((t) => t.id == id);

  void search(String q) {
    if (q.isEmpty) {
      filteredTodos.assignAll(todos);
    } else {
      filteredTodos.assignAll(
        todos.where((t) => t.title.toLowerCase().contains(q.toLowerCase())),
      );
    }
  }
}
