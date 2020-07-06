import 'package:Bookstagram/models/single_book_model.dart';
import 'package:Bookstagram/models/single_comment_model.dart';
import 'package:Bookstagram/models/single_user_model.dart';

class SinglePostModel {
  SingleUserModel user;
  SingleBookModel book;
  List<SingleCommentModel> comments;
  int likes;

  SinglePostModel({this.user, this.book, this.comments, this.likes});
}

SingleUserModel userOne = new SingleUserModel(
    email: 'userOne@email.com',
    name: 'User One',
    password: '12345',
    photoUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80');

SingleBookModel bookOne = new SingleBookModel(
    title: 'Becoming',
    tagline: 'I am becoming',
    bookUrl:
        'https://images.unsplash.com/photo-1534523600533-71d091d911d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80');

SingleCommentModel commentOne =
    new SingleCommentModel(text: 'This is my first comment', user: userOne);

SingleCommentModel commentTwo =
    new SingleCommentModel(text: 'This is my second comment', user: userOne);

List<SingleCommentModel> comments = [commentOne, commentTwo];

SinglePostModel postOne = new SinglePostModel(
    book: bookOne, comments: comments, user: userOne, likes: 2515);

List<SinglePostModel> posts = [postOne, postOne, postOne];
