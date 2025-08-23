import 'package:flutter/material.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/widgets/app_slider.dart';
import 'package:watch_store/widgets/cat_widget.dart';
import 'package:watch_store/widgets/product_item.dart';
import 'package:watch_store/widgets/search_bar.dart';
import 'package:watch_store/widgets/vertical_text.dart';

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
              AppDimens.large.height,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.medium,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return ProductItem(
                              productName: 'ساعت مردانه',
                              price: 120000,
                              discount: 43,
                              oldPrice: 312,
                              time: 432,
                            );
                          },
                        ),
                      ),
                      VerticalText(
                        mainTitle: AppStrings.amazing,
                        onTap: () {},
                        subTitle: AppStrings.viewAll,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
