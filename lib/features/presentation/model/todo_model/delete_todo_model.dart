// To parse this JSON data, do
//
//     final deleteTodoModel = deleteTodoModelFromJson(jsonString);

import 'dart:convert';

DeleteTodoModel deleteTodoModelFromJson(String str) => DeleteTodoModel.fromJson(json.decode(str));

String deleteTodoModelToJson(DeleteTodoModel data) => json.encode(data.toJson());

class DeleteTodoModel {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  DeleteTodoModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory DeleteTodoModel.fromJson(Map<String, dynamic> json) => DeleteTodoModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
