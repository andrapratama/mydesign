import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/models/pemilik_saldo_model.dart';

abstract class PemilikSaldoState {}

class PemilikSaldoInitial extends PemilikSaldoState {}

class PemilikSaldoLoading extends PemilikSaldoState {}

class PemilikSaldoLoaded extends PemilikSaldoState {
  final List<PemilikSaldo> data;
  PemilikSaldoLoaded(this.data);
}

class PemilikSaldoError extends PemilikSaldoState {
  final String message;
  PemilikSaldoError(this.message);
}
