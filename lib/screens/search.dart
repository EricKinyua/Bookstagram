import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            TextFormField(
              style: TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 20),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
