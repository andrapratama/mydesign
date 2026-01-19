# Dokumentasi Kode: `main.dart`

Dokumen ini menjelaskan struktur dan fungsionalitas dari file `lib/main.dart` dalam proyek Flutter ini. File ini adalah titik masuk utama aplikasi dan mendefinisikan tampilan utama serta navigasi dasar.

## Alur Kerja Kode

Kode dieksekusi dalam urutan berikut:

1.  Fungsi `main()` dijalankan pertama kali.
2.  `main()` memanggil `runApp()` dengan widget `MyApp` sebagai argumen.
3.  `MyApp` membangun `MaterialApp`, yang merupakan widget dasar untuk aplikasi yang menggunakan Material Design. Ini mengatur tema, judul, dan halaman utama (`home`).
4.  Halaman utama diatur ke `MyHomePage`, sebuah `StatefulWidget`.
5.  `MyHomePage` membuat state-nya, yaitu `_MyHomePageState`.
6.  `_MyHomePageState` membangun UI utama menggunakan `Scaffold`, yang mencakup `AppBar`, `body` (konten utama), dan `BottomNavigationBar`.
7.  Interaksi pengguna dengan `BottomNavigationBar` akan memanggil fungsi `_onItemTapped`, yang memperbarui state dan mengubah konten yang ditampilkan di `body`.

---

## Detail Widget dan Fungsi

### 1. `main()`

```dart
void main() {
  runApp(const MyApp());
}
```

- **Tujuan**: Titik masuk aplikasi Flutter.
- **Fungsi**: Memanggil `runApp()` untuk memulai aplikasi. `runApp()` mengambil widget yang diberikan (`MyApp`) dan menjadikannya sebagai root dari pohon widget aplikasi.

### 2. `MyApp` (StatelessWidget)

```dart
class MyApp extends StatelessWidget {
  // ...
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(...),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

- **Tujuan**: Widget root aplikasi.
- **Fungsi**:
    - Menginisialisasi `MaterialApp`, yang menyediakan fungsionalitas dasar aplikasi seperti routing, tema, dll.
    - `title`: Judul aplikasi yang digunakan oleh sistem operasi.
    - `theme`: Tema visual untuk seluruh aplikasi (misalnya, warna, font).
    - `home`: Widget yang akan ditampilkan sebagai layar utama saat aplikasi pertama kali dibuka. Di sini, kita menggunakan `MyHomePage`.

### 3. `MyHomePage` (StatefulWidget)

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
```

- **Tujuan**: Mewakili layar utama aplikasi yang dapat berubah statusnya.
- **Fungsi**:
    - Ini adalah `StatefulWidget`, yang berarti tampilannya dapat berubah selama runtime berdasarkan interaksi pengguna atau data yang masuk.
    - Menerima `title` yang akan ditampilkan di `AppBar`.
    - `createState()`: Metode ini dipanggil oleh Flutter untuk membuat objek state-nya, `_MyHomePageState`.

### 4. `_MyHomePageState` (State)

Ini adalah kelas logika dan UI untuk `MyHomePage`.

#### Properti State

```dart
int _selectedIndex = 0;

static const List<Widget> _widgetOptions = <Widget>[
  Text('Halaman Home', ...),
  Text('Halaman Pesan', ...),
  Text('Halaman Profil', ...),
];
```

- `_selectedIndex`: Variabel untuk melacak item (tab) mana yang sedang aktif di `BottomNavigationBar`. Nilai default-nya adalah `0` (item pertama, yaitu Home).
- `_widgetOptions`: Sebuah daftar (`List`) yang berisi widget-widget yang akan ditampilkan sebagai konten utama. Urutan widget dalam daftar ini sesuai dengan urutan item di `BottomNavigationBar`.

#### Metode

```dart
void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
```

- **Tujuan**: Menangani ketika pengguna mengetuk salah satu item di `BottomNavigationBar`.
- **Fungsi**:
    - Menerima `index` dari item yang diketuk.
    - Memanggil `setState()`, sebuah metode penting dalam `StatefulWidget`. Ini memberitahu Flutter bahwa state telah berubah.
    - Di dalam `setState()`, `_selectedIndex` diperbarui ke `index` yang baru.
    - Setelah `setState()` dipanggil, Flutter akan menjalankan kembali metode `build()` untuk memperbarui UI sesuai dengan state yang baru.

#### Metode `build()`

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(...),
    body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
    bottomNavigationBar: BottomNavigationBar(...),
  );
}
```

- **Tujuan**: Membangun dan mengembalikan hierarki widget yang membentuk UI layar.
- **Struktur**:
    - `Scaffold`: Kerangka dasar untuk tata letak halaman Material Design.
    - `appBar`: Bilah aplikasi di bagian atas layar.
    - `body`: Konten utama halaman. Di sini, kita menggunakan `Center` untuk memposisikan konten di tengah. Kontennya sendiri diambil dari `_widgetOptions` berdasarkan `_selectedIndex` yang aktif saat ini.
    - `bottomNavigationBar`: Bilah navigasi di bagian bawah layar.
        - `items`: Daftar `BottomNavigationBarItem` yang mendefinisikan setiap tab (ikon dan label).
        - `currentIndex`: Mengatur item mana yang disorot, dikendalikan oleh `_selectedIndex`.
        - `selectedItemColor`: Warna untuk item yang aktif.
        - `onTap`: Fungsi yang akan dipanggil saat item diketuk. Di sini, kita mengaturnya ke `_onItemTapped`.
