import 'model.dart';
import 'repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository implements Repository {
  String dataURL = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<TodoModel>> getTodoList() async {
    List<TodoModel> todoList = [];
    //https://jsonplaceholder.typicode.com/todos
    var url = Uri.parse('$dataURL/todos');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      todoList.add(TodoModel.fromJson(body[i]));
    }
    return todoList;
  }
  Future<List<TodoModel>> getOneTodo() async {
    List<TodoModel> todoList = [];
    //https://jsonplaceholder.typicode.com/todos
    var url = Uri.parse('$dataURL/todos');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    for (var i = 0; i < 1; i++) {
      todoList.add(TodoModel.fromJson(body[i]));
    }
    return todoList;
  }

}