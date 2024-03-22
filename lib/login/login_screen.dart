import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/constant/font_size_constants.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:flutter_poc/constant/spacing_constants.dart';
import 'package:flutter_poc/extension.dart';
import 'package:flutter_poc/helper/app_text_button.dart';
import 'package:flutter_poc/helper/app_textfield.dart';
import 'package:flutter_poc/helper/responsive_widget.dart';
import 'package:flutter_poc/navigation/app_router.dart';
import 'package:flutter_poc/sl/locator.dart';
import 'package:flutter_poc/utils/validator.dart';
import 'bloc/login_cubit.dart';
import 'bloc/state/login_state.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  late TextEditingController _emailController, _passwordController;
  late GlobalKey<FormState> _formKey;
  late LoginCubit cubit;

  LoginScreen({super.key}) {
    _formKey = GlobalKey();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    cubit = LoginCubit(
        serviceLocator<AppSharedPref>(), serviceLocator<FirebaseAuth>());
  }

  @override
  Widget build(BuildContext context) {
    var sharedInstance = serviceLocator<AppSharedPref>();
    return BlocProvider<LoginCubit>(
        create: (context) => cubit,
        child: Scaffold(
            appBar: AppBar(title: const Text(AppStrings.login)),
            body: Center(
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppPaddingMarginConstant.regular,
                          right: AppPaddingMarginConstant.regular),
                      child: Form(
                          key: _formKey,
                          child: SizedBox(
                            width: ResponsiveWidget.isSmallScreen(context)
                                ? context.getWidth()
                                : context.getWidth() / 2,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  //Image.asset('assets/images/man.png'),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: SpacingConstant
                                            .loginWidgetVerticalSpacing10),
                                    child: const Text(AppStrings.login,
                                        style: TextStyle(
                                            fontSize: AppFontSize.extraLarge,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: SpacingConstant
                                            .loginWidgetVerticalSpacing10),
                                    child: const Text(
                                        AppStrings.signInToContinue,
                                        style: TextStyle(
                                            fontSize: AppFontSize.regular,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: SpacingConstant
                                            .loginWidgetVerticalSpacing10),
                                    child: AppTextField(
                                      label: AppStrings.enterEmailAddress,
                                      controller: _emailController,
                                      validator: (value) {
                                        return Validator.isEmailValid(context,
                                            email: value);
                                      },
                                      inputType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: SpacingConstant
                                            .loginWidgetVerticalSpacing10),
                                    child: AppTextField(
                                        label: AppStrings.enterPassword,
                                        controller: _passwordController,
                                        isPassword: true,
                                        validator: (value) {
                                          return Validator.isValidPassword(
                                              context,
                                              password: value);
                                        },
                                        inputType:
                                            TextInputType.visiblePassword),
                                  ),
                                  BlocConsumer<LoginCubit, LoginState>(
                                      listener: (context, state) {
                                    if (state is LoginError) {
                                      Navigator.pop(context);
                                      SnackBar snackBar = SnackBar(
                                          content: Text(state.message ?? ''));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (state is LoginSuccessState) {
                                      Navigator.pop(context);
                                      sharedInstance.setInt(
                                          key: PrefKey.timeStamp,
                                          value: DateTime.now()
                                              .millisecondsSinceEpoch);
                                      context.router
                                          .push(const AppBottomBarRoute());
                                    } else if (state is LoginLoadingState) {
                                      context.showLoader();
                                    }
                                  }, builder: (context, state) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          bottom: SpacingConstant
                                              .loginWidgetVerticalSpacing10),
                                      child: AppElevatedButton(
                                          title: AppStrings.login,
                                          onPressed: () {
                                            _validateForm();
                                          }),
                                    );
                                  }),
                                  AppElevatedButton(
                                      title: AppStrings.signUp,
                                      onPressed: () {
                                        context.router
                                            .push(SignupScreenRoute());
                                      }),
                                ]),
                          )))),
            )));
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      cubit.signInUsingEmailPassword(
          email: _emailController.text, password: _passwordController.text);
    }
  }
}
