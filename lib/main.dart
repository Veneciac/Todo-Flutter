import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
} 

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  // List<Todo> todos = [
  //   Todo(title: 'HAHAHA'),
  //   Todo(title: 'HIHIHI'),
  //   Todo(title: 'HEHEHE'),
  // ];

  List<Todo> todos = [];

  TextEditingController controller = new TextEditingController();

  _toggleTodo(Todo todo, bool isChecked) {

    print('${todo.title} ${todo.isDone}');

    todo.isDone = isChecked;

    setState(() {
      todo.isDone = isChecked;
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];

    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        _toggleTodo(todo, isChecked);
      }
    );
  }

   _addTodo() {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text('New todo'),
           content: TextField(
             controller: controller,
             autofocus: true,
           ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  print(controller.value.text);
                  setState(() {
                    final todo = new Todo(title: controller.value.text);
 
                    todos.add(todo);
                    controller.clear();
 
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
         );
       },
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      )
    );
  }
}

class Todo {
  Todo({this.title, this.isDone = false});

  String title;
  bool isDone;
}
