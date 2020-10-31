import 'package:flutter/material.dart';
import 'package:hacker_news_app/constants.dart';
import 'package:hacker_news_app/models/hn_item.dart';

import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends StatelessWidget {
  CommentCard({
    Key key,
    this.item,
  }) : super(key: key);
  final HNItem item;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(item.time * 1000);
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 6.0),
                child: Text(
                  item.by != null ? item.by : 'unknown',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.0, color: kTextColor,),
                ),
              ),
              Container(
                  child: Text(
                timeago.format(date),
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 17.0),
              )),
            ],
          )),
          Container(
            padding: EdgeInsets.only(top: 6.0),
            child: Text(
              item.text.isNotEmpty ? item.text : "Unavailable",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}
