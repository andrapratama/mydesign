import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/bloc/schedule_bloc.dart';
import 'package:mydesign/bloc/schedule_event.dart';
import 'package:mydesign/utils/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Bagian Foto/Nama
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: AppColors.accent),
            ),
            const SizedBox(height: 16),
            const Text(
              "User Penjadwalan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "user@example.com",
              style: TextStyle(color: AppColors.textGrey),
            ),
            const SizedBox(height: 40),

            // Bagian Manajemen Data
            _buildActionCard(
              title: "Export Data",
              subtitle: "Simpan semua jadwal ke file JSON",
              icon: Icons.upload_file,
              onTap: () {
                context.read<ScheduleBloc>().add(ExportData());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Data berhasil diexport ke folder Download"),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              title: "Import Data",
              subtitle: "Pulihkan jadwal dari file cadangan",
              icon: Icons.download_for_offline,
              onTap: () {
                // Tambahkan logika File Picker di sini
                context.read<ScheduleBloc>().add(ImportData());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.accent),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
