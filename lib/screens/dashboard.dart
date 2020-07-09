import 'package:Bookstagram/models/single_post_model.dart';
import 'package:Bookstagram/widgets/singlePost.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: false,
      itemCount: posts.length,
      itemBuilder: (context, index) => SinglePostWidget(model: posts[index]),
    );
  }
}
