import 'package:Bookstagram/models/single_book_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Widget _appBar() {
    return AppBar(
      title: Text('Bookstagram',
          style: GoogleFonts.yellowtail(
            color: Colors.black,
            fontSize: 30,
          )),
      backgroundColor: Color(0xFFEDF0F6),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            showSearch(context: context, delegate: BookstagramSearch());
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Color(0xFFEDF0F6),
      body: Container(
        height: size.height,
        width: size.width,
      ),
    );
  }
}

class BookstagramSearch extends SearchDelegate<SingleBookModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext contexntext) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(query);
  }
}
