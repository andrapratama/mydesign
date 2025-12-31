import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/models/pemilik_saldo_model.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/repositories/pemilik_saldo_repository.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/presentation/cubit/pemilik_saldo_state.dart';

class PemilikSaldoCubit extends Cubit<PemilikSaldoState> {
  final PemilikSaldoRepository repo;

  PemilikSaldoCubit(this.repo) : super(PemilikSaldoInitial());

  Future<void> load() async {
    try {
      emit(PemilikSaldoLoading());
      final data = await repo.getAll();
      emit(PemilikSaldoLoaded(data));
    } catch (e) {
      emit(PemilikSaldoError(e.toString()));
    }
  }

  Future<void> add(PemilikSaldo data) async {
    try {
      await repo.add(data);
      load();
    } catch (e) {
      emit(PemilikSaldoError(e.toString()));
    }
  }

  Future<void> update(PemilikSaldo data) async {
    try {
      await repo.update(data);
      load();
    } catch (e) {
      emit(PemilikSaldoError(e.toString()));
    }
  }

  Future<void> delete(int id) async {
    try {
      await repo.delete(id);
      load();
    } catch (e) {
      emit(PemilikSaldoError(e.toString()));
    }
  }
}
