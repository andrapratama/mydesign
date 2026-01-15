import 'package:mydesign/data/models/schedule_model.dart';

abstract class ScheduleState {}

// State saat aplikasi pertama kali dijalankan
class ScheduleInitial extends ScheduleState {}

// State saat proses pengambilan atau manipulasi data sedang berlangsung
class ScheduleLoading extends ScheduleState {}

// State utama yang menyimpan data jadwal untuk ditampilkan di UI
class ScheduleLoaded extends ScheduleState {
  final List<Schedule> todaySchedules;
  final List<Schedule> weeklySchedules;

  ScheduleLoaded(this.todaySchedules, this.weeklySchedules);
}

// State untuk menangani error (seperti gagal simpan atau validasi tanggal)
class ScheduleError extends ScheduleState {
  final String message;
  ScheduleError(this.message);
}

// State sukses khusus untuk aksi yang membutuhkan feedback instan (Export/Import/Update)
class ScheduleActionSuccess extends ScheduleState {
  final String message;
  ScheduleActionSuccess(this.message);
}
