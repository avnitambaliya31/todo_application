import 'package:todo_application/features/presentation/model/api_models/api_response.dart';
import 'package:todo_application/features/presentation/model/todo_model/delete_todo_model.dart';
import 'package:todo_application/features/presentation/model/todo_model/todo_list_model.dart';

abstract class TodoRepository {
  Future<ApiResponse<TodoListModel>> getTodoListAPI();
  Future<ApiResponse<DeleteTodoModel>> addTodoAPI(Map<String, dynamic> data);
  Future<ApiResponse<DeleteTodoModel>> updateTodoAPI(Map<String, dynamic> data);
  Future<ApiResponse<DeleteTodoModel>> deleteTodoAPI(int id);
}
