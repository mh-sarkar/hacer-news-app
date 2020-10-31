import 'package:flutter/material.dart';
import 'package:hacker_news_app/screens/home/components/home_body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: HomeBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Top 25 Stories"),
      elevation: 0,
      centerTitle: true,
    );
  }
}
