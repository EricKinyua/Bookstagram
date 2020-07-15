import 'package:Bookstagram/models/single_post_model.dart';
import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:Bookstagram/widgets/singlePost.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  Widget _appBar() {
    return AppBar(
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
          onPressed: () => AuthProvider.instance().logout(),
        )
      ],
    );
  }

  Widget _body() {
    return ListView.builder(
      addAutomaticKeepAlives: false,
      itemCount: posts.length,
      itemBuilder: (context, index) => SinglePostWidget(model: posts[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Color(0xFFEDF0F6),
      body: _body(),
    );
  }
}
