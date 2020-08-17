import 'package:flutter/material.dart';

import 'network.dart';

class JsonParserSimple extends StatefulWidget {
  @override
  _JsonParserSimpleState createState() => _JsonParserSimpleState();
}

class _JsonParserSimpleState extends State<JsonParserSimple> {
  Future data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json Parser'),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData)
                  return _createListView(snapshot.data, context);
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Future getData() async {
    return Network("https://jsonplaceholder.typicode.com/posts").getData();
  }

  Widget _createListView(List data, BuildContext context) {
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
                title: Text("${data[index]['title']}"),
                subtitle: Text("${data[index]['body']}"),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(
                        "${data[index]['id']}",
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
