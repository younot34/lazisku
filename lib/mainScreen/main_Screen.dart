import 'package:flutter/material.dart';
import 'package:lazis/tabPages/earning_tab.dart';
import 'package:lazis/tabPages/home_tab.dart';
import 'package:lazis/tabPages/profile_tab.dart';
import 'package:lazis/tabPages/rating_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClick(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          const HomeTabPage(),
          const RiwayatTabPage(),
          PermintaanTab(),
          const ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Permintaan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
        unselectedItemColor: const Color.fromARGB(255, 107, 107, 107),
        selectedItemColor: const Color.fromARGB(255, 244, 144, 3),
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClick,
      ),
    );
  }
}
