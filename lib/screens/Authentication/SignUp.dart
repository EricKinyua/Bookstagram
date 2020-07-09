import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF0F6),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: null),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hello!',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 30)),
            SizedBox(
              height: 5,
            ),
            Text(
              'Please fill in to Sign Up new account',
              style: GoogleFonts.quicksand(color: Colors.black87, fontSize: 17),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: GoogleFonts.quicksand(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: GoogleFonts.quicksand(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.quicksand(),
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Retype Password',
                labelStyle: GoogleFonts.quicksand(),
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: () => print('I want to SignUp'),
              color: Colors.black.withOpacity(0.4),
              padding: EdgeInsets.all(12),
              minWidth: MediaQuery.of(context).size.width,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text('Sign Up',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5)),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Or Log in with',
                style: GoogleFonts.quicksand(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
