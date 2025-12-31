class CatatanKeuangan {
  final int? id;
  final int pemilikId;
  final String tanggal;
  final int nominal;
  final String jenis;
  final String? keterangan;

  CatatanKeuangan({
    this.id,
    required this.pemilikId,
    required this.tanggal,
    required this.nominal,
    required this.jenis,
    this.keterangan,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'pemilik_id': pemilikId,
    'tanggal': tanggal,
    'nominal': nominal,
    'jenis': jenis,
    'keterangan': keterangan,
  };
}
