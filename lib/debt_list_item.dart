import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'debt_model.dart'; // Pastikan import file model yang tadi dibuat

class DebtListWidget extends StatelessWidget {
  final List<DebtModel> debtList;

  const DebtListWidget({super.key, required this.debtList});

  @override
  Widget build(BuildContext context) {
    // Format Rupiah
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return ListView.separated(
      padding: EdgeInsets.all(16), // Padding biar gak mepet layar
      itemCount: debtList.length,
      separatorBuilder:
          (context, index) => SizedBox(height: 12), // Jarak antar kartu
      itemBuilder: (context, index) {
        final item = debtList[index];

        // Logika Warna: Merah (Utang), Hijau (Piutang)
        final amountColor =
            item.type == DebtType.utang ? Colors.redAccent : Colors.green;

        // Jika sudah lunas, warna jadi agak pudar biar fokus ke yang belum lunas
        final cardOpacity = item.isLunas ? 0.6 : 1.0;

        return Opacity(
          opacity: cardOpacity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                16,
              ), // Sudut membulat (Modern UI)
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4), // Efek bayangan halus
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // 1. Avatar Foto
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(item.avatarUrl),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                ),
                SizedBox(width: 16),

                // 2. Info Nama & Tanggal
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.type == DebtType.utang
                            ? "Saya Berhutang"
                            : "Hutang ke Saya",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                // 3. Nominal & Status Lunas
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currencyFormat.format(item.amount),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: amountColor, // Warna dinamis
                      ),
                    ),
                    SizedBox(height: 6),
                    // Badge Lunas / Belum
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            item.isLunas
                                ? Colors.green.shade100
                                : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item.isLunas ? "LUNAS" : "BELUM LUNAS",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: item.isLunas ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
