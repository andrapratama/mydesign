import 'package:mydesign/mymoney_note_chatgpt/core/database/db_helper.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/models/pemilik_saldo_model.dart';

class PemilikSaldoLocalDatasource {
  final dbHelper = DBHelper.instance;

  Future<int> insert(PemilikSaldo data) async {
    final db = await dbHelper.database;
    return await db.insert('pemilik_saldo', data.toMap());
  }

  Future<List<PemilikSaldo>> getAll() async {
    final db = await dbHelper.database;
    final result = await db.query('pemilik_saldo');
    return result.map((e) => PemilikSaldo.fromMap(e)).toList();
  }

  Future<int> update(PemilikSaldo data) async {
    final db = await dbHelper.database;
    return await db.update(
      'pemilik_saldo',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.database;
    return await db.delete('pemilik_saldo', where: 'id = ?', whereArgs: [id]);
  }
}
