import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:Bookstagram/screens/dashboard.dart';
import 'package:Bookstagram/screens/likes.dart';
import 'package:Bookstagram/screens/profile.dart';
import 'package:Bookstagram/screens/search.dart';
import 'package:Bookstagram/widgets/custom_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  static BottomNavigationBarItem _bottomNavItem(String title, IconData icon) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          size: 24,
          color: Colors.black,
        ),
        activeIcon: Icon(
          icon,
          size: 30,
          color: Colors.blue,
        ),
        title: Text(title));
  }

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _page = 0;
  PageController _controller;
  static dynamic currentUser;

  List<BottomNavigationBarItem> items = [
    Homepage._bottomNavItem('Home', Icons.dashboard),
    Homepage._bottomNavItem('Search', Icons.search),
    Homepage._bottomNavItem('Likes', Icons.favorite_border),
    Homepage._bottomNavItem('Profile', Icons.person_outline),
  ];

  List<Widget> _pages = [
    DashboardScreen(),
    SearchScreen(),
    LikesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<AuthProvider>(context).currentUser;
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      body: PageView(
        children: _pages,
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        pageSnapping: true,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: items,
          currentIndex: _page,
          onTap: (value) {
            setState(() {
              _page = value;
              _controller.animateToPage(_page,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            });
          },
        ),
      ),
      floatingActionButton: Consumer<AuthProvider>(
        builder: (context, AuthProvider value, child) => CustomFab(),
      ),
    );
  }
}
