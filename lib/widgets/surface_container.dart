import 'package:flutter/material.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';

class SurfaceContainer extends StatelessWidget {
  const SurfaceContainer({
    super.key,
    required this.child,
    this.margin = AppDimens.small,
  });
  final double margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(margin, margin, margin, 0),
      padding: EdgeInsets.all(AppDimens.medium),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.medium),
        color: AppColors.surfaceColor,
      ),
      child: child,
    );
  }
}
