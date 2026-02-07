part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class PerformGetTodoListEvent extends TodoEvent {}

class PerformAddTodoEvent extends TodoEvent {
  final Map<String, dynamic> bodyData;
  PerformAddTodoEvent({required this.bodyData});
}

class PerformUpdateTodoEvent extends TodoEvent {
  final Map<String, dynamic> bodyData;
  PerformUpdateTodoEvent({required this.bodyData});
}

class PerformDeleteTodoEvent extends TodoEvent {
  final int todoId;
  PerformDeleteTodoEvent({required this.todoId});
}