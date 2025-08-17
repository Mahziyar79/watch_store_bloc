import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/dimens.dart';

class VerticalText extends StatelessWidget {
  const VerticalText({
    super.key,
    required this.onTap,
    required this.mainTitle,
    required this.subTitle,
  });
  final Function() onTap;
  final String mainTitle;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Transform.rotate(
                  angle: 1.5,
                  child: SvgPicture.asset(Assets.svg.back),
                ),
                AppDimens.small.width,
                Text(subTitle, style: LightAppTextStyle.title),
              ],
            ),
          ),
          AppDimens.medium.height,
          Text(mainTitle, style: LightAppTextStyle.amazingStyle),
        ],
      ),
    );
  }
}
