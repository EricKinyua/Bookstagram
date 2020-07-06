import 'package:Bookstagram/models/single_comment_model.dart';
import 'package:Bookstagram/models/single_user_model.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final List<SingleCommentModel> model;
  final SingleUserModel user;
  Comments({@required this.model, @required this.user});

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  Widget singlePost(SingleCommentModel comment) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 2),
            blurRadius: 6,
          )
        ]),
        child: CircleAvatar(
          child: ClipOval(
            child: Image(
              height: 50,
              width: 50,
              image: NetworkImage(comment.user.photoUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        comment.user.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(comment.text),
      trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.grey,
          onPressed: () => print('Like Comment')),
    );
  }

  Widget newComment() {
    return TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.all(20),
          hintText: 'Add a comment',
          prefixIcon: Container(
            margin: EdgeInsets.all(4),
            width: 48,
            height: 48,
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(0, 2),
                blurRadius: 6,
              )
            ]),
            child: CircleAvatar(
              child: ClipOval(
                child: Image(
                  height: 50,
                  width: 50,
                  image: NetworkImage(widget.user.photoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          suffixIcon: Container(
            margin: EdgeInsets.only(right: 4),
            width: 70,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Color(0xFF23B66F),
              onPressed: () => print('Post Comment'),
              child: Icon(
                Icons.send,
                size: 25,
                color: Colors.white,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF0F6),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Color(0xFFEDF0F6),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView.builder(
          itemCount: widget.model.length,
          itemBuilder: (context, index) => singlePost(widget.model[index]),
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, -2), blurRadius: 6),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: newComment(),
          ),
        ),
      ),
    );
  }
}
