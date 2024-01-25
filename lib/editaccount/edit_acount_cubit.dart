import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/editaccount/edit_acount_state.dart';
import 'package:flutter_poc/sl/locator.dart';
import 'package:flutter_poc/utils/file_manager.dart';
import 'package:path/path.dart';


class EditAccountCubit extends Cubit<EditAccountState> {
  EditAccountCubit() : super(InitialState());

  void update(Map request) async {
    var sharedInstance = serviceLocator<AppSharedPref>();
    sharedInstance.setString(
        key: AppSharedPrefKey.fullName, value: request[LoginApiKeys.name]);
    sharedInstance.setString(
        key: AppSharedPrefKey.gender, value: request[LoginApiKeys.gender]);
    sharedInstance.setString(
        key: AppSharedPrefKey.dob, value: request[LoginApiKeys.dob]);
    if (request[LoginApiKeys.image] is File) {
      FileManager fileManager = serviceLocator<FileManager>();
      var path = await fileManager.saveFile(request[LoginApiKeys.image]);
      sharedInstance.setString(
          key: AppSharedPrefKey.profileImage, value: basename(path.path));
    }
    emit(SuccessState());
  }
}
