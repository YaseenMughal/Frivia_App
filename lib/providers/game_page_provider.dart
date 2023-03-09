import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class gamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final maxQues = 10;
  final String difficultyLevel;

  List? questions;
  int currentQuesCount = 0;
  int correctCount = 0;

  BuildContext context;
  gamePageProvider({required this.context, required this.difficultyLevel}) {
    dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuesFromAPI();
  }

  Future<void> _getQuesFromAPI() async {
    print(difficultyLevel);
    var response = await dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'Difficulty': difficultyLevel,
      },
    );
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuesText() {
    return questions![currentQuesCount]['question'];
  }

  void answerQusetion(String answer) async {
    bool isCorrect = questions![currentQuesCount]["correct_answer"] == answer;
    correctCount += isCorrect ? 1 :  0;
    currentQuesCount++;
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if (currentQuesCount == maxQues){
      endGame();
    }else{
      notifyListeners();
    }
    
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          backgroundColor: Colors.yellow,
          title: const Text(
            "End! Gamae",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          content: Text("Score : $correctCount/$maxQues"),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
