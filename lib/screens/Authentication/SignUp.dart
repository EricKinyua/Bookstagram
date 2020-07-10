import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  static String _firstName;
  static String _lastName;
  static String _userName;
  static String _email;
  static String _password;
  static String _retypePassword;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool hidePassword = true;

  final FocusNode focusLastName = FocusNode();

  final FocusNode focusUserName = FocusNode();

  final FocusNode focusEmail = FocusNode();

  final FocusNode focusPassword = FocusNode();

  final FocusNode focusRetypePassword = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwording = TextEditingController();

  final TextEditingController _confirmPass = TextEditingController();

  handleFirstName(String value) {
    SignUp._firstName = value.trim();
    print('First Name -> ${SignUp._firstName}');
  }

  handleLastName(String value) {
    SignUp._lastName = value.trim();
    print('Last Name -> ${SignUp._lastName}');
  }

  handleUserName(String value) {
    SignUp._userName = value.trim();
    print('User Name -> ${SignUp._userName}');
  }

  handleEmail(String value) {
    SignUp._email = value.trim();
    print('Email -> ${SignUp._email}');
  }

  handlePassword(String value) {
    SignUp._password = value.trim();
    print('Password -> ${SignUp._password}');
  }

  handleRetypePassword(String value) {
    SignUp._retypePassword = value.trim();
    print('Password(2) -> ${SignUp._retypePassword}');
  }

  String validateFirstName(String value) {
    if (value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String validateLastName(String value) {
    if (value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String validateUserName(String value) {
    if (value.isEmpty) {
      return 'Please enter a user name';
    }
    return null;
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

  String validateRetypePassword(String value) {
    if (value != _passwording.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Widget _namesRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _firstNameTextField(context),
        SizedBox(
          width: 10,
        ),
        _lastNameTextField(context)
      ],
    );
  }

  Widget _firstNameTextField(BuildContext context) {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.text,
        onSaved: handleFirstName,
        validator: validateFirstName,
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(focusLastName),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: 'First Name', labelStyle: GoogleFonts.quicksand()),
      ),
    );
  }

  Widget _lastNameTextField(BuildContext context) {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.text,
        focusNode: focusLastName,
        onSaved: handleLastName,
        validator: validateLastName,
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(focusUserName),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: 'Last Name', labelStyle: GoogleFonts.quicksand()),
      ),
    );
  }

  Widget _userNameTextField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      focusNode: focusUserName,
      onSaved: handleUserName,
      validator: validateUserName,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(focusEmail),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: 'User Name', labelStyle: GoogleFonts.quicksand()),
    );
  }

  Widget _emailTextField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: handleEmail,
      focusNode: focusEmail,
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
      textInputAction: TextInputAction.next,
      controller: _passwording,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(focusRetypePassword),
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

  Widget _retypePasswordTextfield(BuildContext context) {
    return TextFormField(
      focusNode: focusRetypePassword,
      keyboardType: TextInputType.text,
      validator: validateRetypePassword,
      controller: _confirmPass,
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      onSaved: handlePassword,
      obscureText: hidePassword,
      decoration: InputDecoration(
          labelText: 'Retype Password',
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

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFEDF0F6),
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _intro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
      ],
    );
  }

  _signUpBtnPressed() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    }
  }

  Widget _signUpBtn(BuildContext context) {
    return MaterialButton(
      onPressed: _signUpBtnPressed,
      color: Colors.black.withOpacity(0.4),
      padding: EdgeInsets.all(12),
      minWidth: MediaQuery.of(context).size.width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Text('Sign Up',
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
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 16, right: 16),
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _intro(),
                  SizedBox(
                    height: 30,
                  ),
                  _namesRow(context),
                  SizedBox(
                    height: 20,
                  ),
                  _userNameTextField(context),
                  SizedBox(
                    height: 20,
                  ),
                  _emailTextField(context),
                  SizedBox(
                    height: 20,
                  ),
                  _passwordTextfield(context),
                  SizedBox(
                    height: 20,
                  ),
                  _retypePasswordTextfield(context),
                  SizedBox(
                    height: 20,
                  ),
                  _signUpBtn(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
