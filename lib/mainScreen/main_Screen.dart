import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lazis/tabPages/earning_tab.dart';
import 'package:lazis/tabPages/home_tab.dart';
import 'package:lazis/tabPages/profile_tab.dart';
import 'package:lazis/tabPages/rating_tab.dart';
import 'package:lazis/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final screens = [
    const HomeTabPage(),
    const RiwayatTabPage(),
    PermintaanTab(),
    const ProfileTabPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (states) {
              final isSelected = states.contains(MaterialState.selected);
              return GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isSelected ? bold : regular,
                color: isSelected ? cOrange : cGrey,
              );
            },
          ),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          elevation: 20.0,
          height: 80,
          backgroundColor: cWhite,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) =>
              setState(() => selectedIndex = index),
          animationDuration: const Duration(seconds: 1),
          destinations: [
            NavigationDestination(
              icon: Icon(
                Iconsax.home_15,
                color: cGrey,
              ),
              selectedIcon: Icon(
                Iconsax.home_15,
                color: cOrange,
              ),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.task_square5,
                color: cGrey,
              ),
              selectedIcon: Icon(
                Iconsax.task_square5,
                color: cOrange,
              ),
              label: 'Riwayat',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.notification5,
                color: cGrey,
              ),
              selectedIcon: Icon(
                Iconsax.notification5,
                color: cOrange,
              ),
              label: 'Permintaan',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.profile_tick5,
                color: cGrey,
              ),
              selectedIcon: Icon(
                Iconsax.profile_tick5,
                color: cOrange,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}



// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen>
//     with SingleTickerProviderStateMixin {
//   TabController? tabController;
//   int selectedIndex = 0;

//   onItemClick(int index) {
//     setState(() {
//       selectedIndex = index;
//       tabController!.index = selectedIndex;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(
//         physics: const NeverScrollableScrollPhysics(),
//         controller: tabController,
//         children: [
//           const HomeTabPage(),
//           const RiwayatTabPage(),
//           PermintaanTab(),
//           const ProfileTabPage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Iconsax.home_15),
//             label: "Beranda",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Iconsax.task_square5),
//             label: "Riwayat",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Iconsax.notification5),
//             label: "Permintaan",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Iconsax.profile_tick5),
//             label: "Profil",
//           ),
//         ],
//         unselectedItemColor: cGrey,
//         unselectedLabelStyle: GoogleFonts.poppins(
//           fontSize: 14,
//         ),
//         selectedItemColor: cOrange,
//         backgroundColor: cWhite,
//         type: BottomNavigationBarType.fixed,
//         selectedLabelStyle: GoogleFonts.poppins(
//           fontWeight: semibold,
//           fontSize: 14,
//         ),
//         currentIndex: selectedIndex,
//         onTap: onItemClick,
//       ),
//     );
//   }
// }
