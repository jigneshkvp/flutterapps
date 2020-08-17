import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Hello, Flutter!',
        textDirection: TextDirection.ltr,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}