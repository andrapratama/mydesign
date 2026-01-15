import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/bloc/schedule_event.dart';
import 'package:mydesign/bloc/schedule_state.dart';
import 'package:mydesign/data/database_helper.dart';
import 'package:mydesign/data/models/schedule_model.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final DatabaseHelper dbHelper;

  // Variabel untuk menyimpan data asli agar pencarian lebih cepat
  List<Schedule> _allSchedulesCache = [];

  ScheduleBloc(this.dbHelper) : super(ScheduleInitial()) {
    on<LoadSchedules>(_onLoadSchedules);
    on<AddSchedule>(_onAddSchedule);
    on<UpdateSchedule>(_onUpdateSchedule);
    on<DeleteSchedule>(_onDeleteSchedule);
    on<SearchSchedules>(_onSearchSchedules);
  }
  void _onLoadSchedules(
    LoadSchedules event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      _allSchedulesCache = await dbHelper.getAllSchedules();
      _emitLoadedState(emit, _allSchedulesCache);
    } catch (e) {
      emit(ScheduleError("Gagal memuat data"));
    }
  }

  void _onSearchSchedules(SearchSchedules event, Emitter<ScheduleState> emit) {
    // Kita melakukan filter terhadap _allSchedulesCache (data asli dari DB)
    // sehingga state.weeklySchedules di UI akan selalu terupdate sesuai query

    if (event.query.isEmpty) {
      _emitLoadedState(emit, _allSchedulesCache);
      return;
    }

    final filtered =
        _allSchedulesCache.where((s) {
          return s.title.toLowerCase().contains(event.query.toLowerCase()) ||
              s.note.toLowerCase().contains(event.query.toLowerCase());
        }).toList();

    _emitLoadedState(emit, filtered);
  }

  // Helper function untuk memisahkan data hari ini dan mingguan
  void _emitLoadedState(Emitter<ScheduleState> emit, List<Schedule> schedules) {
    final now = DateTime.now();
    final todayData =
        schedules
            .where(
              (s) =>
                  s.date.year == now.year &&
                  s.date.month == now.month &&
                  s.date.day == now.day,
            )
            .toList();

    emit(ScheduleLoaded(todayData, schedules));
  }

  void _onAddSchedule(AddSchedule event, Emitter<ScheduleState> emit) async {
    // Gunakan logika validasi yang sama
    if (!_isDateValid(event.schedule.date)) {
      emit(
        ScheduleError(
          "Jadwal harus antara Senin minggu ini hingga Minggu depan",
        ),
      );
      return;
    }

    try {
      await dbHelper.insert(event.schedule);
      add(LoadSchedules());
    } catch (e) {
      emit(ScheduleError("Gagal menambah jadwal"));
    }
  }

  // --- FUNGSI UBAH (UPDATE) ---
  void _onUpdateSchedule(
    UpdateSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    if (!_isDateValid(event.schedule.date)) {
      emit(ScheduleError("Tanggal perubahan di luar rentang yang diizinkan"));
      return;
    }

    try {
      await dbHelper.update(event.schedule);
      add(LoadSchedules()); // Refresh data otomatis
    } catch (e) {
      emit(ScheduleError("Gagal mengubah jadwal"));
    }
  }

  // --- FUNGSI HAPUS (DELETE) ---
  void _onDeleteSchedule(
    DeleteSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      await dbHelper.delete(event.id);
      add(LoadSchedules()); // Refresh data otomatis
    } catch (e) {
      emit(ScheduleError("Gagal menghapus jadwal"));
    }
  }

  // Helper function agar kode tidak berulang (DRY - Don't Repeat Yourself)
  bool _isDateValid(DateTime date) {
    DateTime now = DateTime.now();
    DateTime startRange = now.subtract(Duration(days: now.weekday - 1));
    startRange = DateTime(
      startRange.year,
      startRange.month,
      startRange.day,
    ); // Set ke jam 00:00
    DateTime endRange = startRange.add(
      const Duration(days: 14),
    ); // Akhir minggu depan

    return date.isAfter(startRange.subtract(const Duration(seconds: 1))) &&
        date.isBefore(endRange);
  }
}
