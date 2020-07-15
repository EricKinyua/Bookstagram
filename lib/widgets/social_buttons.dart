import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  //Social Buttons
  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () {},
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          SizedBox(
            width: 10,
          ),
          _buildSocialBtn(
            () {
              AuthProvider.instance().signInWithGoogle();
            },
            AssetImage(
              'assets/logos/google.png',
            ),
          ),
        ],
      ),
    );
  }
}
