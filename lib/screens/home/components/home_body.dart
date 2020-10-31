import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/hn_item.dart';
import 'package:hacker_news_app/repositories/hn_repository.dart';
import 'package:hacker_news_app/screens/home/components/story_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  HNRepository repository = HNRepository();
  bool _isLoading = false;
  String _errorLoading;
  List<dynamic> _id = [];
  Map<int, HNItem> items = Map();

  @override
  void initState() {
    super.initState();
    loadTopStories();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
      loadTopStories();
  }

  void loadTopStories() async {
    setState(() {
      _id = [];
      items = Map();
      _isLoading = true;
      _errorLoading = null;
    });
    try {
      var id = await repository.getTopStories();
      setState(() {
        _isLoading = false;
        _id = id.toList();
      });
    _refreshController.loadComplete();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorLoading = "Failed to load";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _errorLoading != null
        ? Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text(
                _errorLoading,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
              ),
            ),
          )
        : _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CircularProgressIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
                child: ListView.builder(
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder(
                      future: repository.getItem(_id[index]),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          var item = snapshot.data;
                          items[index] = item;
                          return StoryCard(
                            item: item,
                            author: item.by,
                            descendants: item.descendants,
                            score: item.score,
                            time: item.time,
                            title: item.title,
                            url: item.url,
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                            padding: EdgeInsets.all(32.0),
                            child: Center(
                              child: Text(
                                "Error loading story ${_id[index]}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.all(32.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              );
  }
}
// StoryCard(size: size, name: name, date: date),
