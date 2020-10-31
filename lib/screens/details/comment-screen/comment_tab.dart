import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/hn_item.dart';
import 'package:hacker_news_app/repositories/hn_repository.dart';
import 'package:hacker_news_app/screens/details/comment-screen/comment_header.dart';
import 'package:hacker_news_app/screens/details/comment-screen/components/comments.dart';

class CommentTab extends StatefulWidget {
  const CommentTab({this.item});
  final HNItem item ;
  @override
  _CommentTabState createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  HNRepository repository = HNRepository();
  Map<int, HNItem> comments = Map();

  Future<HNItem> getItemWithComments(int id) async {
    var item = await repository.getItem(id);
    item.comments = await repository.getComments(item);
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return (widget.item.kids.length == 0)
          ? ListView(
              children: <Widget>[
                CommentHeader(item: widget.item),
                Container(
                  padding: EdgeInsets.all(32.0),
                  child: Center(
                    child: Text("There are no comments available",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17.0)),
                  ),
                )
              ],
            )
            : ListView.builder(
              itemCount: 1 + widget.item.kids.length,
              itemBuilder: (BuildContext context, int position) {
                if (position == 0) {
                  return CommentHeader(item: widget.item);
                }

                return FutureBuilder(
                    future: getItemWithComments(widget.item.kids[position - 1]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (comments[position - 1] != null) {
                        var item = comments[position - 1];
                        return Comments(
                          item: item,
                          key: Key(item.id.toString()),
                        );
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        var item = snapshot.data;
                        comments[position - 1] = item;
                        return Comments(
                            item: item, key: Key(item.id.toString()));
                      } else if (snapshot.hasError) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: Text("Error Loading Item")),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    });
              },
            );
  }
}