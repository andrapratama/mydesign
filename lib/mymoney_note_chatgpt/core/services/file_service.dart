// lib/core/services/file_service.dart

import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> saveCSV(String csv) async {
  final dir = await getApplicationDocumentsDirectory();

  final file = File(
    '${dir.path}/keuangan_${DateTime.now().millisecondsSinceEpoch}.csv',
  );

  return await file.writeAsString(csv);
}
