import 'package:redo/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static const int _version = 1;
  static const String _tbname = 'AllTask';
  static Future<void> initDB() async { 
    if (_db != null) {
      return;
    }
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      String dbPath = '${await getDatabasesPath()}AllTask.db';
      _db = await openDatabase(dbPath, version: _version,
          onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tbname("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, note TEXT, time STRING, "
          "date STRING, priorty STRING, "
          "category INTEGER, repeat STRING, "
          "isCompelet INTEGER)",
        );
      });
    } catch (e) {
      //  print(e);
    }
  }

  static Future<int> insert(TaskModel? task) async {
    return await _db?.insert(_tbname, task!.toJason()) ?? 1;
  }

  static delete(TaskModel task) async {
    await _db!.delete(_tbname, where: 'id=?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return _db!.query(_tbname);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE AllTask
      SET isCompelet = ? 
      WHERE ID = ?
      ''', [1, id]);
  }

  static undo(int id) async {
    return await _db!.rawUpdate('''
      UPDATE AllTask
      SET isCompelet = ? 
      WHERE ID = ?
      ''', [0, id]);
  }
}
