import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreenController {
  static TextEditingController titleController = TextEditingController();
  static TextEditingController desController = TextEditingController();
  static TextEditingController dateController = TextEditingController();

  static List customColorList = [
    const Color.fromARGB(255, 240, 197, 212),
    const Color.fromARGB(255, 153, 176, 196),
    const Color.fromARGB(255, 193, 237, 194),
    const Color.fromARGB(255, 238, 150, 150),
  ];

  // Color selectedColor = Colors.white;
  List noteList = [];
  List todoKeys = [];
  static int selectedColorIndex = 0;

  var myBox = Hive.box('todobox');

  static void clearController() {
    titleController.clear();
    desController.clear();
    dateController.clear();
  }

  void addData() {
    myBox.add({
      "title": titleController.text,
      "des": desController.text,
      "date": dateController.text,
      "color": selectedColorIndex
    });
    todoKeys = myBox.keys.toList();
  }

  void editData(var key) {
    myBox.put(key, {
      "title": titleController.text,
      "des": desController.text,
      "date": dateController.text,
      "color": selectedColorIndex
    });
  }

  void colorSelection(int newColor) {
    selectedColorIndex = newColor;
  }

  void deleteData(var key) {
    myBox.delete(key);
    todoKeys = myBox.keys.toList();
  }

  init() {
    todoKeys = myBox.keys.toList();
  }
}
