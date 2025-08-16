import 'package:flutter/material.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/res/dimens.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String prefixLabel;
  final String hint;
  final TextEditingController controller;
  final Widget? icon;
  final TextAlign textAlign;
  final TextInputType? inputType;
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.icon,
    this.textAlign = TextAlign.center,
    this.inputType,
    this.prefixLabel = '',
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(AppDimens.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: size.width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(prefixLabel, style: LightAppTextStyle.title),
                Text(label, style: LightAppTextStyle.title),
              ],
            ),
          ),
          AppDimens.small.height,
          SizedBox(
            height: size.height * 0.07,
            width: size.width * 0.75,
            child: TextField(
              textAlign: textAlign,
              controller: controller,
              keyboardType: inputType,
              decoration: InputDecoration(
                hintStyle: LightAppTextStyle.hint,
                hintText: hint,
                prefixIcon: icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
