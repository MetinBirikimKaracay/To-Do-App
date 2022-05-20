import 'package:flutter/material.dart';
import 'package:to_do_app/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}
class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();
  DateTime selectedDay = DateTime.now();
  var _selectedValue;
  var _categories = <DropdownMenuItem>[];

  @override
  void initState(){
    super.initState();
    categoryReader();
  }

  categoryReader() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }


  selectDate(BuildContext context) async {
    var Date = await showDatePicker(
        context: context,
        initialDate: selectedDay,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if(Date != null){
      setState(() {
        selectedDay = Date;
        todoDateController.text = DateFormat('yyyy-MM-dd').format(Date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget> [
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Write Todo Title'
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Write Todo Description'
              ),
            ),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Pick a Date',
                  prefixIcon: InkWell(
                    onTap: () {
                      selectDate(context);
                    }, //ödevde doldurulacak
                    child: Icon(Icons.calendar_today),
                  )
              ),
            ),
            DropdownButtonFormField(
              items: _categories,
              value: _selectedValue,
              hint: Text('Category'),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async{
                var todoObject = Todo();

                todoObject.title = todoTitleController.text;
                todoObject.description = todoDescriptionController.text;
                todoObject.todoDate = todoDateController.text;
                todoObject.category = _selectedValue.toString();

                var _todoService = TodoService();
                var result = await _todoService.saveTodo(todoObject);

              },
              color: Colors.blue,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}