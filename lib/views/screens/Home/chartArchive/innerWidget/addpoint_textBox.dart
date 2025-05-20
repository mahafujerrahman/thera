import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/clientController/service_controller.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';


class TextBoxList extends StatefulWidget {
  @override
  _TextBoxListState createState() => _TextBoxListState();
}

class _TextBoxListState extends State<TextBoxList> {
  List<TextBox> textBoxes = [];
  ServiceController serviceController = Get.put(ServiceController());

  void addTextBox() {
    setState(() {
      int newIndex = textBoxes.length;
      TextEditingController newController = TextEditingController();
      serviceController.pointList.add("");
      textBoxes.add(TextBox(
        index: newIndex,
        controller: newController,
        onRemove: removeTextBox,
        onTextChanged: (text) => updateTextValue(newIndex, text),
      ));
    });
  }

  void removeTextBox(int index) {
    setState(() {
      textBoxes.removeAt(index);
      serviceController.pointList.removeAt(index);

      // Update indexes
      for (int i = 0; i < textBoxes.length; i++) {
        textBoxes[i].setIndex(i);
      }
    });
  }

  void updateTextValue(int index, String value) {
    setState(() {
      serviceController.pointList[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with the "Add Point" button
          Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Point'),
                  InkWell(
                    onTap: () {
                      addTextBox();
                    },
                    child: SvgPicture.asset(AppIcons.addIcon),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              children: textBoxes.isEmpty
                  ? [Text('No point added yet')]
                  : textBoxes,
            ),
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatefulWidget {
  int index;
  final Function(int) onRemove;
  final Function(String) onTextChanged;
  final TextEditingController controller;

  TextBox({
    required this.index,
    required this.onRemove,
    required this.onTextChanged,
    required this.controller,
  });

  void setIndex(int i) {
    index = i;
  }

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  void initState() {
    super.initState();
  }

  void setIndex(int newIndex) {
    setState(() {
      widget.index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.secondaryColor),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        onChanged: widget.onTextChanged,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '${widget.index + 1}. Text',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.whiteColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          widget.onRemove(widget.index);
                        },
                        child: SvgPicture.asset(AppIcons.removeIcon),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
