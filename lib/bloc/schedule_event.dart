import 'package:mydesign/data/models/schedule_model.dart';

abstract class ScheduleEvent {}

// Mengambil data dari SQLite
class LoadSchedules extends ScheduleEvent {}

// Menambah data baru (dengan validasi rentang waktu di BLoC)
class AddSchedule extends ScheduleEvent {
  final Schedule schedule;
  AddSchedule(this.schedule);
}

// Mengubah data yang sudah ada berdasarkan ID
class UpdateSchedule extends ScheduleEvent {
  final Schedule schedule;
  UpdateSchedule(this.schedule);
}

// Menghapus data berdasarkan ID
class DeleteSchedule extends ScheduleEvent {
  final int id;
  DeleteSchedule(this.id);
}

// Memicu proses export ke file JSON
class ExportData extends ScheduleEvent {}

// Memicu proses pemilihan file dan import ke SQLite
class ImportData extends ScheduleEvent {}

// Cari Data
class SearchSchedules extends ScheduleEvent {
  final String query;
  SearchSchedules(this.query);
}
