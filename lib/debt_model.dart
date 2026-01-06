// debt_model.dart

enum DebtType {
  utang, // Kita yang berhutang (Harus bayar)
  piutang, // Orang lain berhutang ke kita (Kita menagih)
}

class DebtModel {
  final String id;
  final String name; // Nama orangnya
  final double amount; // Nominal
  final DateTime date; // Tanggal transaksi
  final DebtType type; // Jenis transaksi
  final bool isLunas; // Status lunas
  final String avatarUrl; // Foto profil dummy (opsional, biar cantik)

  DebtModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.type,
    required this.isLunas,
    required this.avatarUrl,
  });
}
