import 'package:flutter/material.dart';

class HomeScaffold extends StatelessWidget {
  _searchButtonEvent() => debugPrint('Search button invoked');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue.shade500,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchButtonEvent,
          )
        ],
      ),
      backgroundColor: Colors.grey.shade50,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CustomButton()],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackbar = SnackBar(
          content: Text(
            'Thanks for your feedback!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );

        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade400,
            borderRadius: BorderRadius.circular(5.0)),
        child: Text(
          'Feedback',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,
      child: Center(
        child: Text(
          'Hello, Flutter.',
          textDirection: TextDirection.ltr,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
