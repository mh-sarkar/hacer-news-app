import 'package:firebase/firebase_io.dart';
import 'package:hacker_news_app/models/hn_item.dart';
import 'dart:async';

class HNRepository {
  FirebaseClient _client = FirebaseClient.anonymous();
  String _rootAPIPath = "https://hacker-news.firebaseio.com/v0/";

  static final HNRepository _singleton =
      HNRepository._internal();
  HNRepository._internal();

  factory HNRepository() {
    return _singleton;
  }

  Future<List<HNItem>> getComments(HNItem hnItem) async {
    if (hnItem.kids.length == 0) {
      return List();
    } else {
      var comments = await Future.wait(hnItem.kids.map((id) => getItem(id)));
      var nestedComments =
          await Future.wait(comments.map((comment) => getComments(comment)));
      for (var i = 0; i < nestedComments.length; i++) {
        comments[i].comments = nestedComments[i];
      }
      return comments;
    }
  }

  Future<HNItem> getItem(int id) async {
    var itemPath = "$_rootAPIPath/item/$id.json";
    var response = await _client.get(itemPath);
    return HNItem.fromJson(response);
  }

  Future<List<dynamic>> getTopStories() async {
    var path = 'topstories';
    var fullPath = "$_rootAPIPath$path.json";
    var response = await _client.get(fullPath);
    return response;
  }
}
