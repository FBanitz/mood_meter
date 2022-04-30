// This software uses the CC BY-SA 4.0 license (https://creativecommons.org/licenses/by-sa/4.0/legalcode).

import 'package:flutter/material.dart';

class MoodGraph extends StatefulWidget {
  const MoodGraph({ Key? key }) : super(key: key);

  @override
  State<MoodGraph> createState() => _MoodGraphState();
}

class _MoodGraphState extends State<MoodGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Graph'),
      ),
      body: Center(

      ),
    );
  }
}