part of 'todo_bloc.dart';

class TodoState {
  bool isGetLoading,isAddLoading,isUpdateLoading,isDeleteLoading;
  bool isCompleted;
  bool isFailed;
  String? error;
  TodoListModel? todoListModel;
  DeleteTodoModel? deleteTodoModel;
  DeleteTodoModel? updateTodoModel;
  DeleteTodoModel? addTodoListModel;

  TodoState({
    this.isGetLoading = false,
    this.isAddLoading = false,
    this.isUpdateLoading = false,
    this.isDeleteLoading = false,
    this.isCompleted = false,
    this.isFailed = false,
    this.error,
    this.todoListModel,
    this.deleteTodoModel,
    this.updateTodoModel,
    this.addTodoListModel,
  });
}
