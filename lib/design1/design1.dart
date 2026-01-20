import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mydesign/design1/navigation_cubit.dart';

class Design1 extends StatelessWidget {
  const Design1({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Halaman Home',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Halaman Pesan',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Halaman Profil',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Stack(
        children: [
          BlocBuilder<NavigationCubit, int>(
            builder: (context, selectedIndex) {
              return Center(child: _widgetOptions.elementAt(selectedIndex));
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: Container(
                // Padding luar untuk "body" floating bar
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.0), // Lebih bulat
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: BlocBuilder<NavigationCubit, int>(
                  builder: (context, selectedIndex) {
                    final navItems = [
                      {'icon': LucideIcons.house, 'label': 'Home'},
                      {'icon': LucideIcons.mail, 'label': 'Message'},
                      {'icon': LucideIcons.user, 'label': 'Profile'},
                    ];

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(navItems.length, (index) {
                        final item = navItems[index];
                        final isSelected = index == selectedIndex;

                        return GestureDetector(
                          onTap:
                              () => context.read<NavigationCubit>().setIndex(
                                index,
                              ),
                          child: AnimatedContainer(
                            // 1. Animasi Container (Background & Lebar)
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutBack, // Efek memantul sedikit
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  isSelected ? 16 : 12, // Padding dinamis
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.amber[100]
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                // 2. Animasi Icon (Scale Up/Pop effect)
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(
                                    begin: 1.0,
                                    end:
                                        isSelected
                                            ? 1.2
                                            : 1.0, // Membesar sedikit saat aktif
                                  ),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutBack,
                                  builder: (context, scale, child) {
                                    return Transform.scale(
                                      scale: scale,
                                      child: Icon(
                                        item['icon'] as IconData,
                                        color:
                                            isSelected
                                                ? Colors.amber[900]
                                                : Colors.grey[600],
                                        size: 22,
                                      ),
                                    );
                                  },
                                ),

                                // 3. Animasi Teks (Sliding & Opacity)
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: SizedBox(
                                    width:
                                        isSelected
                                            ? null
                                            : 0, // null = auto width
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: AnimatedOpacity(
                                        opacity: isSelected ? 1.0 : 0.0,
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        child: Text(
                                          item['label'] as String,
                                          style: TextStyle(
                                            color: Colors.amber[900],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
