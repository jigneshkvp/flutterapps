import 'package:flutter/material.dart';
import 'package:my_app/model/questions.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Question> questionBank = [
    Question.name(
        "The U.S. Declaration of Independence was adopted in 1776.", true),
    Question.name("The Supreme law of the land is the Constitution.", true),
    Question.name(
        "The two rights in the Declaration of Independence are:"
        "  \n Life  "
        "  \n Pursuit of happiness.",
        true),
    Question.name("The (U.S.) Constitution has 26 Amendments.", false),
    Question.name(
        "Freedom of religion means:\nYou can practice any religion, "
        "or not practice a religion.",
        true),
    Question.name("Journalist is one branch or part of the government.", false),
    Question.name("The Congress does not make federal laws.", false),
    Question.name("There are 100 U.S. Senators.", true),
    Question.name("We elect a U.S. Senator for 4 years.", false), //6
    Question.name("We elect a U.S. Representative for 2 years", true),
    Question.name(
        "A U.S. Senator represents all people of the United States", false),
    Question.name("We vote for President in January.", false),
    Question.name("Who vetoes bills is the President.", true),
    Question.name("The Constitution was written in 1787.", true),
    Question.name('George Bush is the \ " Father of Our Country " \.', false)
  ];

  var _currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('True Citizen'),
        centerTitle: true,
        //backgroundColor: Colors.blueGrey,
      ),
      //backgroundColor: Colors.blueGrey,
      body: Builder(
          builder: (BuildContext context) => Column(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      "images/flag.png",
                      height: 180,
                      width: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.blueGrey.shade400,
                              style: BorderStyle.solid)),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          questionBank[_currentQuestionIndex].questionText,
                          //style: TextStyle(fontSize: 16.9, color: Colors.white),
                        ),
                      )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => _checkAnswer(true, context),
                        //color: Colors.grey.shade100,
                        child: Text(true.toString().toUpperCase()),
                      ),
                      RaisedButton(
                        onPressed: () => _checkAnswer(false, context),
                        //color: Colors.grey.shade100,
                        child: Text(false.toString().toUpperCase()),
                      ),
                      // RaisedButton(
                      //   onPressed: () => _nextQuestion(),
                      //   color: Colors.grey.shade100,
                      //   child: Icon(Icons.arrow_right),
                      // )
                    ],
                  )
                ],
              )),
    );
  }

  _checkAnswer(bool usersChoice, BuildContext context) {
    var isCorrect =
        (usersChoice == questionBank[_currentQuestionIndex].isCorrect);
    var textStyle = TextStyle(color: Colors.white);

    final snackbar = SnackBar(
      elevation: 25.0,
      content: isCorrect
          ? Text(
              'Correct',
              style: textStyle,
            )
          : Text(
              'Incorrect',
              style: textStyle,
            ),
      backgroundColor: isCorrect ? Colors.green : Colors.red,
      duration: Duration(milliseconds: 200),
    );

    Scaffold.of(context).showSnackBar(snackbar);
    //_nextQuestion();
    Future.delayed(Duration(milliseconds: 700), () => _nextQuestion());
  }

  _nextQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % questionBank.length;
    });
  }
}
