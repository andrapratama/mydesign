import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mydesign/data/models/schedule_model.dart';
import '../../bloc/schedule_bloc.dart';
import '../../bloc/schedule_event.dart';
import '../../bloc/schedule_state.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        // HEADER DIUBAH MENJADI SEARCH BAR
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.none,
            onChanged: (value) {
              // 1. Kirim event ke BLoC (untuk filter data)
              context.read<ScheduleBloc>().add(SearchSchedules(value));

              // 2. PAKSA RE-BUILD UI (untuk mengevaluasi suffixIcon)
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: "Cari jadwal kegiatan...",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Color(0xFF2D62ED),
                size: 20,
              ),
              suffixIcon:
                  _searchController.text.isNotEmpty
                      ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () {
                          // Bersihkan teks secara fisik
                          _searchController.clear();
                          // Reset filter di BLoC
                          context.read<ScheduleBloc>().add(SearchSchedules(""));
                          // Update UI agar tombol X hilang setelah dihapus
                          setState(() {});
                        },
                      )
                      : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ScheduleLoaded) {
            // JIKA HASIL FILTER KOSONG, TAMPILKAN EMPTY STATE
            if (state.weeklySchedules.isEmpty) {
              return _buildEmptySearchState();
            }

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 180),
              itemCount: state.weeklySchedules.length,
              itemBuilder: (context, index) {
                final item = state.weeklySchedules[index];
                return _buildScheduleCard(context, item);
              },
            );
          }
          return const Center(child: Text("Terjadi kesalahan"));
        },
      ),
      // TOMBOL TAMBAH DI TENGAH
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
          bottom: 100,
        ), // Memberi jarak agar tidak menabrak Nav Bar
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF2D62ED), // Biru modern
          elevation: 4,
          onPressed: () => _showFormDialog(context),
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text(
            "Add Schedule",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Sudut membulat modern
          ),
        ),
      ),
    );
  }

  // WIDGET: Kartu Jadwal (Read, Update, Delete)
  Widget _buildScheduleCard(BuildContext context, Schedule item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.note,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Color(0xFF2D62ED),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat('EEE, dd MMM yyyy - HH:mm').format(item.date),
                      style: const TextStyle(
                        color: Color(0xFF2D62ED),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.orange),
            onPressed: () => _showFormDialog(context, schedule: item),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _showDeleteConfirmation(context, item),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Schedule item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Hapus Jadwal?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Apakah Anda yakin ingin menghapus jadwal '${item.title}'? Tindakan ini tidak dapat dibatalkan.",
            style: const TextStyle(color: Color(0xFF8E8E93)),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Batal",
                style: TextStyle(
                  color: Color(0xFF8E8E93),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Kirim event hapus ke BLoC
                context.read<ScheduleBloc>().add(DeleteSchedule(item.id!));
                Navigator.pop(context); // Tutup dialog

                // Opsional: Tampilkan feedback singkat
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Jadwal berhasil dihapus"),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              child: const Text(
                "Hapus",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// DIALOG: Form Tambah/Ubah
  void _showFormDialog(BuildContext context, {Schedule? schedule}) {
    if (schedule != null) {
      _titleController.text = schedule.title;
      _noteController.text = schedule.note;
      _selectedDate = schedule.date;
      _selectedTime = TimeOfDay.fromDateTime(schedule.date);
    } else {
      _titleController.clear();
      _noteController.clear();
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder:
          (context) => StatefulBuilder(
            // Agar UI di dalam Modal bisa update
            builder:
                (context, setModalState) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        schedule == null ? "Tambah Jadwal" : "Ubah Jadwal",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _titleController,
                        decoration: _inputDecoration("Judul Kegiatan"),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _noteController,
                        decoration: _inputDecoration("Catatan"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate,
                                  firstDate:
                                      DateTime.now(), // Batasan hari ini ke depan
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (picked != null)
                                  setModalState(() => _selectedDate = picked);
                              },
                              icon: const Icon(Icons.calendar_month),
                              label: Text(
                                DateFormat('dd/MM/yy').format(_selectedDate),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                );
                                if (picked != null)
                                  setModalState(() => _selectedTime = picked);
                              },
                              icon: const Icon(Icons.access_time),
                              label: Text(_selectedTime.format(context)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D62ED),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          final finalDateTime = DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            _selectedTime.hour,
                            _selectedTime.minute,
                          );

                          // Pastikan ID disertakan agar SQLite tahu baris mana yang diupdate
                          final newSchedule = Schedule(
                            id:
                                schedule
                                    ?.id, // ID diambil dari data lama (jika ada)
                            title: _titleController.text,
                            note: _noteController.text,
                            date: finalDateTime,
                          );

                          if (schedule == null) {
                            // Tambah data baru
                            context.read<ScheduleBloc>().add(
                              AddSchedule(newSchedule),
                            );
                          } else {
                            // REVISI: Tambahkan update schedule di sini
                            context.read<ScheduleBloc>().add(
                              UpdateSchedule(newSchedule),
                            );
                          }

                          Navigator.pop(context); // Tutup modal
                        },
                        child: const Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
          ),
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            "Jadwal tidak ditemukan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8E8E93),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Coba gunakan kata kunci lain",
            style: TextStyle(color: Color(0xFFC7C7CC)),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF1F4F8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
