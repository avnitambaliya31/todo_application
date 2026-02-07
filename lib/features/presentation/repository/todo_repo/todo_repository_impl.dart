import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_application/db/todo_local_service.dart';
import 'package:todo_application/features/api_client/api_base_helper.dart';
import 'package:todo_application/features/presentation/model/api_models/api_response.dart';
import 'package:todo_application/features/presentation/model/todo_model/delete_todo_model.dart';
import 'package:todo_application/features/presentation/model/todo_model/todo_list_model.dart';
import 'package:todo_application/features/presentation/repository/todo_repo/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<ApiResponse<TodoListModel>> getTodoListAPI() async {
    try {
      final response = await _helper.get('/todos');

      // SQL INSERT PART
      final List todos = response.data;
      for (var item in todos) {
        await TodoLocalService.insertTodo(
          TodoData(
            todoId: item['id'],
            title: item['title'],
            completed: item['completed'] == true ? 1 : 0,
          ),
        );
      }

      final Map<String, dynamic> wrappedData = {
        "Data": response.data, // response.data is List
      };
      final model = TodoListModel.fromJson(wrappedData);
      if (response.statusCode == 200) {
        return ApiResponse.success(
          data: model,
          statusCodeServer: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          statusCodeServer: response.statusCode,
          errorMsg: "Failed to load todos",
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        statusCodeServer: 404,
        errorMsg: _handleDioError(e),
      );
    }
  }

  @override
  Future<ApiResponse<DeleteTodoModel>> addTodoAPI(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _helper.post('/todos', reqbody: data);

      final model = DeleteTodoModel.fromJson(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiResponse.success(
          data: model,
          statusCodeServer: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          statusCodeServer: response.statusCode,
          errorMsg: "Failed to load todos",
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        statusCodeServer: 404,
        errorMsg: _handleDioError(e),
      );
    }
  }

  @override
  Future<ApiResponse<DeleteTodoModel>> updateTodoAPI(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _helper.put('/todos/${data["id"]}', reqbody: data);
      final model = DeleteTodoModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return ApiResponse.success(
          data: model,
          statusCodeServer: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          statusCodeServer: response.statusCode,
          errorMsg: "Failed to load todos",
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        statusCodeServer: 404,
        errorMsg: _handleDioError(e),
      );
    } catch (e) {
      return ApiResponse.error(
        statusCodeServer: 404,
        errorMsg:(e.toString()),
      );
    }
  }

  @override
  Future<ApiResponse<DeleteTodoModel>> deleteTodoAPI(int id) async {
    try {
      final response = await _helper.delete('/todos/$id');
      final model = DeleteTodoModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return ApiResponse.success(
          data: model,
          statusCodeServer: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          statusCodeServer: response.statusCode,
          errorMsg: "Failed to load todos",
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        statusCodeServer: 404,
        errorMsg: _handleDioError(e),
      );
    } catch (e) {
      return ApiResponse.error(
        statusCodeServer: 404,
        errorMsg:(e.toString()),
      );
    }
  }
}

String _handleDioError(DioException e) {
  if (e.response != null) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    if (statusCode == 500) {
      return "Server error. Please try again later.";
    }

    if (data is Map<String, dynamic>) {
      return data['message'] ?? "Something went wrong";
    }

    if (data is String) {
      return data; // 🔥 THIS FIXES YOUR CRASH
    }
  }

  if (e.type == DioExceptionType.connectionTimeout) {
    return "Connection timeout";
  }

  if (e.type == DioExceptionType.unknown) {
    return "No internet connection";
  }

  return "Unexpected error occurred";
}
