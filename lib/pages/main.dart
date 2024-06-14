import 'package:flutter/material.dart';
import 'package:gasku/pages/beranda.dart';
import 'package:gasku/pages/profil.dart';

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
        title: Text('GasKu'),
        // elevation: 10,
        // surfaceTintColor: Colors.transparent,
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
      bottomNavigationBar: NavigationBar(
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
      body: const <Widget>[
        MyBerandaPage(),
        SizedBox(),
        SizedBox(),
        MyProfilPage(),
      ][_selectedPageIndex],
    );
  }
}
