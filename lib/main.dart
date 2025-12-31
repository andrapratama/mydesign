// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:mydesign/cupertino_sliver_navigation_bar/cupertino_sliver_navigation_bar_screen.dart';
import 'package:mydesign/login/login_screen.dart';
import 'package:mydesign/my_app/cubit/focus_cubit.dart';
import 'package:mydesign/my_app/signin_screen.dart';
import 'package:mydesign/mymoney_note_chatgpt/app/mymoney_note_screen.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/datasources/catatan_keuangan_local_ds.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/repositories/catatan_keuangan_repository.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/presentation/cubit/catatan_keuangan_cubit.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/export/presentation/cubit/export_cubit.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/export/presentation/data/reporsitories/export_repository.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/datasources/pemilik_saldo_local_ds.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/repositories/pemilik_saldo_repository.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/presentation/cubit/pemilik_saldo_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FocusCubit()),
        BlocProvider<PemilikSaldoCubit>(
          create:
              (_) => PemilikSaldoCubit(
                PemilikSaldoRepository(PemilikSaldoLocalDatasource()),
              ),
        ),
        BlocProvider<CatatanKeuanganCubit>(
          create:
              (_) => CatatanKeuanganCubit(
                CatatanKeuanganRepository(CatatanKeuanganLocalDatasource()),
              ),
        ),
        BlocProvider<ExportCubit>(
          create:
              (_) => ExportCubit(
                ExportRepository(CatatanKeuanganLocalDatasource()),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: const LoginScreen(),
        // home: const SigninScreen(),
        // home: FloatingBottomNavBar(),
        // home: CupertinoSliverNavigationBarScreen(),
        home: MymoneyNoteScreen(),
      ),
    );
  }
}
