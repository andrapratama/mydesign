import 'dart:async';
import 'package:mydesign/data/models/schedule_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('schedules.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE schedules (
        id $idType,
        title $textType,
        note $textType,
        date $textType
      )
    ''');
  }

  // --- OPERASI CRUD ---

  Future<int> insert(Schedule schedule) async {
    final db = await instance.database;
    return await db.insert('schedules', schedule.toMap());
  }

  Future<List<Schedule>> getAllSchedules() async {
    final db = await instance.database;
    // Mengurutkan berdasarkan tanggal terdekat
    final result = await db.query('schedules', orderBy: 'date ASC');

    return result.map((json) => Schedule.fromMap(json)).toList();
  }

  Future<int> update(Schedule schedule) async {
    final db = await instance.database;
    return await db.update(
      'schedules',
      schedule.toMap(),
      where: 'id = ?', // Pastikan ada baris ini
      whereArgs: [schedule.id], // Pastikan schedule.id tidak null
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('schedules', where: 'id = ?', whereArgs: [id]);
  }

  // --- FITUR IMPORT / EXPORT ---

  /// Mengambil semua data dan mengubahnya menjadi List Map untuk JSON
  Future<List<Map<String, dynamic>>> getRawData() async {
    final db = await instance.database;
    return await db.query('schedules');
  }

  /// Menghapus semua data lama dan memasukkan data baru dari hasil import
  Future<void> clearAndImport(List<Schedule> schedules) async {
    final db = await instance.database;
    await db.transaction((txn) async {
      await txn.delete('schedules'); // Hapus data lama agar bersih
      for (var item in schedules) {
        await txn.insert('schedules', item.toMap());
      }
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
