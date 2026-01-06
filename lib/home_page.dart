import 'package:flutter/material.dart';
import 'package:mydesign/debt_list_item.dart';
import 'package:mydesign/debt_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Masukkan ini di dalam class Widget atau sebagai global variable
  List<DebtModel> dummyDebts = [
    DebtModel(
      id: '1',
      name: 'Budi Santoso',
      amount: 500000,
      date: DateTime.now().subtract(Duration(days: 2)),
      type: DebtType.piutang, // Budi utang ke kita
      isLunas: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
    ),
    DebtModel(
      id: '2',
      name: 'Ibu Kost',
      amount: 1200000,
      date: DateTime.now().subtract(Duration(days: 5)),
      type: DebtType.utang, // Kita belum bayar kost
      isLunas: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    ),
    DebtModel(
      id: '3',
      name: 'Siti Gorengan',
      amount: 15000,
      date: DateTime.now().subtract(Duration(days: 1)),
      type: DebtType.utang,
      isLunas: true, // Sudah lunas (bisa dikasih warna abu-abu/coret)
      avatarUrl: 'https://i.pravatar.cc/150?img=9',
    ),
    DebtModel(
      id: '4',
      name: 'Anto Bengkel',
      amount: 350000,
      date: DateTime.now().subtract(Duration(days: 10)),
      type: DebtType.piutang,
      isLunas: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
    ),
    DebtModel(
      id: '5',
      name: 'Arisan RT',
      amount: 200000,
      date: DateTime.now().subtract(Duration(days: 15)),
      type: DebtType.utang,
      isLunas: true,
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    DebtModel(
      id: '6',
      name: 'Project Pak Bos',
      amount: 5000000,
      date: DateTime.now().subtract(Duration(days: 20)),
      type: DebtType.piutang, // Project belum dibayar
      isLunas: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=13',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catatan Utang", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Color(
        0xFFF5F5F5,
      ), // Background abu muda biar kartu terlihat "pop"
      body: DebtListWidget(debtList: dummyDebts), // Masukkan data dummy tadi
    );
  }
}
