import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key,required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.medium),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                offset: Offset(0, 3),
                blurRadius: 3,
              ),
            ],
          ),
          height: 52,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(Assets.svg.search),
              Text(AppStrings.searchProduct, style: LightAppTextStyle.hint),
              Padding(
                padding: const EdgeInsets.all(AppDimens.small),
                child: Image.asset(Assets.png.mainLogo.path),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
