import 'package:flutter/material.dart';
import 'package:lazis/tabPages/earning_tab.dart';
import 'package:lazis/tabPages/home_tab.dart';
import 'package:lazis/tabPages/profile_tab.dart';
import 'package:lazis/tabPages/rating_tab.dart';


class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

  TabController? tabController;
  int selectedIndex = 0;

  onItemClick(int index){
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
        children: const [
          HomeTabPage(),
          EarningsTabPage(),
          RatingTabPage(),
          ProfileTabPage(),
        ],),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card),
            label: "History",),
            BottomNavigationBarItem(icon: Icon(Icons.star),
            label: "Rating",),
            BottomNavigationBarItem(icon: Icon(Icons.person),
            label: "Account",),
          ],
          unselectedItemColor: Color.fromARGB(255, 107, 107, 107),
          selectedItemColor: const Color(0xffF67034),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 14),
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onItemClick,
          ),
    );
  }
}