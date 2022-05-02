// This software uses the CC BY-SA 4.0 license (https://creativecommons.org/licenses/by-sa/4.0/legalcode).

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_meter/controllers/mood_api.dart';
import 'package:mood_meter/screens/graph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    MoodAPI.getData().then((value) {
      debugPrint(value.toString());
    });
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 197, 132, 33),
        scaffoldBackgroundColor: const Color(0xFF303030),
        textTheme: const TextTheme(
        ),
      ),
      routes: {
        '/' : (_) => const MoodGraph(),
        // '/new_mood' : (_) => const NewMood(),
      },
      initialRoute: '/',
    );
  }
}
