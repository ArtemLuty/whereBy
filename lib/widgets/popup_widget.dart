import 'package:flutter/material.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/utils/fonts.dart';
import 'package:whereby_app/utils/scalable_size.dart';
import 'package:whereby_app/widgets/app_button.dart';

class FileSavedPopup extends StatelessWidget {
  final String text;
  final String? textContent;
  final Function() onOkPressed;
  final Function() onCencelPressed;

  const FileSavedPopup({
    this.textContent,
    required this.text,
    required this.onOkPressed,
    required this.onCencelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1 / 3,
      widthFactor: 7 / 6,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Column(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: ColorConstants.mainText,
                    fontFamily: FontFamily.poppinsBold,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              if (textContent != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    context.getScalableWidth(8),
                    context.getScalableHeight(8),
                    context.getScalableWidth(8),
                    context.getScalableHeight(0),
                  ),
                  child: Text(
                    textContent.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: ColorConstants.mainText,
                        fontFamily: FontFamily.poppins,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.getScalableWidth(8),
              context.getScalableHeight(0),
              context.getScalableWidth(8),
              context.getScalableHeight(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35,
                  width: 145,
                  child: AppButton(
                    'Cancel',
                    onTap: onCencelPressed,
                    color: ColorConstants.buttonDeclineColor,
                    textColor: ColorConstants.mainText,
                    height: context.getScalableHeight(35),
                  ),
                ),
                const SizedBox(
                  width: 21,
                ),
                SizedBox(
                  height: 35,
                  width: 145,
                  child: AppButton(
                    'Yes, delete!',
                    onTap: onOkPressed,
                    color: ColorConstants.errorColor,
                    textColor: ColorConstants.appWhite,
                    height: context.getScalableHeight(35),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
