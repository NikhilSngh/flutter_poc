import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:flutter_poc/sl/locator.dart';
import 'package:flutter_poc/utils/common_utility.dart';
import 'state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AppSharedPref appSharedPref;
  final FirebaseAuth auth;
  LoginCubit(this.appSharedPref, this.auth,) : super(LoginInitialState());

  void loginIn(Map request) async {
    try {
      var sharedInstance = serviceLocator<AppSharedPref>();
      if (request[LoginApiKeys.email] ==
              sharedInstance.getString(key: PrefKey.email) &&
          request[LoginApiKeys.password] ==
              AppUtility.decrypt(AppConstant.encryptKey,
                  sharedInstance.getString(key: PrefKey.password))) {
        sharedInstance.setString(
            key: PrefKey.email, value: request[LoginApiKeys.email]);
        sharedInstance.setString(
            key: PrefKey.password,
            value: AppUtility.encrypt(
                    AppConstant.encryptKey, request[LoginApiKeys.password])
                .base64);
        sharedInstance.setBool(key: PrefKey.loginStatus, value: true);
        emit(LoginSuccessState());
      } else {
        emit(LoginError("Incorrect Password"));
      }
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.code));
      return user;
    }catch (e) {
      emit(LoginError(e.toString()));
      return user;
    }
    appSharedPref.setString(
        key: PrefKey.email, value: email);
    appSharedPref.setString(
        key: PrefKey.password,
        value: AppUtility.encrypt(
            AppConstant.encryptKey, password)
            .base64);
    appSharedPref.setBool(key: PrefKey.loginStatus, value: true);
    emit(LoginSuccessState());
  }
}
