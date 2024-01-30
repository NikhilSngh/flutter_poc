import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/account/accountInfo_widget.dart';
import 'package:flutter_poc/account/accountcard_widget.dart';
import 'package:flutter_poc/account/app_alert.dart';
import 'package:flutter_poc/constant/app_icon_constant.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:flutter_poc/gen/assets.gen.dart';
import 'package:flutter_poc/navigation/app_router.dart';
import 'package:flutter_poc/sl/locator.dart';
import 'package:flutter_poc/theme/sizes.dart';
import 'package:flutter_poc/utils/file_manager.dart';

@RoutePage()
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? name, email, dob, gender;
  File? imageFile;
  var sharedInstance = serviceLocator<AppSharedPref>();
  var fileManager = serviceLocator<FileManager>();

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  getProfileData() async {
    name = sharedInstance.getString(key: PrefKey.fullName);
    email = sharedInstance.getString(key: PrefKey.email);
    dob = sharedInstance.getString(key: PrefKey.dob);
    gender = sharedInstance.getString(key: PrefKey.gender);
    imageFile = await fileManager
        .getFile(sharedInstance.getString(key: PrefKey.profileImage));
    setState(() {});
  }

  void _logout() {
    AppAlert(
        title: AppStrings.logout,
        message: AppStrings.logoutMessage,
        confirmBtnText: AppStrings.logout,
        confirmTap: () {
          sharedInstance.remove(PrefKey.loginStatus);
          context.router.push(
            LoginScreenRoute(),
          );
        }).showDialogBox(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.account),
          actions: [
            IconButton(
              icon: const Icon(AppIconConstant.signOut),
              tooltip: AppStrings.logout,
              onPressed: () {
                _logout();
              },
            ),
            IconButton(
              icon: const Icon(AppIconConstant.edit),
              tooltip: AppStrings.edit,
              onPressed: () {
                context.router.push(EditAccountRoute(
                  isUpdated: () => {getProfileData()},
                ));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: AppPaddingMarginConstant.small,
                    right: AppPaddingMarginConstant.small,
                    top: AppPaddingMarginConstant.small),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Sizes.size100,
                        width: Sizes.size100,
                        child: CircleAvatar(
                          child: imageFile != null
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size50),
                                  child: Image.file(imageFile!,
                                      fit: BoxFit.cover,
                                      height: Sizes.size100,
                                      width: Sizes.size100))
                              : ClipOval(
                                  child: gender == AppStrings.other
                                      ? Assets.images.other.image()
                                      : gender == AppStrings.male
                                          ? Assets.images.man.image()
                                          : Assets.images.woman.image()),
                        ),
                      ),
                      Center(
                          child: Text(name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ))),
                      ProfileCardWidget(
                          child: Column(children: [
                        Info(AppStrings.emailAddress, email ?? ''),
                        const Divider(),
                        Info(AppStrings.dob, dob ?? ''),
                        const Divider(),
                        Info(AppStrings.gender, gender ?? ''),
                      ])),
                    ]))));
  }
}
