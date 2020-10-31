import 'package:flutter/material.dart';
import 'package:hacker_news_app/constants.dart';
import 'package:hacker_news_app/models/hn_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentHeader extends StatelessWidget {
  const CommentHeader({
    Key key,
    @required this.item,
  }) : super(key: key);

  final HNItem item;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(item.time * 1000);
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      width: size.width,
      decoration: BoxDecoration(
        color: kPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
              color: kBackgroundColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding / 4),
                  child: Text(
                    "${item.by} - ${timeago.format(date)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      color: kBackgroundColor,
                    ),
                  ),
                ),
              ),
              Text(
                item.score.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: kBackgroundColor,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding / 4),
            child: Text(
              item.url != null ? item.url : "-",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
