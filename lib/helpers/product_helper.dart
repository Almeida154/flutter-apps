import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/product.dart';

class ProductHelper {
  static const String tableName = "products";

  static final ProductHelper _instance = ProductHelper._internal();

  factory ProductHelper() {
    return _instance;
  }

  ProductHelper._internal();

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
        "quantity VARCHAR,"
        "date DATETIME)";
    await db.execute(sql);
  }

  initDb() async {
    final dbPath = await getDatabasesPath();
    final dbLocal = join(dbPath, "products_database.db");

    var db = await openDatabase(dbLocal, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> saveTask(Product product) async {
    var database = await ProductHelper().db;
    int result = await database.insert(tableName, product.toMap());
    return result;
  }

  recoverTasks() async {
    var database = await ProductHelper().db;
    String sql = "SELECT * FROM $tableName ORDER BY date DESC";
    List result = await database.rawQuery(sql);
    return result;
  }

  Future<int> updateTask(Product product) async {
    var database = await ProductHelper().db;
    return await database.update(tableName, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);
  }

  Future<int> removeTask(int id) async {
    var database = await ProductHelper().db;
    return await database.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
