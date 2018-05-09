import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';


void main() {
  runApp(new MaterialApp(
      home: new YoutubeSearch()
  ));
}

class YoutubeSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SearchState();
  }
}

class SearchState extends State<YoutubeSearch> {
  SearchBar searchBar;
  static String key = 'YOUR_YOUTUBE_KEY';
  List<YT_API> _result = [];

  void Search(String value) async {
    String q = value ?? "google";
    print(value);
    YoutubeAPI youtubeAPI = new YoutubeAPI(key);
    _result = await youtubeAPI.Search(q);
    setState(() {

    });
  }


  SearchState() {
    searchBar = new SearchBar(
      inBar: true,
      setState: setState,
      onSubmitted: Search,
      buildDefaultAppBar: buildAppBar,
      showClearButton: false,
      clearOnSubmit: true,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      body: new Container(
        child: ListView.builder(
            itemCount: _result.length,
            itemBuilder: (_, int index) => ListItem(index)
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        child: new Icon(Icons.bug_report),
        tooltip: "Report Bug",
      ),
    );
  }
  Widget ListItem(index){
    return new Card(
      child: new Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child:new Row(
          children: <Widget>[
            new Image.network(_result[index].thumbnail['default']['url'],),
            new Padding(padding: EdgeInsets.only(right: 20.0)),
            new Expanded(child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    _result[index].title,
                    softWrap: true,
                    style: TextStyle(fontSize:18.0),
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: 1.5)),
                  new Text(
                    _result[index].channelTitle,
                    softWrap: true,
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: 3.0)),
                  new Text(
                    _result[index].url,
                    softWrap: true,
                  ),
                ]
            ))
          ],
        ),
      ),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('My Home Page'),
        actions: [searchBar.getSearchAction(context)]
    );
  }

}