import 'package:flutter/material.dart';

class NavigationDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationDemo(
      todos: List.generate(
          20,
          (index) =>
              Todo(title: "todo $index", description: "description $index")),
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo({required this.title, required this.description});
}

class NavigationDemo extends StatelessWidget {
  NavigationDemo({super.key, required this.todos});

  final List<Todo> todos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation demo"),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(todos[index].title),
              onTap: () {
                // Way one

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             DetailScreen(todo: todos[index])));

                // Way two
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(),
                        settings: RouteSettings(arguments: todos[index])));
              },
            );
          }),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DetailsScreenApp();
  }
}

class DetailsScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Hero(
            tag: "details-tag",
            child: Text(
                (ModalRoute.of(context)!.settings.arguments as Todo).title)));
  }
}

class DetailsScreenAppGoRouter extends StatelessWidget {
  const DetailsScreenAppGoRouter({super.key, required this.todo});

  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(todo.title));
  }
}
