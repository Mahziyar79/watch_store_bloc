import 'dart:io';

import 'package:flutter/material.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.onTap, this.file});

  final Function()? onTap;
  final File? file;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            width: size.width * 0.2,
            height: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: (file == null)
                  ? Image.asset(Assets.png.avatar.path)
                  : Image.file(file!, fit: BoxFit.cover),
            ),
          ),
          AppDimens.medium.height,
          Text(
            AppStrings.chooseProfileImage,
            style: LightAppTextStyle.avatarText,
          ),
        ],
      ),
    );
  }
}
