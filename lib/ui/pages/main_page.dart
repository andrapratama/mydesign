import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydesign/ui/pages/dashboard_page.dart';
import 'package:mydesign/ui/pages/profile_page.dart';
import 'package:mydesign/ui/pages/schedule_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Navigasi halaman
  final List<Widget> _pages = [
    const DashboardPage(),
    const SchedulePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Sangat penting agar body meluas ke bawah nav bar
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(
          20,
          0,
          20,
          30,
        ), // Margin agar melayang
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Radius di semua sisi
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            // Warna ceria untuk item
            selectedItemColor: const Color(0xFF00B0FF), // Oranye ceria
            unselectedItemColor: const Color(0xFFBDBDBD),
            // --- PENGATURAN UKURAN FONT ---
            selectedLabelStyle: GoogleFonts.plusJakartaSans(
              fontSize: 10, // Ukuran saat dipilih
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: GoogleFonts.plusJakartaSans(
              fontSize: 9, // Ukuran saat tidak dipilih
              fontWeight: FontWeight.w500,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
