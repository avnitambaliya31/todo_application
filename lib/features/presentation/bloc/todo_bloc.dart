import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:todo_application/features/presentation/model/todo_model/delete_todo_model.dart';
import 'package:todo_application/features/presentation/model/todo_model/todo_list_model.dart';
import 'package:todo_application/features/presentation/repository/todo_repo/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repo = GetIt.I<TodoRepository>();

  TodoBloc() : super(TodoState()) {
    on<PerformGetTodoListEvent>(_getTodos);
    on<PerformAddTodoEvent>(_addTodo);
    on<PerformUpdateTodoEvent>(_updateTodo);
    on<PerformDeleteTodoEvent>(_deleteTodo);
  }

  void _getTodos(PerformGetTodoListEvent event, Emitter<TodoState> emit) async {
    emit(TodoState(isGetLoading: true));

    final response = await _repo.getTodoListAPI();
    log("response in api: ${response.data!.data}");
    if (response.statusCodeServer == 200) {
      emit(TodoState(
        isCompleted: true,
        isGetLoading: false,
        todoListModel: response.data,
      ));
    } else {
      emit(TodoState(
        isFailed: true,
        isGetLoading: false,
        error: response.errorMsg,
      ));
    }
  }

  void _addTodo(
      PerformAddTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoState(isAddLoading: true));

    final response = await _repo.addTodoAPI(event.bodyData);
    if (response.statusCodeServer == 201 || response.statusCodeServer == 200) {
      emit(TodoState(
        isCompleted: true,
        isAddLoading: false,
        addTodoListModel: response.data,
      ));
    } else {
      emit(TodoState(
        isFailed: true,
        isAddLoading: false,
        error: response.errorMsg,
      ));
    }
  }

 void _updateTodo(
      PerformUpdateTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoState(isUpdateLoading: true));

    final response = await _repo.updateTodoAPI(event.bodyData);
    if (response.statusCodeServer == 200) {
      emit(TodoState(
        isCompleted: true,
        isUpdateLoading: false,
        updateTodoModel: response.data,
      ));
    } else {
      emit(TodoState(
        isFailed: true,
        isUpdateLoading: false,
        error: response.errorMsg,
      ));
    }
  }

  Future<void> _deleteTodo(
      PerformDeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoState(isDeleteLoading: true));


    final response = await _repo.deleteTodoAPI(event.todoId);
    if (response.statusCodeServer == 200) {
      emit(TodoState(
        isCompleted: true,
        isDeleteLoading: false,
        deleteTodoModel: response.data,
      ));
    } else {
      emit(TodoState(
        isFailed: true,
        isDeleteLoading: false,
        error: response.errorMsg,
      ));
    }
  }
}

