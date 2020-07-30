import 'package:Bookstagram/models/single_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SinglePostModel {
  SingleUserModel user;
  Map<String, dynamic> book;
  List<dynamic> comments;
  int likes = 0;
  String author;
  final Timestamp time = Timestamp.now();

  SinglePostModel(
      {this.user, this.book, this.comments, this.author, this.likes});

  factory SinglePostModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data;
    SingleUserModel user = new SingleUserModel(
        name: data['user']['name'], photoUrl: data['user']['photoUrl']);
    return SinglePostModel(
        author: data['author'],
        book: data['book'],
        comments: data['comments'],
        likes: data['likes'],
        user: user);
  }

  Map<String, dynamic> toFirestore() => {
        'book': book,
        'comments': comments,
        'likes': likes,
        'author': author,
        'time': time
      };
}
