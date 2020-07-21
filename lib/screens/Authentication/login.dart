import 'package:Bookstagram/global/transitions.dart';
import 'package:Bookstagram/global/utilities/dialogs.dart';
import 'package:Bookstagram/models/single_user_model.dart';
import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:Bookstagram/screens/Authentication/SignUp.dart';
import 'package:Bookstagram/widgets/social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;

  final FocusNode focusPassword = FocusNode();

  final _formKey = GlobalKey<FormState>();

  static dynamic result;

  static String _email;
  static String _password;

  static dynamic userProvider;

  handleEmail(String value) {
    _email = value.trim();
    print('Email -> $_email');
  }

  handlePassword(String value) {
    _password = value.trim();
    print('Password -> $_password');
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

  Future<bool> serverCall(SingleUserModel user) async {
    result = await userProvider.signInEmailPass(user);
    print('This is the result: $result');

    if (result == 'Invalid credentials. Please try again') {
      return false;
    } else if (result == "The email format entered is invalid") {
      return false;
    } else if (result == "Please register first") {
      return false;
    } else if (result == "Your account has been disabled") {
      return false;
    } else if (result == "Too many requests. Please try again in 2 minutes") {
      return false;
    } else if (result ==
        "Please verify your email. We sent you an email earlier") {
      return false;
    } else {
      return true;
    }
  }

  _loginBtnPressed() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      SingleUserModel user =
          new SingleUserModel(email: _email, password: _password);
      serverCall(user).then((value) {
        if (value) {
          print(value);
        } else {
          dialogInfo(context, result);
        }
      }).catchError((error) {
        print(error);
        dialogInfo(context, error.toString());
      });
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
    );
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<AuthProvider>(context);
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
                  userProvider.status == Status.Authenticating
                      ? Center(
                          child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ))
                      : _loginButton(context),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Or Log in with',
                      style: GoogleFonts.quicksand(),
                    ),
                  ),
                  SocialButtons(),
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
