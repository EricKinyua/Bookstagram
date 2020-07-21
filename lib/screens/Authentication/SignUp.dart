import 'package:Bookstagram/global/utilities/dialogs.dart';
import 'package:Bookstagram/models/single_user_model.dart';
import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
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

  static String _firstName;
  static String _lastName;
  static String _userName;
  static String _email;
  static String _password;
  static String _retypePassword;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwording = TextEditingController();

  final TextEditingController _confirmPass = TextEditingController();

  static dynamic result;

  dynamic userProvider;

  handleFirstName(String value) {
    _firstName = value.trim();
    print('First Name -> $_firstName');
  }

  handleLastName(String value) {
    _lastName = value.trim();
    print('Last Name -> $_lastName');
  }

  handleUserName(String value) {
    _userName = value.trim();
    print('User Name -> $_userName');
  }

  handleEmail(String value) {
    _email = value.trim();
    print('Email -> $_email');
  }

  handlePassword(String value) {
    _password = value.trim();
    print('Password -> $_password');
  }

  handleRetypePassword(String value) {
    _retypePassword = value.trim();
    print('Password(2) -> $_retypePassword');
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

  Future<bool> serverCall(SingleUserModel user) async {
    result = await AuthProvider.instance().createUserEmailPass(user);
    print('This is the result: $result');

    if (result == 'Your password is weak. Please choose another') {
      return false;
    } else if (result == "The email format entered is invalid") {
      return false;
    } else if (result == "An account with the same email exists") {
      return false;
    } else if (result == null) {
      result = "Please check your internet connection";
      return false;
    } else {
      return true;
    }
  }

  _signUpBtnPressed() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      String fullName = _firstName + " " + _lastName;
      SingleUserModel user = new SingleUserModel(
          email: _email,
          password: _password,
          name: fullName,
          username: _userName);
      serverCall(user).then((value) {
        if (value) {
          print(value);
        } else {
          dialogInfo(context, result);
        }
      }).catchError((error) {
        dialogInfo(context, error.toString());
      });
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
    return Consumer<AuthProvider>(
      builder: (context, AuthProvider value, child) {
        userProvider = value;
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
                      value.status == Status.Authenticating
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            ))
                          : _signUpBtn(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
