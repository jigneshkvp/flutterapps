import 'package:flutter/material.dart';

class Wisdom extends StatefulWidget {
  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index = 0;

  List _quotes = [
    "You know you’re in love when you can’t fall asleep because reality is finally better than your dreams",
    "Get busy living or get busy dying.",
    "The first step toward success is taken when you refuse to be a captive of the environment in which you first find yourself",
    "When one door of happiness closes, another opens; but often we look so long at the closed door that we do not see the one which has been opened for us.",
    "Twenty years from now you will be more disappointed by the things that you didn’t do than by the ones you did do"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                    child: Text(
                  _quotes[_index % _quotes.length],
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),
                )),
              ),
              Divider(
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton.icon(
                        onPressed: _showQuote,
                        color: Colors.lightGreen,
                        icon: Icon(Icons.lightbulb_outline),
                        label: Text('Inspire Me')),
                  ),
                ],
              ),
              Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showQuote() {
    setState(() {
      _index++;
    });
  }
}
