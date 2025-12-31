import 'package:mydesign/mymoney_note_chatgpt/core/database/db_helper.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/models/catatan_keuangan_model.dart';

class CatatanKeuanganLocalDatasource {
  final dbHelper = DBHelper.instance;

  Future<int> insert(CatatanKeuangan data) async {
    _validateDate(data.tanggal);

    final db = await dbHelper.database;
    return await db.insert('catatan_keuangan', data.toMap());
  }

  Future<List<CatatanKeuangan>> getByPemilik(int pemilikId) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'catatan_keuangan',
      where: 'pemilik_id = ?',
      whereArgs: [pemilikId],
      orderBy: 'tanggal DESC',
    );

    return result
        .map(
          (e) => CatatanKeuangan(
            id: e['id'] as int,
            pemilikId: e['pemilik_id'] as int,
            tanggal: e['tanggal'] as String,
            nominal: e['nominal'] as int,
            jenis: e['jenis'] as String,
            keterangan: e['keterangan'] as String?,
          ),
        )
        .toList();
  }

  void _validateDate(String date) {
    final input = DateTime.parse(date);
    final today = DateTime.now();

    if (input.isAfter(DateTime(today.year, today.month, today.day))) {
      throw Exception('Tanggal tidak boleh lebih dari hari ini');
    }
  }

  Future<List<Map<String, dynamic>>> exportData() async {
    final db = await DBHelper.instance.database;

    return await db.rawQuery('''
    SELECT
      c.tanggal,
      p.nama AS pemilik,
      c.jenis,
      c.nominal,
      c.keterangan
    FROM catatan_keuangan c
    JOIN pemilik_saldo p ON p.id = c.pemilik_id
    ORDER BY c.tanggal ASC
  ''');
  }
}
