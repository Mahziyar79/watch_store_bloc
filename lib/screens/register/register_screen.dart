import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/data/model/user.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/register/cubit/register_cubit.dart';
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
  final TextEditingController _nameLastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  double lat = 0.0;
  double lng = 0.0;
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
            child: BlocProvider(
              create: (context) => RegisterCubit(),
              child: Column(
                children: [
                  Avatar(
                    onTap: () async => await imageHandler
                        .pickAndCropImage(source: ImageSource.camera)
                        .then((value) {
                          setState(() {});
                        }),
                    file: imageHandler.getImage,
                  ),
                  AppDimens.medium.height,
                  AppTextField(
                    label: AppStrings.nameLastName,
                    hint: AppStrings.hintNameLastName,
                    controller: _nameLastNameController,
                  ),
                  AppTextField(
                    label: AppStrings.homeNumber,
                    hint: AppStrings.hintHomeNumber,
                    controller: _phoneController,
                  ),
                  AppTextField(
                    label: AppStrings.address,
                    hint: AppStrings.hintAddress,
                    controller: _addressController,
                  ),
                  AppTextField(
                    label: AppStrings.postalCode,
                    hint: AppStrings.hintPostalCode,
                    controller: _postalCodeController,
                  ),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is LocationPickedState) {
                        if (state.location != null) {
                          _locationController.text =
                              "${state.location!.latitude} - ${state.location!.longitude}";
                          lat = state.location!.latitude;
                          lng = state.location!.longitude;
                        }
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).pickLocation(context: context);
                        },
                        child: AppTextField(
                          label: AppStrings.location,
                          hint: AppStrings.hintLocation,
                          controller: _locationController,
                          icon: Icon(Icons.location_on),
                        ),
                      );
                    },
                  ),
                  AppDimens.medium.height,
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is SuccessResponseState) {
                        Navigator.pushNamed(context, ScreenNames.mainScreen);
                      } else if (state is ErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('خطایی رخ داده است')),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return MainButton(
                        text: AppStrings.next,
                        onPressed: () async {
                          MultipartFile? multipart;
                          if (imageHandler.getImage != null) {
                            multipart = await MultipartFile.fromFile(
                              imageHandler.getImage!.path,
                            );
                          }
                          User user = User(
                            name: _nameLastNameController.text,
                            phone: _phoneController.text,
                            address: _addressController.text,
                            postalCode: _postalCodeController.text,
                            image: multipart,
                            lat: lat,
                            lng: lng,
                          );

                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).register(user: user);
                        },
                      );
                    },
                  ),
                  AppDimens.medium.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
