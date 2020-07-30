import 'dart:io';
import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:Bookstagram/provider/storage_provider.dart';
import 'package:Bookstagram/widgets/create_post.dart';
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
  String uid;

  StorageProvider storageProvider = StorageProvider();

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

  /// Select an image via gallery or camera
  Future<void> pickImage(ImageSource source) async {
    await ImagePicker.pickImage(source: source).then((value) {
      if (value != null) {
        setState(() {
          _imageFile = value;
        });

        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return CreatePost(
              file: _imageFile,
              uid: uid,
            );
          },
        );
      }
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
