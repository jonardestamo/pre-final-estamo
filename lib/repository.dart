import 'model.dart';

abstract class Repository {
  Future<List<TodoModel>> getTodoList();
  Future<List<TodoModel>> getOneTodo();
}
