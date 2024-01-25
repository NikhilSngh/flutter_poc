import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/font_size_constants.dart';
import 'package:flutter_poc/constant/spacing_constants.dart';
import 'package:flutter_poc/login/app_elevated_button.dart';
import 'package:flutter_poc/login/common_textfield.dart';
import 'package:flutter_poc/navigation/app_router.dart';
import 'package:flutter_poc/theme/sizes.dart';
import 'package:flutter_poc/theme/ui_colors.dart';
import 'package:flutter_poc/utils/validator.dart';
import 'bloc/login_cubit.dart';
import 'bloc/state/login_state.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  late TextEditingController _emailController,
      _passwordController;
  late GlobalKey<FormState> _formKey;
  late LoginCubit cubit;

  LoginScreen({super.key}) {
    _formKey = GlobalKey();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    cubit = LoginCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
        create: (context)=> cubit,
        child:Scaffold(
            appBar: AppBar(title: const Text("Login")),
            body: Center(
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
                                  //Image.asset('assets/images/man.png'),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.loginWidgetVerticalSpacing10),
                                    child: const Text("Login",
                                        style: TextStyle(fontSize: AppFontSize.extraLarge,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.loginWidgetVerticalSpacing10),
                                    child: const Text("Sign In To Continue",
                                        style: TextStyle(fontSize: AppFontSize.regular,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.loginWidgetVerticalSpacing10),
                                    child: AppTextField(
                                      label: "email address",
                                      controller: _emailController,
                                      validator: (value) {
                                        return Validator.isEmailValid(context, email: value);
                                      },
                                      inputType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: SpacingConstant.loginWidgetVerticalSpacing10),
                                    child: AppTextField(
                                        label: "password",
                                        controller: _passwordController,
                                        isPassword: true,
                                        validator: (value) {
                                          return Validator.isValidPassword(context, password: value);
                                        },
                                        inputType: TextInputType.visiblePassword
                                    ),
                                  ),
                                  BlocConsumer<LoginCubit, LoginState>(
                                      listener: (context, state) {
                                        if (state is LoginError) {
                                          SnackBar snackBar = SnackBar(
                                              content: Text(state.message ?? '')
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        } else if (state is LoginSuccessState) {
                                          context.router.push(const AppBottomBarRoute());
                                        }
                                      },
                                      builder: (context, state) {
                                        return Container(
                                          margin: const EdgeInsets.only(bottom: SpacingConstant.loginWidgetVerticalSpacing10),
                                          child: AppElevatedButton(title: "Login", onPressed: () {
                                            _validateForm();
                                          }),
                                        );
                                      }),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Don't Have Account",
                                            style: TextStyle(fontSize: AppFontSize.regular, fontWeight: FontWeight.w400)),
                                        InkWell(
                                            onTap: (){
                                              context.router.push(SignupScreenRoute());
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(left: SpacingConstant.loginWidgetHorizontalSpacing10),
                                              child: Text("Sign Up",
                                                  style:  TextStyle(fontSize: AppFontSize.regular,
                                                      fontWeight: FontWeight.w700,
                                                      color: UiColors.primaryTextColor.lightColor)),
                                            )
                                        )
                                      ])
                                ])
                        )
                    )
                )
            )
        )
    );
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      var params = {LoginApiKeys.email: _emailController.text,
        LoginApiKeys.password: _passwordController.text
      };
      cubit.loginIn(params);
    }
  }
}
