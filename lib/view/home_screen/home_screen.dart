

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

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = HomeScreenController();
  var myBox = Hive.box("todobox");

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
        centerTitle: true,
        title: Text("TODO LIST"),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.customColorWhite,
            fontSize: 28),
      ),
      body: homeScreenController.todoKeys.isEmpty
          ? Center(
              child: Text(
                "No data found",
                style: TextStyle(
                  color: ColorConstants.customColorWhite,
                ),
              ),
            )
          : ListView.separated(
              itemCount: homeScreenController.todoKeys.length,
              padding: EdgeInsets.all(15),
              itemBuilder: (context, index) {
                var element = myBox.get(homeScreenController.todoKeys[index]);
                return CustomWidget(
                  title: element["title"],
                  date: element["date"],
                  des: element["des"],
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

                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => CustomBottomSheet(
                              isEdit: true,
                              onSavePressed: () {
                           

                                homeScreenController.editData(
                                    homeScreenController.todoKeys[index]);
                                setState(() {});
                                HomeScreenController
                                    .clearController(); 

                                Navigator.pop(context);
                              },
                            ));
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),
    );
  }
}
