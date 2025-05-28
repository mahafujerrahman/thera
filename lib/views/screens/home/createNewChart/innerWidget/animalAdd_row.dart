import 'package:flutter/material.dart';
import 'package:thera_track_app/utils/app_colors.dart';

class AnimalAddDetailsRow extends StatelessWidget {
  final String titelText;
  final TextEditingController controller;

  const AnimalAddDetailsRow({
    Key? key,
    required this.titelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                titelText,
                style: TextStyle(
                  color: AppColors.color424242,
                ),
              ),
            ),
            Text(
              ": ",
              style: TextStyle(
                color: AppColors.color424242,
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: "Type here",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
