import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'keuangan.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pemilik_saldo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        saldo_awal INTEGER NOT NULL,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE catatan_keuangan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pemilik_id INTEGER,
        tanggal TEXT,
        nominal INTEGER,
        jenis TEXT,
        keterangan TEXT,
        created_at TEXT,
        FOREIGN KEY (pemilik_id) REFERENCES pemilik_saldo(id)
      )
    ''');
  }
}
