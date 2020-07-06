import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget bacgroundImage(Size size) {
    return Expanded(
        child: ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      child: Image.network(
        'https://images.unsplash.com/photo-1584869603969-428540799c2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
        fit: BoxFit.cover,
        height: size.height * 0.5,
        width: size.width,
      ),
    ));
  }

  Widget backgroundStack(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Column(
        children: [bacgroundImage(size), Expanded(child: Container())],
      ),
    );
  }

  Widget singleDetailItem(String title, String text) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.ubuntu(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: GoogleFonts.ubuntu(color: Colors.red, letterSpacing: 1),
        )
      ],
    );
  }

  Widget profileDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        singleDetailItem('Followers', '1000'),
        singleDetailItem('Following', '900'),
        singleDetailItem('Posts', '2'),
      ],
    );
  }

  Widget profileInfo(Size size) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        height: 250,
        width: size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'John Doe',
              style: GoogleFonts.ubuntu(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            Text(
              'This is a short profile about myself. I will write one or two lines. If i am feeling it i will write three lines',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: Colors.black,
              ),
            ),
            RaisedButton(
              onPressed: () => print('I want to follow you'),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                'Follow',
                style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            profileDetails()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [backgroundStack(size), profileInfo(size)],
    );
  }
}
