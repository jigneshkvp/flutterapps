import 'package:flutter/material.dart';
import 'package:my_app/model/post.dart';

import 'network.dart';

class JsonParserMap extends StatefulWidget {
  @override
  _JsonParserMapState createState() => _JsonParserMapState();
}

class _JsonParserMapState extends State<JsonParserMap> {
  Future<PostList> posts;

  @override
  void initState() {
    super.initState();
    var postsApi = Network("https://jsonplaceholder.typicode.com/posts");

    posts = postsApi.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Json Parser Map')),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: posts,
            builder: (context, AsyncSnapshot<PostList> snapshot) {
              List<Post> allPosts;

              if (snapshot.hasData) {
                allPosts = snapshot.data.posts;
                return _createListView(allPosts, context);
              }

              return Text('Error');
            },
          ),
        ),
      ),
    );
  }

  Widget _createListView(List<Post> data, BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(
                height: 5.0,
              ),
              ListTile(
                title: Text("${data[index].title}"),
                subtitle: Text("${data[index].body}"),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(
                        "${data[index].id}",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
