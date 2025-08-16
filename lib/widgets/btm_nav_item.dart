import 'package:flutter/material.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/res/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BtmNavItem extends StatelessWidget {
  final String iconSvgPath;
  final String title;
  final bool isActive;
  final void Function() onTap;
  const BtmNavItem({
    super.key,
    required this.iconSvgPath,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        color: AppColors.btmNavColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconSvgPath,
              colorFilter: ColorFilter.mode(
                isActive
                    ? AppColors.btmNavActiveItem
                    : AppColors.btmNavInActiveItem,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 4),
            Text(title, style: LightAppTextStyle.btmNavActive),
          ],
        ),
      ),
    );
  }
}
