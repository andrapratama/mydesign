import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/datasources/catatan_keuangan_local_ds.dart';

class ExportRepository {
  final CatatanKeuanganLocalDatasource local;

  ExportRepository(this.local);

  Future<List<Map<String, dynamic>>> getData() async {
    return await local.exportData();
  }
}
