import 'package:flutter/material.dart';

abstract class Message {
  showMessage(String textToDisplay, BuildContext context) {
    final snackbar = SnackBar(content: Text(textToDisplay));

    Scaffold.of(context).showSnackBar(snackbar);
  }
}
