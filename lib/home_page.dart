import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pre_final/todo_controller.dart';
import 'package:pre_final/todo_repository.dart';

import 'model.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

class _HomePageState extends State<HomePage> {
  List mapResponse = <dynamic>[];
  dynamic add;
  TodoModel? todo;
  var todoController = TodoController(TodoRepository());
  getTodo() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body) as List<dynamic>;
      });
    } else {
      return null;
    }
  }
  @override
  void initState() {
    getTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('ToDo'),
        ),
      ),
      body: FutureBuilder(
        future: todoController.fetchTodoList(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black12,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) =>
                        AlertDialog(
                            title: Text('Title: ${snapshot.data[index].title}'),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('User Id: ${snapshot.data[index].userId}'),
                                Text('Status: ${snapshot.data[index].completed}'),
                              ],
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Okay'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ]
                        ),
                  );
                },
                  leading: Text(
                    " ${snapshot.data[index].id}",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  title: Text(
                      "Title: ${snapshot.data[index].title} ${snapshot.data[index].id}"),
                  subtitle: Text('Status: ${snapshot.data[index].completed}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
