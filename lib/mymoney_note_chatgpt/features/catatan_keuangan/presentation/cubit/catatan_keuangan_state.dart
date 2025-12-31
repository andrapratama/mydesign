import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/models/catatan_keuangan_model.dart';

abstract class CatatanKeuanganState {}

class CatatanKeuanganInitial extends CatatanKeuanganState {}

class CatatanKeuanganLoading extends CatatanKeuanganState {}

class CatatanKeuanganLoaded extends CatatanKeuanganState {
  final List<CatatanKeuangan> data;
  CatatanKeuanganLoaded(this.data);
}

class CatatanKeuanganError extends CatatanKeuanganState {
  final String message;
  CatatanKeuanganError(this.message);
}
