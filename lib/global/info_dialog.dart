import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoDialog extends StatelessWidget {
  final String message;
  InfoDialog({@required this.message});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.info,
            size: 100,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: GoogleFonts.quicksand(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.5),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
