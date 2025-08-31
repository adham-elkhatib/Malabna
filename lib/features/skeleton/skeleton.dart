//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home/presentation/pages/home.screen.dart';
import '../my_tickets/presentation/pages/my_tickets_screen.dart';
import '../restaurants_orders/presentation/pages/restaurant_orders_screen.dart';
import '../resturants/presentation/pages/restaurants_screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class Skeleton extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const Skeleton({
    super.key,
  });

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const RestaurantsScreen(),
    const MyTicketsScreen(),
    const RestaurantOrdersScreen(),
  ];

  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION

  //SECTION - Stateless functions
  //!SECTION

  //SECTION - Action Callbacks
  //!SECTION

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _pages[_currentIndex], // Display the selected page
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update the selected index
            });
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'استكشف',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.utensils),
              label: 'المطاعم',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'تذاكري',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'طلباتي',
            ),
          ],
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
