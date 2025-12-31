// lib/core/utils/csv_utils.dart

String generateCSV(List<Map<String, dynamic>> data) {
  final buffer = StringBuffer();

  buffer.writeln('Tanggal,Pemilik,Jenis,Nominal,Keterangan');

  for (final row in data) {
    buffer.writeln(
      '${row['tanggal']},'
      '${row['pemilik']},'
      '${row['jenis']},'
      '${row['nominal']},'
      '"${row['keterangan'] ?? ''}"',
    );
  }

  return buffer.toString();
}
