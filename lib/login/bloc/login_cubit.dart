
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/sl/locator.dart';
import 'package:flutter_poc/utils/common_utility.dart';
import 'state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  void loginIn(Map request) async {
    try {

      var sharedInstance = serviceLocator<AppSharedPref>();
      if (request[LoginApiKeys.email] ==
          sharedInstance.getString(key: AppSharedPrefKey.email)
          && request[LoginApiKeys.password] == AppUtility.decrypt(
              AppConstant.encryptKey,
              sharedInstance.getString(key: AppSharedPrefKey.password))) {
        sharedInstance.setString(
            key: AppSharedPrefKey.email, value: request[LoginApiKeys.email]);
        sharedInstance.setString(
            key: AppSharedPrefKey.password, value: AppUtility
            .encrypt(AppConstant.encryptKey, request[LoginApiKeys.password])
            .base64);
        sharedInstance.setBool(key: AppSharedPrefKey.loginStatus, value: true);
        emit(LoginSuccessState());
      } else {
        emit(LoginError("Incorrect Password"));
      }
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}