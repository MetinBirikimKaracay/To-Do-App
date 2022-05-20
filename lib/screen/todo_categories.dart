import 'package:flutter/material.dart';
import 'package:to_do_app/services/todo_service.dart';
import '../model/todo.dart';

class TodoCategories extends StatefulWidget {
  //const TodoCategories({Key? key}) : super(key: key);
  final String category;
  String? header;

  TodoCategories({required this.category});

  @override
  State<TodoCategories> createState() => _TodoCategoriesState();
}

class _TodoCategoriesState extends State<TodoCategories> {

  List<Todo> _todoList = <Todo>[];
  TodoService _todoService = TodoService();

  @override
  void initState(){
    super.initState();
    getTodoCategories();
  }

  getTodoCategories() async{
    var todos = await _todoService.readTodosByCategory(this.widget.category);
    todos.forEach((todo){
      setState(() {
        var model = Todo();
        model.title = todo["title"];
        model.description = todo["description"];
        model.todoDate = todo["todoDate"];

        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(this.widget.category)
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context,index) {
                    return Card(
                      elevation: 8,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(_todoList[index].title ?? "Baslik Yok")
                          ],
                        ),
                        subtitle: Text(_todoList[index].description ?? "Aciklama Yok"),
                        trailing: Text(_todoList[index].todoDate ?? "Tarih Yok"),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
