import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydesign/bloc/schedule_bloc.dart';
import 'package:mydesign/bloc/schedule_event.dart';
import 'package:mydesign/data/database_helper.dart';
import 'package:mydesign/ui/pages/main_page.dart';

void main() {
  // Pastikan plugin Flutter terinisialisasi sebelum akses database
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Database
  final dbHelper = DatabaseHelper.instance;

  runApp(MyApp(dbHelper: dbHelper));
}

class MyApp extends StatelessWidget {
  final DatabaseHelper dbHelper;

  const MyApp({super.key, required this.dbHelper});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // BLoC diletakkan di level tertinggi agar data sinkron di semua halaman
      create: (context) => ScheduleBloc(dbHelper)..add(LoadSchedules()),
      child: MaterialApp(
        title: 'Schedule App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2D62ED),
            // Pengganti 'background' adalah 'surface'
            surface: const Color(0xFFF8F9FA),
            // Anda juga bisa mengatur warna permukaan kartu (Card, Dialog, dll)
            surfaceContainerLowest: Colors.white,
            // Warna teks utama secara otomatis disesuaikan oleh seedColor,
            // tapi bisa di-override jika perlu:
            onSurface: const Color(0xFF1A1A1A),
          ),
          // Untuk memastikan Scaffold menggunakan warna surface yang baru
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        ),
        home: const MainPage(),
      ),
    );
  }
}
