import 'package:Bookstagram/global/transitions.dart';
import 'package:Bookstagram/models/single_post_model.dart';
import 'package:Bookstagram/screens/comments.dart';
import 'package:flutter/material.dart';

class SinglePostWidget extends StatelessWidget {
  final SinglePostModel model;
  SinglePostWidget({@required this.model});

  @override
  Widget build(BuildContext context) {
    print(model.toFirestore());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: double.infinity,
        height: 560,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
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
                            image: model.user.photoUrl == null
                                ? AssetImage('assets/logos/google.png')
                                : NetworkImage(model.user.photoUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      model.user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.black,
                      onPressed: () => print('More'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(SlideLeftTransition(
                        page: Comments(
                      model: model.comments,
                      user: model.user,
                    ))),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 5),
                            blurRadius: 8,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(model.book['bookUrl']),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  iconSize: 30,
                                  onPressed: () => print('Like Post'),
                                ),
                                Text(
                                  "${model.likes}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.chat),
                                  iconSize: 30,
                                  onPressed: () => Navigator.of(context).push(
                                      SlideLeftTransition(
                                          page: Comments(
                                              model: model.comments,
                                              user: model.user))),
                                ),
                                Text(
                                  "${model.comments.length}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark_border),
                          iconSize: 30,
                          onPressed: () => print('Save Post'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
