import 'package:flutter/material.dart';

import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';


class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key, required this.child});

  @override
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        padding: EdgeInsets.only(left: AppDimens.small, right: AppDimens.small),
        height: preferredSize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppDimens.medium),
            bottomRight: Radius.circular(AppDimens.medium),
          ),
          color: AppColors.appbar,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              offset: Offset(0, 2),
              blurRadius: 3,
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}