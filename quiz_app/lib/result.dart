import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function _resetQuiz;
  Result(this.resultScore,this._resetQuiz);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text("You did it! $resultScore",
          style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
          
        ),
        FlatButton(child: Text('Restart Quiz'),onPressed: _resetQuiz,)
      ],
    );
  }
}
