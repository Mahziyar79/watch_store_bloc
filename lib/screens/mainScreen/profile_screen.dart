import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/surface_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(AppStrings.profile, style: LightAppTextStyle.title),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppDimens.large.height,

                  ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.asset(Assets.png.avatar.path),
                  ),
                  AppDimens.medium.height,
                  Text('علیرضا حیدری', style: LightAppTextStyle.avatarText),
                  AppDimens.medium.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppStrings.activeAddress,
                      style: LightAppTextStyle.title,
                    ),
                  ),
                  AppDimens.small.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svg.leftArrow),
                        AppDimens.medium.width,
                        Expanded(
                          child: Text(
                            AppStrings.lorem,
                            style: LightAppTextStyle.title,
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppDimens.medium.height,

                  Container(
                    height: 2,
                    color: AppColors.surfaceColor,
                    width: double.infinity,
                  ),
                  AppDimens.medium.height,
                  ProfileItem(
                    svgIcon: Assets.svg.leftArrow,
                    content: 'علیرضا حیدری',
                  ),
                  ProfileItem(svgIcon: Assets.svg.cart, content: '32'),
                  ProfileItem(svgIcon: Assets.svg.phone, content: '0947392742'),
                  AppDimens.medium.height,
                  SurfaceContainer(
                    margin: 0,
                    child: Text(
                      'قوانین',
                      style: LightAppTextStyle.title,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, required this.svgIcon, required this.content});

  final String svgIcon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.small),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            AppDimens.medium.width,
            Expanded(
              child: Text(
                content,
                style: LightAppTextStyle.title,
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.right,
              ),
            ),
            AppDimens.small.width,
            SvgPicture.asset(svgIcon),
          ],
        ),
      ),
    );
  }
}
