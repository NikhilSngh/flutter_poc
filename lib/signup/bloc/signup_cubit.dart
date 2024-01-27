import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/signup/bloc/state/signup_state.dart';
import 'package:flutter_poc/sl/locator.dart';
import 'package:flutter_poc/utils/common_utility.dart';
import 'package:flutter_poc/utils/file_manager.dart';
import 'package:path/path.dart';

class SignupCubit extends Cubit<SignupState> {
  final AppSharedPref sharedInstance;
  final FileManager fileManager;
  SignupCubit({required this.sharedInstance, required this.fileManager}) : super(SignupInitialState());

  void signup(Map request) async {

    sharedInstance.setString(
        key: AppSharedPrefKey.fullName, value: request[LoginApiKeys.name]);
    sharedInstance.setString(
        key: AppSharedPrefKey.gender, value: request[LoginApiKeys.gender]);
    sharedInstance.setString(
        key: AppSharedPrefKey.dob, value: request[LoginApiKeys.dob]);
    sharedInstance.setString(
        key: AppSharedPrefKey.email, value: request[LoginApiKeys.email]);
    sharedInstance.setString(
        key: AppSharedPrefKey.password,
        value: AppUtility.encrypt(
            AppConstant.encryptKey, request[LoginApiKeys.password])
            .base64);
    if (request[LoginApiKeys.image] is File) {
      FileManager fileManager = serviceLocator<FileManager>();
      var path = await fileManager.saveFile(request[LoginApiKeys.image]);
      sharedInstance.setString(
          key: AppSharedPrefKey.profileImage, value: basename(path.path));
    }
    sharedInstance.setBool(key: AppSharedPrefKey.loginStatus, value: true);
    emit(SignupSuccessState());
  }
}
