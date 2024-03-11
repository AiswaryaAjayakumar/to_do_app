// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:to_do_app/utils/color_constants.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget(
      {super.key,
      required this.title,
      required this.des,
      required this.date,
      required this.todoColor,
      this.onDeletePressed,
      this.onEditPressed});

  final String title;
  final String des;
  final String date;
  final Color todoColor;

  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color: widget.todoColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorConstants.customColorWhite)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: ColorConstants.customColorYellow,
                    checkColor: ColorConstants.customColorPurple,
                    value: isChecked,
                    onChanged: (value) {
                      if (value != null) {
                        isChecked = value;
                      }
                      setState(() {});
                    },
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: ColorConstants.customColorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: widget.onEditPressed,
                      icon: Icon(
                        Icons.edit,
                        color: ColorConstants.customColorWhite,
                      )),
                  IconButton(
                      onPressed: widget.onDeletePressed,
                      icon: Icon(
                        Icons.delete,
                        color: ColorConstants.customColorWhite,
                      ))
                ],
              ),
              Text(
                widget.des,
                style: TextStyle(color: ColorConstants.customColorWhite),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(color: ColorConstants.customColorWhite),
                  ),
                  IconButton(
                      onPressed: () {
                        Share.share("${widget.title}\n${widget.des}");
                      },
                      icon: Icon(
                        Icons.share,
                        color: ColorConstants.customColorWhite,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
