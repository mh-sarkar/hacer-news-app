import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/hn_item.dart';
import 'package:hacker_news_app/screens/details/details_screen.dart';
import 'package:hacker_news_app/screens/home/components/thumbnail_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../constants.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    Key key,
    @required this.author,
    @required this.title,
    @required this.url,
    @required this.time,
    @required this.descendants,
    @required this.score,
    @required this.item,
  }) : super(key: key);

  final String author, title, url;
  final int time, descendants, score;
  final HNItem item;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(item: item, tab: 0, url: url, descendants: descendants,),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 4),
        width: size.width,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                spreadRadius: kDefaultPadding / 10,
                blurRadius: kDefaultPadding,
                offset: Offset(0, 10),
                color: kPrimaryColor.withOpacity(.2),
              ),
              BoxShadow(
                spreadRadius: kDefaultPadding / 10,
                blurRadius: kDefaultPadding,
                offset: Offset(0, -10),
                color: Colors.white.withOpacity(.5),
              ),
            ]),
        child: Row(
          children: [
            ThumbnailText(author: author),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${author != null ? author : 'unknown'} - ${timeago.format(date)}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2),
                        child: Text(
                          score.toString(),
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          url != null ? url : "-",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kDefaultPadding),
                        ),
                        color: kPrimaryColor,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(item: item, tab: 1, url: url, descendants: descendants,),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: kBackgroundColor,
                            ),
                            Text(
                              " ${descendants != null ? descendants : 0}",
                              style: TextStyle(
                                color: kBackgroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
