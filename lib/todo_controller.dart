import 'repository.dart';
import 'model.dart';
class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  Future<List<TodoModel>> fetchTodoList() async {
    return _repository.getTodoList();
  }
  Future<List<TodoModel>> fetchOneTodo() async {
    return _repository.getOneTodo();
  }

}