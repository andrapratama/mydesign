import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/datasources/catatan_keuangan_local_ds.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/models/catatan_keuangan_model.dart';

class CatatanKeuanganRepository {
  final CatatanKeuanganLocalDatasource local;

  CatatanKeuanganRepository(this.local);

  Future<void> add(CatatanKeuangan data) async {
    await local.insert(data);
  }

  Future<List<CatatanKeuangan>> getByPemilik(int pemilikId) async {
    return await local.getByPemilik(pemilikId);
  }
}
