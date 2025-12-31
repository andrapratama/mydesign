import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/datasources/pemilik_saldo_local_ds.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/models/pemilik_saldo_model.dart';

class PemilikSaldoRepository {
  final PemilikSaldoLocalDatasource local;

  PemilikSaldoRepository(this.local);

  Future<void> add(PemilikSaldo data) async {
    await local.insert(data);
  }

  Future<List<PemilikSaldo>> getAll() async {
    return await local.getAll();
  }

  Future<void> update(PemilikSaldo data) async {
    await local.update(data);
  }

  Future<void> delete(int id) async {
    await local.delete(id);
  }
}
