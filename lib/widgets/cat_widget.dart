import 'package:flutter/material.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/res/dimens.dart';

class CatWidget extends StatelessWidget {
  const CatWidget({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    required this.colors,
  });
  final String title;
  final String iconPath;
  final Function() onTap;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(AppDimens.small),
            height: size.height * 0.1,
            width: size.height * 0.115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.medium),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.small),
              child: Image.network(iconPath),
            ),
          ),
          Text(title, style: LightAppTextStyle.title.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
