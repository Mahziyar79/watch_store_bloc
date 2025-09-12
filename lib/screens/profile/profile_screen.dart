import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/repo/user_repo.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/auth/cubit/auth_cubit.dart';
import 'package:watch_store/screens/profile/bloc/profile_bloc.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/surface_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final profileBloc = ProfileBloc(userRepository);
        profileBloc.add(ProfileInitEvent());
        return profileBloc;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(AppStrings.profile, style: LightAppTextStyle.title),
            ),
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoadedState) {
                return SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.large,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppDimens.large.height,

                          ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: Image.asset(Assets.png.avatar.path),
                          ),
                          AppDimens.medium.height,
                          Text(
                            state.userInfoList.userInfo.name,
                            style: LightAppTextStyle.avatarText,
                          ),
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
                                    state
                                            .userInfoList
                                            .userInfo
                                            .address
                                            ?.address ??
                                        "آدرسی ثبت نشده است",
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
                            content: state.userInfoList.userInfo.name,
                          ),
                          ProfileItem(
                            svgIcon: Assets.svg.cart,
                            content: state.userInfoList.userReceivedCount
                                .toString(),
                          ),
                          ProfileItem(
                            svgIcon: Assets.svg.phone,
                            content: state.userInfoList.userInfo.mobile,
                          ),
                          AppDimens.medium.height,
                          SurfaceContainer(
                            margin: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'قوانین',
                                  style: LightAppTextStyle.title,
                                  textAlign: TextAlign.right,
                                ),
                                AppDimens.small.height,
                                Text(
                                  AppStrings.lorem,
                                  style: LightAppTextStyle.title,
                                  textAlign: TextAlign.right,
                                ),
                                 AppDimens.small.height,
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateColor.resolveWith((
                                            states,
                                          ) {
                                            return AppColors.discountBg;
                                          }),
                                    ),
                                    onPressed: () async {
                                      if (!context.mounted) return;
                                      await context.read<AuthCubit>().logout();
                                    },
                                    child: Text(
                                      'خروج از حساب کاربری',
                                      style: LightAppTextStyle.tagTitle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is ProfileErrorState) {
                return Center(child: Text("مشکلی پیش اومده، دوباره تلاش کنید"));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
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
