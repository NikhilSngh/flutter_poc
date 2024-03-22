import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:flutter_poc/signup/bloc/state/signup_state.dart';
import 'package:flutter_poc/utils/common_utility.dart';
import 'package:flutter_poc/utils/file_manager.dart';

class SignupCubit extends Cubit<SignupState> {
  final AppSharedPref sharedInstance;
  final FileManager fileManager;
  final FirebaseAuth auth;

  SignupCubit({
    required this.sharedInstance,
    required this.fileManager,
    required this.auth,
  }) : super(SignupInitialState());

  void signup(Map request) async {
    sharedInstance.setString(
        key: PrefKey.fullName, value: request[LoginApiKeys.name]);
    sharedInstance.setString(
        key: PrefKey.gender, value: request[LoginApiKeys.gender]);
    sharedInstance.setString(
        key: PrefKey.dob, value: request[LoginApiKeys.dob]);
    sharedInstance.setString(
        key: PrefKey.email, value: request[LoginApiKeys.email]);
    sharedInstance.setString(
        key: PrefKey.password,
        value: AppUtility.encrypt(
                AppConstant.encryptKey, request[LoginApiKeys.password])
            .base64);
    if (request[LoginApiKeys.image] is Uint8List) {
      final encodedImage = base64Encode(request[LoginApiKeys.image]);
      sharedInstance.setString(
          key: PrefKey.profileImage, value: encodedImage);
    }
    sharedInstance.setBool(key: PrefKey.loginStatus, value: true);
    emit(SignupSuccessState());
  }

  Future<User?> signUpFireBase(Map request) async {
    emit(SignupLoadingState());
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: request[LoginApiKeys.email],
        password: request[LoginApiKeys.password],
      );
      user = userCredential.user;
      await user!.updateDisplayName(request[LoginApiKeys.name]);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      emit(SignupError(e.code));
      return user;
    } catch (e) {
      emit(SignupError(e.toString()));
      return user;
    }
    signup(request);
    return user;
  }
}
