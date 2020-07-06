import 'package:Bookstagram/models/single_post_model.dart';
import 'package:Bookstagram/widgets/singlePost.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  static BottomNavigationBarItem _bottomNavItem(String title, IconData icon) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          size: 30,
          color: Colors.black,
        ),
        title: Text(title));
  }

  static List<BottomNavigationBarItem> items = [
    _bottomNavItem('Home', Icons.dashboard),
    _bottomNavItem('Search', Icons.search),
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Color(0xFF23B66F),
          onPressed: () => print('Upload photo'),
          child: Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(''),
    ),
    _bottomNavItem('Likes', Icons.favorite_border),
    _bottomNavItem('Profile', Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF0F6),
        elevation: 0,
        title: Text('Bookstagram',
            style: GoogleFonts.yellowtail(
              color: Colors.black,
              fontSize: 30,
            )),
        actions: [
          IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: null)
        ],
      ),
      backgroundColor: Color(0xFFEDF0F6),
      body: ListView.builder(
        addAutomaticKeepAlives: false,
        itemCount: posts.length,
        itemBuilder: (context, index) => SinglePostWidget(model: posts[index]),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, items: items),
      ),
    );
  }
}
