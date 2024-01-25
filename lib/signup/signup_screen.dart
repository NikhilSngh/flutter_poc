import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/spacing_constants.dart';
import 'package:flutter_poc/helper/common_radio_button.dart';
import 'package:flutter_poc/login/app_elevated_button.dart';
import 'package:flutter_poc/login/common_textfield.dart';

import 'dart:io';

import 'package:flutter_poc/signup/bloc/signup_cubit.dart';
import 'package:flutter_poc/signup/bloc/state/signup_state.dart';
import 'package:flutter_poc/theme/sizes.dart';
import 'package:flutter_poc/utils/date_picker.dart';
import 'package:flutter_poc/utils/validator.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _dobEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final SignupCubit _signupCubit = SignupCubit();
  final ValueNotifier<String> _gender = ValueNotifier<String>("");
  File? _pickedImage;

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      Map<String, dynamic> params = {LoginApiKeys.email: _emailEditingController.text,
        LoginApiKeys.password: _passwordEditingController.text,
        LoginApiKeys.name: _nameEditingController.text,
        LoginApiKeys.dob: _dobEditingController.text,
        LoginApiKeys.gender: _gender.value
      };
      if (_pickedImage != null) {
        params[LoginApiKeys.image] = _pickedImage;
      }
      _signupCubit.signup(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
        create: (context)=> _signupCubit,
        child:Scaffold(
            appBar: AppBar(title: const Text("Sign Up")),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: Sizes.size16,
                            right: Sizes.size16),
                        child:Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize:MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.signupWidgetVerticalSpacing10,
                                    top: SpacingConstant.signupWidgetVerticalSpacing10),
                                    child: AppTextField(
                                        label: "name",
                                        controller: _nameEditingController,
                                        validator: (value) {
                                          return Validator.isValidName(context, name: value);
                                        },
                                        inputType: TextInputType.name),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.signupWidgetVerticalSpacing10,),
                                    child: AppTextField(
                                        label: "emailAddress",
                                        controller: _emailEditingController,
                                        validator: (value) {
                                          return Validator.isEmailValid(context, email: value);
                                        },
                                        inputType: TextInputType.emailAddress),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.signupWidgetVerticalSpacing10,),
                                    child: AppTextField(
                                        label: "dob",
                                        readOnly: true,
                                        onTap: () {
                                          DatePicker(context,date: (date){
                                            _dobEditingController.text = date;
                                          }).show();
                                        },
                                        controller: _dobEditingController,
                                        validator: (value) {
                                          return Validator.emptyValidate(context, value: value, message: "dobIsRequired");

                                        },
                                        inputType: TextInputType.emailAddress),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.signupWidgetVerticalSpacing10,),
                                    child: AppTextField(
                                        label: "password",
                                        controller: _passwordEditingController,
                                        isPassword: true,
                                        validator: (value) {
                                          return Validator.isValidPassword(context, password: value);
                                        },
                                        inputType: TextInputType.visiblePassword),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.signupWidgetVerticalSpacing10,),
                                    child: AppTextField(
                                        label: "confirmPassword",
                                        controller: _confirmPasswordEditingController,
                                        isPassword: true,
                                        validator: (value) {
                                          return Validator.isValidConfirmPassword(context, password: value, matchPassword: _passwordEditingController.text);
                                        },
                                        inputType: TextInputType.visiblePassword),
                                  ),

                                  AppRadioButton(label: "Gender",
                                      items: const ["male", "female", "other"],
                                      onChange: (value) {
                                        _gender.value = value;
                                      }),
                                  BlocConsumer<SignupCubit, SignupState>(
                                      listener: (context, state) {
                                        if (state is SignupError) {
                                          SnackBar snackBar = SnackBar(
                                              content: Text(state.message ?? '')
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        } else if (state is SignupSuccessState) {
                                          context.router.pop();
                                        }
                                      },
                                      builder: (context, state) {
                                        return AppElevatedButton(title: "signUp", onPressed: () {
                                          _validateForm();
                                        });
                                      })
                                ])
                        )
                    )
                )
            )
        )
    );
  }
}