import 'package:flutter/cupertino.dart';

class CupertinoSliverNavigationBarScreen extends StatefulWidget {
  const CupertinoSliverNavigationBarScreen({super.key});

  @override
  State<CupertinoSliverNavigationBarScreen> createState() =>
      _CupertinoSliverNavigationBarScreenState();
}

class _CupertinoSliverNavigationBarScreenState
    extends State<CupertinoSliverNavigationBarScreen> {
  // 🔍 Search state
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<bool> isSearching = ValueNotifier(false);
  final ValueNotifier<String> searchNotifier = ValueNotifier('');

  final List<String> provinsi = [
    'Aceh',
    'Bali',
    'Banten',
    'Bengkulu',
    'DKI Jakarta',
    'DI Yogyakarta',
    'Gorontalo',
    'Jambi',
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    'Kalimantan Barat',
    'Kalimantan Selatan',
    'Kalimantan Tengah',
    'Kalimantan Timur',
    'Kalimantan Utara',
    'Kepulauan Bangka Belitung',
    'Kepulauan Riau',
    'Lampung',
    'Maluku',
    'Maluku Utara',
    'Nusa Tenggara Barat',
    'Nusa Tenggara Timur',
    'Papua',
    'Papua Barat',
    'Riau',
    'Sulawesi Barat',
    'Sulawesi Selatan',
    'Sulawesi Tengah',
    'Sulawesi Tenggara',
    'Sulawesi Utara',
    'Sumatera Barat',
    'Sumatera Selatan',
    'Sumatera Utara',
  ];

  Map<String, List<String>> groupByAlphabet(List<String> items) {
    final Map<String, List<String>> grouped = {};
    for (var item in items) {
      final letter = item[0].toUpperCase();
      grouped.putIfAbsent(letter, () => []);
      grouped[letter]!.add(item);
    }
    return grouped;
  }

  @override
  void dispose() {
    searchController.dispose();
    isSearching.dispose();
    searchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [_buildScrollContent(), _buildFloatingSearchBar()],
      ),
    );
  }

  Widget _buildScrollContent() {
    return ValueListenableBuilder<String>(
      valueListenable: searchNotifier,
      builder: (context, query, _) {
        final filtered =
            provinsi
                .where((p) => p.toLowerCase().contains(query.toLowerCase()))
                .toList()
              ..sort();

        final groupedProvinsi = groupByAlphabet(filtered);
        final sortedKeys = groupedProvinsi.keys.toList()..sort();

        return CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Provinsi'),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Icon(CupertinoIcons.map_pin_ellipse),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Icon(CupertinoIcons.add),
              ),
            ),

            // Spacer agar list tidak ketutup search bar
            const SliverToBoxAdapter(child: SizedBox(height: 90)),

            for (final letter in sortedKeys) ...[
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: CupertinoColors.systemGrey6,
                  child: Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final name = groupedProvinsi[letter]![index];
                  return CupertinoListTile(title: Text(name));
                }, childCount: groupedProvinsi[letter]!.length),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildFloatingSearchBar() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 24,
      child: ValueListenableBuilder<bool>(
        valueListenable: isSearching,
        builder: (context, active, _) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),

                const Icon(
                  CupertinoIcons.search,
                  color: CupertinoColors.systemGrey,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: CupertinoTextField(
                    controller: searchController,
                    placeholder: 'Cari',
                    decoration: const BoxDecoration(
                      color: CupertinoColors.transparent,
                    ),
                    onTap: () => isSearching.value = true,
                    onChanged: (v) => searchNotifier.value = v,
                    clearButtonMode: OverlayVisibilityMode.never,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child:
                      active
                          ? GestureDetector(
                            onTap: () {
                              searchController.clear();
                              searchNotifier.value = '';
                              isSearching.value = false;
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: CupertinoColors.systemGrey3,
                              ),
                              child: const Icon(
                                CupertinoIcons.clear_thick,
                                size: 16,
                                color: CupertinoColors.white,
                              ),
                            ),
                          )
                          : const Icon(
                            CupertinoIcons.mic,
                            color: CupertinoColors.systemGrey,
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
