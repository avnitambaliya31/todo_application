
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/db/database_helper.dart';
import 'package:todo_application/features/presentation/model/todo_model/todo_list_model.dart';

class TodoLocalService {

  static Future<void> insertTodo(TodoData todo) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'todos',
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<TodoData>> getTodos() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('todos');

    return result.map((e) => TodoData.fromJson(e)).toList();
  }

  static Future<void> updateTodo(TodoData todo) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'todos',
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.todoId],
    );
  }

  static Future<void> deleteTodo(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> clearAll() async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('todos');
  }

  static Future<bool> isEmpty() async {
    final db = await DatabaseHelper.instance.database;
    final result = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM todos'),
    );
    return result == 0;
  }

}
