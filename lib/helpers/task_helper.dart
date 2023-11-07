import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task.dart';

class TaskHelper {
  static const String tableName = "tasks";

  static final TaskHelper _instance = TaskHelper._internal();

  factory TaskHelper() {
    return _instance;
  }

  TaskHelper._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await initDb();
    return _db!;
  }

  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title VARCHAR,"
        "date DATETIME)";
    await db.execute(sql);
  }

  initDb() async {
    final dbPath = await getDatabasesPath();
    final dbLocal = join(dbPath, "tasks_db.db");

    var db = await openDatabase(dbLocal, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> saveTask(Task task) async {
    var database = await TaskHelper().db;
    int result = await database.insert(tableName, task.toMap());
    return result;
  }

  recoverTasks() async {
    var database = await TaskHelper().db;
    String sql = "SELECT * FROM $tableName ORDER BY date DESC";
    List result = await database.rawQuery(sql);
    return result;
  }

  Future<int> updateTask(Task task) async {
    var database = await TaskHelper().db;
    return await database
        .update(tableName, task.toMap(), where: "id = ?", whereArgs: [task.id]);
  }

  Future<int> removeTask(int id) async {
    var database = await TaskHelper().db;
    return await database.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
