import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/mymoney_note_chatgpt/core/services/file_service.dart';
import 'package:mydesign/mymoney_note_chatgpt/core/utils/csv_utils.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/export/presentation/cubit/export_state.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/export/presentation/data/reporsitories/export_repository.dart';

class ExportCubit extends Cubit<ExportState> {
  final ExportRepository repo;

  ExportCubit(this.repo) : super(ExportInitial());

  Future<void> export() async {
    try {
      emit(ExportLoading());

      final data = await repo.getData();
      final csv = generateCSV(data);
      final file = await saveCSV(csv);

      emit(ExportSuccess(file));
    } catch (e) {
      emit(ExportError(e.toString()));
    }
  }
}
