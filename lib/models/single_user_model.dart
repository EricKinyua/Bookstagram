import 'package:cloud_firestore/cloud_firestore.dart';

class SingleUserModel {
  String name;
  String username;
  String email;
  String token;
  final Timestamp registerDate = Timestamp.now();
  Timestamp lastLogin;
  String password;
  String photoUrl;
  String gender;
  String uid;

  SingleUserModel(
      {this.name,
      this.email,
      this.password,
      this.lastLogin,
      this.gender,
      this.uid,
      this.photoUrl,
      this.username,
      this.token});

  factory SingleUserModel.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    return SingleUserModel(
        email: data['email'],
        name: data['name'],
        username: data['username'],
        photoUrl: data['photoUrl'],
        uid: data['uid']);
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'username': username,
        'email': email,
        'token': token,
        'registerDate': registerDate,
        'lastLogin': lastLogin,
        'photoUrl': photoUrl,
        'uid': uid,
        'gender': gender
      };
}
