import 'package:flutter/material.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/utils/fonts.dart';

// ignore: must_be_immutable
class PostTextField extends StatelessWidget {
  double hight = 35;
  final String hintText;
  PostTextField({super.key, required this.hight, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight,
      child: TextField(
        textAlign: TextAlign.start,
        maxLines: 5,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.borderColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.borderColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 12,
                fontFamily: FontFamily.poppins,
                color: ColorConstants.borderColor)),
        onChanged: (text) {},
      ),
    );
  }
}
