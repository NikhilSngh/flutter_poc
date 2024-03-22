import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:flutter_poc/editaccount/edit_acount_state.dart';
import 'package:flutter_poc/sl/locator.dart';

class EditAccountCubit extends Cubit<EditAccountState> {
  EditAccountCubit() : super(InitialState());

  void update(Map request) async {
    var sharedInstance = serviceLocator<AppSharedPref>();
    sharedInstance.setString(
        key: PrefKey.fullName, value: request[LoginApiKeys.name]);
    sharedInstance.setString(
        key: PrefKey.gender, value: request[LoginApiKeys.gender]);
    sharedInstance.setString(
        key: PrefKey.dob, value: request[LoginApiKeys.dob]);

    if (request[LoginApiKeys.image] is Uint8List) {
      final encodedImage = base64Encode(request[LoginApiKeys.image]);
      sharedInstance.setString(
          key: PrefKey.profileImage, value: encodedImage);
    }

    emit(SuccessState());
  }
}
