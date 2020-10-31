import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/hn_item.dart';
import 'package:hacker_news_app/screens/details/comment-screen/comment_tab.dart';
import 'package:hacker_news_app/screens/details/content-screen/content_tab.dart';

import '../../constants.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key key,
    @required this.url,
    @required this.tab,
    @required this.descendants,
    @required this.item,
  }) : super(key: key);

  final String url;
  final int tab, descendants;
  final HNItem item;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: tab,
      child: Scaffold(
        appBar: buildAppBar(item.id),
        body: TabBarView(
          children: [
            ContentTab(url: url),
            CommentTab(item: item,),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(int id) {
    return AppBar(
        title: Text(id.toString()),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        bottom: TabBar(
          indicatorColor: kBackgroundColor,
          labelPadding: EdgeInsets.all(kDefaultPadding * .1),
          tabs: [
            Tab(child: Text("Content"),),
            Tab(child: Text("Comment($descendants)"),),
          ],
        ),
      );
  }
}
