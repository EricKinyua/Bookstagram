import 'dart:io';
import 'package:Bookstagram/global/utilities/dialogs.dart';
import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CustomFab extends StatefulWidget {
  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 55;

  File _imageFile;
  String filePath, urlResult;
  String uid;
  StorageUploadTask storageUploadTask;
  StorageTaskSnapshot taskSnapshot;

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: _curve)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -15.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget fabBtn() {
    return FloatingActionButton(
        backgroundColor: _animateColor.value,
        tooltip: 'Quick Menu',
        heroTag: 'fab',
        child: AnimatedIcon(
            icon: AnimatedIcons.menu_close, progress: _animateIcon),
        onPressed: animate);
  }

  Widget galleryBtn() {
    return Container(
      child: FloatingActionButton(
        onPressed: galleryBtnPressed,
        heroTag: 'gallery',
        tooltip: 'Gallery',
        child: Icon(Icons.storage),
      ),
    );
  }

  Future<String> startUpload(File file) async {
    /// Unique file name for the file
    DateTime now = DateTime.now();
    filePath = 'posts/$uid/${now.toLocal()}.png';
    //Create a storage reference
    StorageReference reference = FirebaseStorage.instance.ref().child(filePath);
    //Create a task that will handle the upload
    storageUploadTask = reference.putFile(
      file,
    );
    taskSnapshot = await storageUploadTask.onComplete;
    urlResult = await taskSnapshot.ref.getDownloadURL();
    return urlResult;
  }

  /// Select an image via gallery or camera
  Future<void> pickImage(ImageSource source) async {
    await ImagePicker.pickImage(source: source).then((value) {
      if (value != null) {
        setState(() {
          _imageFile = value;
        });
        _changePic();
      }
    });
  }

  Future _changePic() async {
    startUpload(_imageFile).then((value) {
      Firestore.instance
          .collection("posts")
          .document()
          .setData({"post": value, "author": uid, 'time': DateTime.now()});
    }).then((value) {
      dialogInfo(context, 'Your post has been created');
    });
  }

  void galleryBtnPressed() {
    pickImage(ImageSource.gallery);
  }

  void cameraBtnPressed() {
    pickImage(ImageSource.camera);
  }

  Widget cameraBtn() {
    return Container(
      child: FloatingActionButton(
        onPressed: cameraBtnPressed,
        heroTag: 'camera',
        tooltip: 'Camera',
        child: Icon(Icons.camera),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    uid = Provider.of<AuthProvider>(context).currentUser.uid;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 2.0, 0.0),
            child: galleryBtn()),
        Transform(
            transform:
                Matrix4.translationValues(0.0, _translateButton.value, 0.0),
            child: cameraBtn()),
        fabBtn()
      ],
    );
  }
}
