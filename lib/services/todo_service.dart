import 'package:to_do_app/repositories/repository.dart';
import 'package:to_do_app/model/todo.dart';

class TodoService{
  Repository? _repository;

  TodoService(){
    _repository = Repository();
  }

  saveTodo(Todo todo) async{
    return await _repository?.insertData("todos", todo.todoMapp());
  }

  readTodos() async {
    return await _repository?.readData("todos");
  }

  readTodosByCategory(category) async{
    return await _repository?.readDataByColumnName("todos", "category", category);
  }
}