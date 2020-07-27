import 'package:Bookstagram/global/info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future dialogInfo(BuildContext context, String message) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => AlertDialog(
      content: InfoDialog(message: message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
