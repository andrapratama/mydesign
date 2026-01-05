import 'package:flutter/material.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andra Satria Pratama - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(
          0xFFF9FAFB,
        ), // Clean off-white background
        fontFamily: 'Roboto', // Pastikan font ini atau yang mirip tersedia
        useMaterial3: true,
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  // Data Mockup
  final String name = "Andra Satria Pratama";
  final String role = "Flutter Developer & UI/UX Enthusiast";
  final String aboutText =
      "Saya adalah seorang Software Engineer yang berfokus pada pengembangan aplikasi mobile "
      "cross-platform menggunakan Flutter. Saya memiliki passion dalam menciptakan "
      "kode yang bersih, performa tinggi, dan antarmuka yang user-friendly.";

  @override
  Widget build(BuildContext context) {
    // Deteksi ukuran layar
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    return Scaffold(
      appBar:
          isDesktop
              ? null // Custom Header untuk Desktop
              : AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
      drawer: isDesktop ? null : _buildMobileDrawer(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (isDesktop) _buildDesktopNavbar(context),
                _buildHeroSection(context, isDesktop),
                _buildSectionTitle("Tentang Saya"),
                _buildAboutSection(isDesktop),
                _buildSectionTitle("Pengalaman Kerja"),
                _buildExperienceSection(isDesktop),
                _buildSectionTitle("Skill Pemrograman"),
                _buildSkillsSection(),
                _buildSectionTitle("Kontak"),
                _buildContactSection(),
                _buildFooter(),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- WIDGETS SECTION ---

  // 1. Navbar (Desktop Only)
  Widget _buildDesktopNavbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              _navButton("Home"),
              _navButton("About"),
              _navButton("Experience"),
              _navButton("Contact"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Drawer Mobile
  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: const Text("andra@email.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("A", style: TextStyle(fontSize: 24)),
            ),
            decoration: const BoxDecoration(color: Colors.indigo),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("About"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text("Experience"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // 2. Hero Section
  Widget _buildHeroSection(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isDesktop ? 100 : 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0E7FF), Colors.white], // Light Indigo gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Colors.indigo,
            child: const CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage(
                "https://via.placeholder.com/150",
              ), // Ganti dengan foto asli
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Hi, I'm $name",
            style: TextStyle(
              fontSize: isDesktop ? 48 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            role,
            style: TextStyle(
              fontSize: isDesktop ? 24 : 18,
              color: Colors.indigo,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Lihat Portfolio"),
          ),
        ],
      ),
    );
  }

  // 3. About Section
  Widget _buildAboutSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 200 : 20,
        vertical: 20,
      ),
      child: Text(
        aboutText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          color: Colors.black54,
        ),
      ),
    );
  }

  // 4. Experience Section
  Widget _buildExperienceSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 150 : 20),
      child: Column(
        children: [
          _experienceCard(
            "Senior Flutter Developer",
            "Tech Startup Indonesia",
            "2023 - Sekarang",
            "Memimpin tim mobile development dan mengimplementasikan arsitektur Clean Architecture.",
          ),
          _experienceCard(
            "Mobile App Developer",
            "Software House Creative",
            "2021 - 2023",
            "Membangun lebih dari 10 aplikasi untuk klien enterprise menggunakan Flutter dan Firebase.",
          ),
        ],
      ),
    );
  }

  Widget _experienceCard(
    String title,
    String company,
    String date,
    String desc,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              company,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 30),
            Text(
              desc,
              style: const TextStyle(height: 1.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // 5. Skills Section
  Widget _buildSkillsSection() {
    final List<String> skills = [
      "Flutter",
      "Dart",
      "Firebase",
      "REST API",
      "Git",
      "UI/UX Design",
      "Figma",
      "Clean Architecture",
      "Provider/Bloc",
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      alignment: Alignment.center,
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: skills.map((skill) => _skillChip(skill)).toList(),
      ),
    );
  }

  Widget _skillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // 6. Contact Section
  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Tertarik bekerja sama?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Mari diskusikan proyek Anda.",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text("Hubungi Saya via Email"),
          ),
        ],
      ),
    );
  }

  // Utilities
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.grey.shade100,
      width: double.infinity,
      child: const Text(
        "© 2024 Andra Satria Pratama. Built with Flutter.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
