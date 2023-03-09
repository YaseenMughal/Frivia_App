import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:friviaapp/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final String DifficultyLevel;
  double? deviceHeight, deviceWidth;

  gamePageProvider? pageProvider;

  GamePage({required this.DifficultyLevel});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) =>
          gamePageProvider(context: context, difficultyLevel: DifficultyLevel),
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(builder: (context) {
      pageProvider = context.watch<gamePageProvider>();
      if (pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: deviceHeight! * 0.05),
              child: gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }
    });
  }

  Widget gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        questionText(),
        Column(
          children: [
            trueButton(),
            SizedBox(
              height: deviceHeight! * 0.01,
            ),
            falseButton(),
          ],
        ),
      ],
    );
  }

  Widget questionText() {
    return Text(
      pageProvider!.getCurrentQuesText(),
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 24),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider?.answerQusetion('True');
      },
      color: Colors.green,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child: const Text(
        'True',
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }

  Widget falseButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider?.answerQusetion("False");
      },
      color: Colors.red,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child: const Text(
        'False',
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }
}
