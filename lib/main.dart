import 'package:flutter/material.dart';

import 'package:friviaapp/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frivia',
      theme: ThemeData(
        fontFamily: "ArchitectsDaughter",
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
      ),
      home: friHomePage(),
    );
  }
}
