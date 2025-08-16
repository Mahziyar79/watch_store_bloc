import 'package:flutter/material.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/widgets/app_slider.dart';
import 'package:watch_store/widgets/cat_widget.dart';
import 'package:watch_store/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              MySearchBar(onTap: () {}),
              AppSlider(imgList: []),
              // Category
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CatWidget(
                    title: AppStrings.classic,
                    colors: AppColors.catClassicColors,
                    iconPath: Assets.svg.clasic,
                    onTap: () {},
                  ),
                  CatWidget(
                    title: AppStrings.smart,
                    colors: AppColors.catSmartColors,
                    iconPath: Assets.svg.smart,
                    onTap: () {},
                  ),
                  CatWidget(
                    title: AppStrings.digital,
                    colors: AppColors.catDigitalColors,
                    iconPath: Assets.svg.digital,
                    onTap: () {},
                  ),
                  CatWidget(
                    title: AppStrings.desktop,
                    colors: AppColors.catDesktopColors,
                    iconPath: Assets.svg.desktop,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
