// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/controller/home_screen_controller.dart';
import 'package:to_do_app/utils/color_constants.dart';
import 'package:to_do_app/view/home_screen/widgets/custom_bottom_sheet.dart';
import 'package:to_do_app/view/home_screen/widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

HomeScreenController homeScreenController = HomeScreenController();

class _HomeScreenState extends State<HomeScreen> {
  var myBox = Hive.box('todobox');

  @override
  void initState() {
    homeScreenController.init();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.customColorBlack,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.customColorPurple,
        onPressed: () {
          HomeScreenController.clearController();
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => CustomBottomSheet(
                    onSavePressed: () {
                      homeScreenController.addData();
                      setState(() {});
                      HomeScreenController.clearController();
                      Navigator.pop(context);
                    },
                  ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: ColorConstants.customColorBlack,
        title: Text(
          "To Do List",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: ColorConstants.customColorWhite),
        ),
      ),
      body: homeScreenController.todoKeys.isEmpty
          ? Center(
              child: Text(
                "No data found",
                style: TextStyle(color: ColorConstants.customColorWhite),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var element = myBox.get(homeScreenController.todoKeys[index]);
                return CustomWidget(
                  title: element["title"],
                  des: element["des"],
                  date: element["date"],
                  todoColor: element["color"] != null
                      ? HomeScreenController.customColorList[element["color"]]
                      : Colors.white,
                  onDeletePressed: () {
                    homeScreenController
                        .deleteData(homeScreenController.todoKeys[index]);
                    setState(() {});
                  },
                  onEditPressed: () {
                    HomeScreenController.titleController.text =
                        element["title"];
                    HomeScreenController.desController.text = element["des"];
                    HomeScreenController.dateController.text = element["date"];
                    homeScreenController.colorSelection(element["color"]);
                  },
                );
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => CustomBottomSheet(
                    isEdit: true,
                    onSavePressed: () {
                      homeScreenController
                          .editData(homeScreenController.todoKeys[index]);
                      setState(() {});
                      HomeScreenController.clearController();
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
              itemCount: homeScreenController.todoKeys.length),
    );
  }
}
