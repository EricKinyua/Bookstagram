import 'dart:io';

import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  final File file;
  final String uid;
  CreatePost({@required this.file, @required this.uid});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Widget _cancelPost() {
    return FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.cancel,
          size: 30,
          color: Colors.red,
        ));
  }

  Widget _uploadPost() {
    return FlatButton(
        onPressed: () {},
        child: Icon(
          Icons.send,
          size: 30,
          color: Colors.green,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        _cancelPost(),
        _uploadPost(),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(widget.file)
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Write a caption...'
                ),
              )
        ],
      ),
    );
  }
}
