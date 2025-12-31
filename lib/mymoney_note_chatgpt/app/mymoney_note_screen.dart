import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/data/models/catatan_keuangan_model.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/catatan_keuangan/presentation/cubit/catatan_keuangan_cubit.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/data/models/pemilik_saldo_model.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/presentation/cubit/pemilik_saldo_cubit.dart';
import 'package:mydesign/mymoney_note_chatgpt/features/pemilik_saldo/presentation/cubit/pemilik_saldo_state.dart';
import 'package:intl/intl.dart';

class MymoneyNoteScreen extends StatefulWidget {
  const MymoneyNoteScreen({super.key});

  @override
  State<MymoneyNoteScreen> createState() => _MymoneyNoteScreenState();
}

class _MymoneyNoteScreenState extends State<MymoneyNoteScreen> {
  final nominalCtrl = TextEditingController();
  final ketCtrl = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String jenis = 'masuk';
  PemilikSaldo? selectedPemilik;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Keuangan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Pemilik Saldo
            BlocBuilder<PemilikSaldoCubit, PemilikSaldoState>(
              builder: (context, state) {
                if (state is PemilikSaldoLoaded) {
                  return DropdownButtonFormField<PemilikSaldo>(
                    decoration: const InputDecoration(
                      labelText: 'Pemilik Saldo',
                    ),
                    items:
                        state.data.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.nama),
                          );
                        }).toList(),
                    onChanged: (val) => selectedPemilik = val,
                  );
                }
                return const SizedBox();
              },
            ),

            const SizedBox(height: 12),

            // Tanggal
            InkWell(
              onTap: pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Tanggal'),
                child: Text(DateFormat('dd MMM yyyy').format(selectedDate)),
              ),
            ),

            const SizedBox(height: 12),

            // Jenis
            DropdownButtonFormField<String>(
              initialValue: jenis,
              items: const [
                DropdownMenuItem(value: 'masuk', child: Text('Masuk')),
                DropdownMenuItem(value: 'keluar', child: Text('Keluar')),
              ],
              onChanged: (val) => setState(() => jenis = val!),
              decoration: const InputDecoration(labelText: 'Jenis'),
            ),

            const SizedBox(height: 12),

            // Nominal
            TextField(
              controller: nominalCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nominal',
                prefixText: 'Rp ',
              ),
            ),

            const SizedBox(height: 12),

            // Keterangan
            TextField(
              controller: ketCtrl,
              decoration: const InputDecoration(
                labelText: 'Keterangan (opsional)',
              ),
            ),

            const Spacer(),

            // Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: save,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void save() {
    if (selectedPemilik == null) {
      _showError('Pemilik saldo wajib dipilih');
      return;
    }

    if (nominalCtrl.text.isEmpty) {
      _showError('Nominal wajib diisi');
      return;
    }

    final data = CatatanKeuangan(
      pemilikId: selectedPemilik!.id!,
      tanggal: DateFormat('yyyy-MM-dd').format(selectedDate),
      nominal: int.parse(nominalCtrl.text),
      jenis: jenis,
      keterangan: ketCtrl.text,
    );

    context.read<CatatanKeuanganCubit>().add(data);
    Navigator.pop(context);
  }

  Future<void> pickDate() async {
    final today = DateTime.now();

    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(today.year, today.month, today.day),
    );

    if (result != null) {
      setState(() => selectedDate = result);
    }
  }

  void _showError(String msg) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Validasi'),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
