import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(
    0xFFF8F9FA,
  ); // Putih abu-abu sangat muda
  static const Color cardWhite = Color(0xFFFFFFFF); // Putih bersih
  static const Color accent = Color(0xFF2D62ED); // Biru modern
  static const Color textDark = Color(0xFF1A1A1A); // Hitam elegan (bukan pekat)
  static const Color textGrey = Color(
    0xFF8E8E93,
  ); // Abu-abu untuk teks sekunder
  static const Color danger = Color(0xFFFF3B30); // Merah untuk hapus data
}

final List<BoxShadow> softShadow = [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.04),
    blurRadius: 20,
    offset: const Offset(0, 10),
  ),
];
