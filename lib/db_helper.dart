import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'catatan_utang.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE utang (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal TEXT,
        keterangan TEXT,
        nilai INTEGER
      )
    ''');
  }

  // Tambah Data
  Future<int> insertUtang(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('utang', row);
  }

  // Ambil Semua Data
  Future<List<Map<String, dynamic>>> getUtangList() async {
    Database db = await database;
    return await db.query('utang', orderBy: "id DESC");
  }

  // Hapus Data (Opsional tapi penting)
  Future<int> deleteUtang(int id) async {
    Database db = await database;
    return await db.delete('utang', where: 'id = ?', whereArgs: [id]);
  }

  // Tambahkan ini di dalam class DbHelper
  Future<int> deleteAllUtang() async {
    Database db = await database;
    return await db.delete('utang');
  }
}
