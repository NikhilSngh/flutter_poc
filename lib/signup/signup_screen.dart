import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/constant/spacing_constants.dart';
import 'package:flutter_poc/helper/common_radio_button.dart';
import 'package:flutter_poc/helper/app_text_button.dart';
import 'package:flutter_poc/helper/app_textfield.dart';
import 'dart:io';
import 'package:flutter_poc/signup/bloc/signup_cubit.dart';
import 'package:flutter_poc/signup/bloc/state/signup_state.dart';
import 'package:flutter_poc/signup/profile_Image.dart';
import 'package:flutter_poc/sl/locator.dart';
import 'package:flutter_poc/utils/date_picker.dart';
import 'package:flutter_poc/utils/file_manager.dart';
import 'package:flutter_poc/utils/validator.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _dobEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ValueNotifier<String> _gender = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    File? pickedImage;

    return BlocProvider<SignupCubit>(
        create: (context) => SignupCubit(
            sharedInstance: serviceLocator<AppSharedPref>(),
            fileManager: serviceLocator<FileManager>()),
        child: Scaffold(
            appBar: AppBar(title: const Text(AppStrings.signUp)),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: AppPaddingMarginConstant.regular,
                            right: AppPaddingMarginConstant.regular),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ValueListenableBuilder(
                                      valueListenable: _gender,
                                      builder: (context, value, _) {
                                        return ProfileImage(
                                            pickerImage: (image) {
                                              pickedImage = image;
                                            },
                                            gender: _gender.value);
                                      }),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: AppPaddingMarginConstant.small,
                                        top: AppPaddingMarginConstant.small),
                                    child: AppTextField(
                                        label: AppStrings.enterName,
                                        controller: _nameEditingController,
                                        validator: (value) {
                                          return Validator.isValidName(context,
                                              name: value);
                                        },
                                        inputType: TextInputType.name),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: SpacingConstant
                                          .signupWidgetVerticalSpacing10,
                                    ),
                                    child: AppTextField(
                                        label: AppStrings.enterEmail,
                                        controller: _emailEditingController,
                                        validator: (value) {
                                          return Validator.isEmailValid(context,
                                              email: value);
                                        },
                                        inputType: TextInputType.emailAddress),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: SpacingConstant
                                          .signupWidgetVerticalSpacing10,
                                    ),
                                    child: AppTextField(
                                        label: AppStrings.dob,
                                        readOnly: true,
                                        onTap: () {
                                          DatePicker(context, date: (date) {
                                            _dobEditingController.text = date;
                                          }).show();
                                        },
                                        controller: _dobEditingController,
                                        validator: (value) {
                                          return Validator.emptyValidate(
                                              context,
                                              value: value,
                                              message:
                                                  AppStrings.dobIsRequired);
                                        },
                                        inputType: TextInputType.emailAddress),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: SpacingConstant
                                          .signupWidgetVerticalSpacing10,
                                    ),
                                    child: AppTextField(
                                        label: AppStrings.enterPassword,
                                        controller: _passwordEditingController,
                                        isPassword: true,
                                        validator: (value) {
                                          return Validator.isValidPassword(
                                              context,
                                              password: value);
                                        },
                                        inputType:
                                            TextInputType.visiblePassword),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: SpacingConstant
                                          .signupWidgetVerticalSpacing10,
                                    ),
                                    child: AppTextField(
                                        label: AppStrings.confirmPassword,
                                        controller:
                                            _confirmPasswordEditingController,
                                        isPassword: true,
                                        validator: (value) {
                                          return Validator
                                              .isValidConfirmPassword(context,
                                                  password: value,
                                                  matchPassword:
                                                      _passwordEditingController
                                                          .text);
                                        },
                                        inputType:
                                            TextInputType.visiblePassword),
                                  ),
                                  AppRadioButton(
                                      label: "Gender",
                                      items: const ["male", "female", "other"],
                                      onChange: (value) {
                                        _gender.value = value;
                                      }),
                                  BlocConsumer<SignupCubit, SignupState>(
                                      listener: (context, state) {
                                    if (state is SignupError) {
                                      SnackBar snackBar = SnackBar(
                                          content: Text(state.message ?? ''));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (state is SignupSuccessState) {
                                      context.router.pop();
                                    }
                                  }, builder: (context, state) {
                                    return AppElevatedButton(
                                        title: AppStrings.signUp,
                                        onPressed: () {
                                          _validateForm(
                                              context.read<SignupCubit>(),
                                              pickedImage);
                                        });
                                  })
                                ])))))));
  }

  void _validateForm(SignupCubit signupCubit, File? pickedImage) async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      Map<String, dynamic> params = {
        LoginApiKeys.email: _emailEditingController.text,
        LoginApiKeys.password: _passwordEditingController.text,
        LoginApiKeys.name: _nameEditingController.text,
        LoginApiKeys.dob: _dobEditingController.text,
        LoginApiKeys.gender: _gender.value
      };
      if (pickedImage != null) {
        params[LoginApiKeys.image] = pickedImage;
      }
      signupCubit.signup(params);
    }
  }
}
