import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/models/catatan_keuangan_model.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/repositories/catatan_keuangan_repository.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/presentation/cubit/catatan_keuangan_state.dart';

class CatatanKeuanganCubit extends Cubit<CatatanKeuanganState> {
  final CatatanKeuanganRepository repo;

  CatatanKeuanganCubit(this.repo) : super(CatatanKeuanganInitial());

  Future<void> loadByPemilik(int pemilikId) async {
    try {
      emit(CatatanKeuanganLoading());
      final data = await repo.getByPemilik(pemilikId);
      emit(CatatanKeuanganLoaded(data));
    } catch (e) {
      emit(CatatanKeuanganError(e.toString()));
    }
  }

  Future<void> add(CatatanKeuangan data) async {
    try {
      await repo.add(data);
      loadByPemilik(data.pemilikId);
    } catch (e) {
      emit(CatatanKeuanganError(e.toString()));
    }
  }
}
