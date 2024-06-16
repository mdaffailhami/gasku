import 'package:flutter/material.dart';
import 'package:gasku/pages/beranda.dart';
import 'package:gasku/pages/e_tiket.dart';
import 'package:gasku/pages/profil.dart';
import 'package:gasku/pages/riwayat.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GasKu',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.4),
        actions: [
          Container(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Muhammad Daffa Ilhami',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Text(
                    '612896192837',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.4),
        onDestinationSelected: (int index) {
          setState(() => _selectedPageIndex = index);
        },
        selectedIndex: _selectedPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card),
            label: 'E-Tiket',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Beranda',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.credit_card),
      //       label: 'E-Tiket',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history),
      //       label: 'Riwayat',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline),
      //       label: 'Profil',
      //     ),
      //   ],
      //   currentIndex: _selectedTab,
      //   selectedItemColor: Theme.of(context).colorScheme.primary,
      //   unselectedItemColor: Theme.of(context).unselectedWidgetColor,
      //   showUnselectedLabels: true,
      //   type: BottomNavigationBarType.fixed,
      //   onTap: _onTabTapped,
      // ),
      body: const <Widget>[
        MyBerandaPage(),
        MyETiketPage(),
        MyRiwayatPage(),
        MyProfilPage(),
      ][_selectedPageIndex],
    );
  }
}
