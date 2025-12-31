class PemilikSaldo {
  final int? id;
  final String nama;
  final int saldoAwal;
  final String createdAt;

  PemilikSaldo({
    this.id,
    required this.nama,
    required this.saldoAwal,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'saldo_awal': saldoAwal,
      'created_at': createdAt,
    };
  }

  factory PemilikSaldo.fromMap(Map<String, dynamic> map) {
    return PemilikSaldo(
      id: map['id'],
      nama: map['nama'],
      saldoAwal: map['saldo_awal'],
      createdAt: map['created_at'],
    );
  }
}
