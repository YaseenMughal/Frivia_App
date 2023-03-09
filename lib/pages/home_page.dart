import 'package:flutter/material.dart';

import 'package:friviaapp/pages/game_page.dart';

class friHomePage extends StatefulWidget {
  @override
  State<friHomePage> createState() => _friHomePageState();
}

class _friHomePageState extends State<friHomePage> {
  double? deviceHeight, deviceWidth;
  double currentDiffiLevel = 0;
  final List<String> diffiText = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appTitle(),
                DiffiSlider(),
                startButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appTitle() {
    return Column(
      children: [
        Text(
          "Frivia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          diffiText[currentDiffiLevel.toInt()],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget DiffiSlider() {
    return Slider(
        label: "Difficulty",
        min: 0,
        max: 2,
        divisions: 2,
        value: currentDiffiLevel,
        onChanged: (value) {
          setState(() {
            currentDiffiLevel = value;
          });
        });
  }

  Widget startButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return GamePage(
                DifficultyLevel:
                    diffiText[currentDiffiLevel.toInt()].toLowerCase(),
              );
            },
          ),
        );
      },
      color: Colors.blue,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
