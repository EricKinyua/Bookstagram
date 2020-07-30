import 'package:Bookstagram/models/single_post_model.dart';
import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:Bookstagram/provider/database_provider.dart';
import 'package:Bookstagram/widgets/singlePost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future documents;
  DatabaseProvider database = DatabaseProvider();

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
    return FutureBuilder<List<DocumentSnapshot>>(
      future: documents,
      builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        print(snapshot.data);
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.none:
            return Center(
              child: Text('No previous posts'),
            );
            break;
          case ConnectionState.done:
            if (snapshot.data.length == 0) {
              return Center(
                child: Text('No previous posts'),
              );
            }
            return ListView.builder(
                addAutomaticKeepAlives: false,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  SinglePostModel postModel =
                      SinglePostModel.fromFirestore(snapshot.data[index]);
                  return SinglePostWidget(model: postModel);
                });
            break;
          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  @override
  void initState() {
    documents = database.getAllPosts();
    super.initState();
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
