import 'package:Bookstagram/global/transitions.dart';
import 'package:Bookstagram/screens/Authentication/SignUp.dart';
import 'package:Bookstagram/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  static String _email;
  static String _password;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;

  final FocusNode focusPassword = FocusNode();

  final _formKey = GlobalKey<FormState>();

  handleEmail(String value) {
    Login._email = value.trim();
    print('Email -> ${Login._email}');
  }

  handlePassword(String value) {
    Login._password = value.trim();
    print('Password -> ${Login._password}');
  }

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

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 7) {
      return 'Password is too short';
    }
    return null;
  }

  Widget _emailTextField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: handleEmail,
      validator: validateEmail,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(focusPassword),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: 'Email address', labelStyle: GoogleFonts.quicksand()),
    );
  }

  Widget _passwordTextfield(BuildContext context) {
    return TextFormField(
      focusNode: focusPassword,
      keyboardType: TextInputType.text,
      validator: validatePassword,
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      onSaved: handlePassword,
      obscureText: hidePassword,
      decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: GoogleFonts.quicksand(),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            child: Icon(
              Icons.remove_red_eye,
            ),
          )),
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () {},
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () {},
            AssetImage(
              'assets/logos/google.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
            onPressed: () => print('I want to reset my password'),
            child: Text('Forgot Password?'))
      ],
    );
  }

  _loginBtnPressed() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Homepage(),
      ));
    }
  }

  Widget _loginButton(BuildContext context) {
    return MaterialButton(
      onPressed: _loginBtnPressed,
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

  Widget _appBar() {
    return AppBar(
      backgroundColor: Color(0xFFEDF0F6),
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 40),
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _intro(),
                  SizedBox(
                    height: 30,
                  ),
                  _emailTextField(context),
                  SizedBox(
                    height: 20,
                  ),
                  _passwordTextfield(context),
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
                  _buildSocialBtnRow(),
                  Center(
                    child: FlatButton(
                        onPressed: () => Navigator.of(context)
                            .push(SlideLeftTransition(page: SignUp())),
                        child: Text(
                          'Sign Up here',
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
