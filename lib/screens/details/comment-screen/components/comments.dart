import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/hn_item.dart';
import 'package:hacker_news_app/screens/details/comment-screen/components/comment_card.dart';

class Comments extends StatelessWidget {
  final HNItem item;
  Comments({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = List<Widget>();
    children.add(CommentCard(
      item: item,
    ));
    if (item.comments.length > 0) {
      List<Widget> comments = item.comments
          .map((item) => Comments(
                item: item,
              ))
          .toList();

      children.add(
        Padding(
          padding: EdgeInsets.only(left: 1.0),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Container(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(children: comments),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: children);
  }
}
