import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBUser {
  DBUser._();
  static final DBUser db = DBUser._();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String caminho = await getDatabasesPath();
    String banco = 'userDB';
    String path = join(caminho, banco);

    return await openDatabase(path, version: 1, onCreate: _criar);
  }

  Future<void> _criar(Database db, int novaVersao) async {
    List<String> queryes = ['CREATE TABLE user (name TEXT)'];

    for (String query in queryes) {
      await db.execute(query);
    }
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database;
    return db!.query(table);
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    final db = await database;
    await db!.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(String table, String name) async {
    final db = await database;
    await db!.delete(table, where: "name = ?", whereArgs: [name]);
  }

  Future<void> update(String table, String name, Map<String, Object> data) async {
    final db = await database;

    await db!.update(table, data, where: "name = ?", whereArgs: [name]);
  }
}
