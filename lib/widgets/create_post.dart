import 'dart:io';

import 'package:Bookstagram/global/utilities/dialogs.dart';
import 'package:Bookstagram/models/single_book_model.dart';
import 'package:Bookstagram/models/single_post_model.dart';
import 'package:Bookstagram/provider/database_provider.dart';
import 'package:Bookstagram/provider/storage_provider.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  final File file;
  final String uid;
  CreatePost({@required this.file, @required this.uid});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  DatabaseProvider database = DatabaseProvider();
  StorageProvider storage = StorageProvider();

  final _formKey = GlobalKey<FormState>();
  String caption;

  handleCaption(String value) {
    caption = value;
    print('Caption -> $caption');
  }

  Widget _cancelPost() {
    return FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.cancel,
          size: 30,
          color: Colors.red,
        ));
  }

  uploadButtonPressed() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      String url = await storage.startUpload(widget.uid, widget.file);
      print(url);

      SingleBookModel book =
          new SingleBookModel(bookUrl: url, tagline: caption);
      print(book.toJson());

      SinglePostModel post = new SinglePostModel(
        author: widget.uid,
        book: book.toJson(),
        comments: [],
        likes: 0,
      );

      database
          .createPost(post)
          .catchError((error) => dialogInfo(context, error.toString()))
          .then((value) =>
              dialogInfo(context, 'Your post has been successsfully created'));
    }
  }

  Widget _uploadPost() {
    return FlatButton(
        onPressed: uploadButtonPressed,
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
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(widget.file)),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Write a caption...'),
                onSaved: handleCaption,
              )
            ],
          ),
        ),
      ),
    );
  }
}
