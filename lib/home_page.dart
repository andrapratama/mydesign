import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mydesign/add_debt_page.dart';
import 'package:mydesign/db_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _utangList = [];
  final DbHelper _dbHelper = DbHelper();
  int _totalUtang = 0;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final data = await _dbHelper.getUtangList();
    int total = data.fold(0, (sum, item) => sum + (item['nilai'] as int));
    setState(() {
      _utangList = data;
      _totalUtang = total;
    });
  }

  void _deleteUtang(int id) async {
    await _dbHelper.deleteUtang(id);
    _refreshData();
  }

  // --- LOGIKA EXPORT ---
  Future<void> _exportData() async {
    try {
      // 1. Ambil semua data dari DB
      final data = await _dbHelper.getUtangList();
      if (data.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tidak ada data untuk diexport.")),
        );
        return;
      }

      // 2. Ubah ke format JSON String
      String jsonString = jsonEncode(data);

      // 3. Simpan ke file sementara
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/backup_utang.json');
      await file.writeAsString(jsonString);

      // 4. Bagikan file tersebut (Share)
      // Menggunakan XFile untuk share_plus terbaru
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Backup Data Catatan Utang');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal Export: $e")));
    }
  }

  // --- LOGIKA IMPORT ---
  Future<void> _importData() async {
    try {
      // 1. Buka File Picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);

        // 2. Baca isi file
        String content = await file.readAsString();

        // 3. Parsing JSON
        List<dynamic> jsonList = jsonDecode(content);

        // 4. Konfirmasi User sebelum hapus data lama
        if (!mounted) return;
        bool confirm =
            await showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text("Peringatan Import"),
                    content: const Text(
                      "Import akan MENGHAPUS SEMUA data saat ini dan menggantinya dengan data baru. Lanjutkan?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          "TIMPA DATA",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
            ) ??
            false;

        if (confirm) {
          // 5. Hapus data lama
          await _dbHelper.deleteAllUtang();

          // 6. Masukkan data baru (Looping)
          for (var item in jsonList) {
            await _dbHelper.insertUtang({
              'tanggal': item['tanggal'],
              'keterangan': item['keterangan'],
              'nilai': item['nilai'],
              // Kita tidak memasukkan 'id' agar database membuat ID baru yang urut
            });
          }

          // 7. Refresh UI
          _refreshData();
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data berhasil diimport!")),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File rusak atau format salah!")),
      );
    }
  }

  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hapus Data"),
          content: const Text("Yakin ingin menghapus?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteUtang(id);
              },
              child: const Text("Hapus", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  String formatRupiah(int number) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Utang"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        // --- TAMBAHAN TOMBOL MENU ---
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'export') _exportData();
              if (value == 'import') _importData();
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'export',
                  child: Row(
                    children: [
                      Icon(Icons.upload, color: Colors.teal),
                      SizedBox(width: 8),
                      Text("Backup (Export)"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'import',
                  child: Row(
                    children: [
                      Icon(Icons.download, color: Colors.teal),
                      SizedBox(width: 8),
                      Text("Restore (Import)"),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                _utangList.isEmpty
                    ? const Center(child: Text("Belum ada data utang."))
                    : ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: 80,
                      ),
                      itemCount: _utangList.length,
                      itemBuilder: (context, index) {
                        final item = _utangList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            onLongPress:
                                () => _showDeleteConfirmation(item['id']),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal.shade100,
                                child: const Icon(
                                  Icons.monetization_on,
                                  color: Colors.teal,
                                ),
                              ),
                              title: Text(
                                item['keterangan'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(item['tanggal']),
                              trailing: Text(
                                formatRupiah(item['nilai']),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Hutang:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  formatRupiah(_totalUtang),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDebtPage()),
          );
          if (result == true) _refreshData();
        },
      ),
    );
  }
}
