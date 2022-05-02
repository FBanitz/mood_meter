// This software uses the CC BY-SA 4.0 license (https://creativecommons.org/licenses/by-sa/4.0/legalcode).

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_meter/controllers/mood_api.dart';
import 'package:mood_meter/widgets/slider.dart';

class NewMood extends StatelessWidget {
  const NewMood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    int _mood = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle Humeur'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:32, horizontal: 45),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 197, 132, 33,),
                      ),
                      focusColor: Color.fromARGB(255, 197, 132, 33,),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 197, 132, 33,),
                          width: 1.0,
                        ),
                      ),
                    ),
                    cursorColor: const Color.fromARGB(255, 197, 132, 33,),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SliderWidget(
                  onChanged: (value) {
                    _mood = (value*10).floor();
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 75,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Get.back(), 
                  child: const Text('Annuler'),
                ),
                ElevatedButton(
                  onPressed: () {
                    MoodAPI.postData(_nameController.text, _mood).catchError((error) {
                      Get.defaultDialog(
                        title: 'Erreur',
                        backgroundColor: const Color(0xFF303030),
                        content: Text(error.toString(), style: TextStyle(color: Colors.white),),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Get.back(),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
                    Get.back();
                  }, 
                  child: const Text('Ajouter'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}