import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/cart_state.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
    required this.cartState,
  });
  final StatefulNavigationShell navigationShell;
  final CartState cartState;
  void _onTabSelected(int index) {
    navigationShell.goBranch(
      index,
      // Mengetuk tab yang sedang aktif = kembali ke halaman awal tab
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ListenableBuilder(
        listenable: cartState,
        builder: (context, child) => NavigationBar(
          height: 68,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTabSelected,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Beranda',
            ),
            const NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Cari',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('${cartState.count}'),
                isLabelVisible: cartState.count > 0,
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              label: 'Keranjang',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
