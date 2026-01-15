// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mydesign/data/database_helper.dart';

import 'package:mydesign/main.dart';

void main() {
  testWidgets('Dashboard render smoke test', (WidgetTester tester) async {
    // Inisialisasi database mock untuk lingkungan testing

    final dbHelper = DatabaseHelper.instance;

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(dbHelper: dbHelper));

    // Verifikasi bahwa teks "Jadwal Saya" (Judul di Dashboard) muncul di layar
    expect(find.text('Jadwal Saya'), findsOneWidget);

    // Verifikasi bahwa tab "Hari Ini" muncul
    expect(find.text('Hari Ini'), findsOneWidget);
  });
}
