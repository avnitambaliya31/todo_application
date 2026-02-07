import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print("🟢 DB CREATED");
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY,
            title TEXT,
            completed INTEGER
          )
        ''');
        print("🟢 TABLE CREATED");
      },
    );
  }
}
