import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  Widget _intro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Welcome Back!',
          style:
              GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Login to your account now',
          style: GoogleFonts.quicksand(
            color: Colors.black87,
            fontSize: 17,
          ),
        )
      ],
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email address', labelStyle: GoogleFonts.quicksand()),
    );
  }

  Widget _passwordTextfield() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: GoogleFonts.quicksand(),
          suffixIcon: Icon(
            Icons.remove_red_eye,
          )),
    );
  }

  Widget _options() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RadioListTile(
            value: false,
            groupValue: null,
            onChanged: null,
            title: Text('Remember me'),
            dense: true,
          ),
        ),
        FlatButton(onPressed: null, child: Text('Forgot Password?'))
      ],
    );
  }

  Widget _loginButton(BuildContext context) {
    return MaterialButton(
      onPressed: () => print('I want to login'),
      color: Colors.black.withOpacity(0.4),
      padding: EdgeInsets.all(12),
      minWidth: MediaQuery.of(context).size.width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Text('Login',
          style: GoogleFonts.quicksand(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5)),
    );
  }

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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _intro(),
                SizedBox(
                  height: 30,
                ),
                _emailTextField(),
                SizedBox(
                  height: 20,
                ),
                _passwordTextfield(),
                SizedBox(
                  height: 10,
                ),
                _options(),
                SizedBox(
                  height: 20,
                ),
                _loginButton(context),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Or Log in with',
                    style: GoogleFonts.quicksand(),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: FlatButton(
                      onPressed: () => print('Sign Up'),
                      child: Text(
                        'Sign Up here',
                        style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
