import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/account/accountInfo_widget.dart';
import 'package:flutter_poc/account/accountcard_widget.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/constant/spacing_constants.dart';
import 'package:flutter_poc/sl/locator.dart';


@RoutePage()
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? name, email, dob, gender;
  var sharedInstance = serviceLocator<AppSharedPref>();
  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  getProfileData() async {
    name = sharedInstance.getString(key: AppSharedPrefKey.fullName);
    email =  sharedInstance.getString(key: AppSharedPrefKey.email);
    dob =  sharedInstance.getString(key: AppSharedPrefKey.dob);
    gender =  sharedInstance.getString(key: AppSharedPrefKey.gender);
    setState(() {});
  }

  void _logout() {
    /*AppAlert(
        title: AppStrings.logout,
        message: AppStrings.logoutMessage,
        confirmBtnText: AppStrings.logout,
        confirmTap: () {
          sharedInstance.remove(AppSharedPrefEnums.loginStatus);
          context.router.push(
            const OnboardingRoute(),
          );
        }).showDialogBox(context);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.account),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: AppStrings.logout,
              onPressed: () {
                _logout();
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'edit',
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: SpacingConstant.paddingAccount,
                    right: SpacingConstant.paddingAccount,
                    top: SpacingConstant.paddingAccount),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: CircleAvatar(
                          child: ClipOval(
                              child: gender == AppStrings.other
                                  ? Image.asset('assets/images/other.png')
                                  : gender == AppStrings.male
                                      ?Image.asset('assets/images/man.png')
                                      : Image.asset('assets/images/woman.png')),
                        ),
                      ),
                      Center(
                          child: Text(name ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,))),
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
