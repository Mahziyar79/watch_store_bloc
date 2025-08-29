import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/auth/cubit/auth_cubit.dart';
import 'package:watch_store/utils/format_time.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/widgets/main_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().startTimer();
  }

  @override
  void dispose() {
    context.read<AuthCubit>().stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serverCode = context.watch<AuthCubit>().serverCode;

    final mobileRouteArg = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Assets.png.mainLogo.path),
              AppDimens.large.height,
              Text(
                AppStrings.otpCodeSendFor.replaceAll(
                  AppStrings.replace,
                  mobileRouteArg,
                ),
                style: LightAppTextStyle.title,
              ),
              AppDimens.small.height,
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppStrings.wrongNumberEditNumber,
                  style: LightAppTextStyle.primaryThemeTextStyle,
                ),
              ),
              AppDimens.large.height,
              Visibility(
                visible: serverCode != null,
                child: Text("کد دریافتی از سرور: $serverCode"),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  String timeText = "";
                  if (state is TimerTickState) {
                    timeText = formatTime(state.remainingSeconds);
                  } else if (state is TimerFinishedState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pop();
                      context.read<AuthCubit>().stopTimer();
                    });
                  } else {
                    timeText = formatTime(120);
                  }

                  return AppTextField(
                    label: AppStrings.enterVerificationCode,
                    hint: AppStrings.hintVerificationCode,
                    controller: _controller,
                    prefixLabel: timeText,
                  );
                },
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is VerifiedIsRegisterState) {
                    // cancel Timer
                    context.read<AuthCubit>().stopTimer();
                    Navigator.pushNamed(context, ScreenNames.mainScreen);
                  } else if (state is VerifiedNotRegisteState) {
                    // cancel Timer
                    context.read<AuthCubit>().stopTimer();
                    Navigator.pushNamed(context, ScreenNames.registerScreen);
                  } else if (state is ErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return MainButton(
                    text: AppStrings.next,
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(
                        context,
                      ).verifySms(mobileRouteArg, _controller.text);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
