import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

final todos = List<Todo>.generate(
  20, 
  (i) => Todo(
    "Todo $i",
    "This index of $i 's description!"
  )
);

class TodoList extends StatelessWidget{
  static const routeName = "/todoList";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TodoList")
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailScreen(),
                settings: RouteSettings(
                  arguments: todos[index]
                )
              ));
            },
          );
        })
    );
  }
}

class DetailScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title)
      ),
      body: Center(
        child: Text(
          todo.description,
          style: TextStyle(
            fontSize: 18.0
          ),
        ),
      ),
    );
  }
}