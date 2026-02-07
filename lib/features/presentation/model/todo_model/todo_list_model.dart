// To parse this JSON data, do
//
// final todoListModel = todoListModelFromJson(jsonString);

import 'dart:convert';

TodoListModel todoListModelFromJson(String str) =>
    TodoListModel.fromJson(json.decode(str));

String todoListModelToJson(TodoListModel data) =>
    json.encode(data.toJson());

class TodoListModel {
  final List<TodoData>? data;
  final bool? isSuccess;
  final String? message;

  TodoListModel({
    this.data,
    this.isSuccess,
    this.message,
  });

  /// When API response is wrapped
  factory TodoListModel.fromJson(Map<String, dynamic> json) =>
      TodoListModel(
        data: json["Data"] == null
            ? []
            : List<TodoData>.from(
            json["Data"].map((x) => TodoData.fromJson(x))),
        isSuccess: json["IsSuccess"],
        message: json["Message"],
      );

  /// When API directly returns list (jsonplaceholder)
  factory TodoListModel.fromList(List list) => TodoListModel(
    data: List<TodoData>.from(
        list.map((x) => TodoData.fromJson(x))),
    isSuccess: true,
    message: "Success",
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
    "Message": message,
  };
}

class TodoData {
  final int? todoId;
  final String? title;
  final int? completed;
  final String? createdAt;
  final String? updatedAt;

  TodoData({
    this.todoId,
    this.title,
    this.completed,
    this.createdAt,
    this.updatedAt,
  });

  /// GET / LIST
  factory TodoData.fromJson(Map<String, dynamic> json) =>
      TodoData(
        todoId: json["Id"] ?? json["id"],
        title: json["Title"] ?? json["title"],
        completed: json['completed'] == true || json['completed'] == 1 ? 1 : 0,
        createdAt: json["CreatedAt"],
        updatedAt: json["UpdatedAt"],
      );

  /// ADD / UPDATE
  Map<String, dynamic> toJson() => {
    "Id": todoId,
    "Title": title,
    "Completed": completed,
  };

  /// DELETE (only id required)
  Map<String, dynamic> toDeleteJson() => {
    "Id": todoId,
  };

  bool get isCompleted => completed == 1;
}
