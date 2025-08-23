import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/utils/image_handler.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/widgets/avatar.dart';
import 'package:watch_store/widgets/main_button.dart';
import 'package:watch_store/widgets/registration_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameLastNamecontroller = TextEditingController();

  final ImageHandler imageHandler = ImageHandler();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: RegistrationAppBar(),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Avatar(
                  onTap: () async => await imageHandler
                      .pickAndCropImage(source: ImageSource.camera)
                      .then((value) {
                        setState(() {
                          
                        });
                      }),
                      file: imageHandler.getImage,
                ),
                AppDimens.medium.height,
                AppTextField(
                  label: AppStrings.nameLastName,
                  hint: AppStrings.hintNameLastName,
                  controller: _nameLastNamecontroller,
                ),
                AppTextField(
                  label: AppStrings.homeNumber,
                  hint: AppStrings.hintHomeNumber,
                  controller: _nameLastNamecontroller,
                ),
                AppTextField(
                  label: AppStrings.address,
                  hint: AppStrings.hintAddress,
                  controller: _nameLastNamecontroller,
                ),
                AppTextField(
                  label: AppStrings.postalCode,
                  hint: AppStrings.hintPostalCode,
                  controller: _nameLastNamecontroller,
                ),
                AppTextField(
                  label: AppStrings.location,
                  hint: AppStrings.hintLocation,
                  controller: _nameLastNamecontroller,
                  icon: Icon(Icons.location_on),
                ),
                AppDimens.medium.height,
                MainButton(
                  text: AppStrings.next,
                  onPressed: () =>
                      Navigator.pushNamed(context, ScreenNames.mainScreen),
                ),
                AppDimens.medium.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
