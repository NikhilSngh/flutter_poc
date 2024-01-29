import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:flutter_poc/constant/spacing_constants.dart';
import 'package:flutter_poc/editaccount/edit_acount_cubit.dart';
import 'package:flutter_poc/editaccount/edit_acount_state.dart';
import 'package:flutter_poc/helper/common_radio_button.dart';
import 'package:flutter_poc/login/app_elevated_button.dart';
import 'package:flutter_poc/login/common_textfield.dart';
import 'package:flutter_poc/signup/profile_Image.dart';
import 'package:flutter_poc/sl/locator.dart';
import 'package:flutter_poc/utils/date_picker.dart';
import 'package:flutter_poc/utils/file_manager.dart';
import 'package:flutter_poc/utils/validator.dart';

@RoutePage()
class EditAccount extends StatelessWidget {
  final TextEditingController _dobEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final EditAccountCubit _accountCubit = EditAccountCubit();
  final ValueNotifier<String> _gender = ValueNotifier<String>("");
  final Function isUpdated;
  File? _pickedImage;

  EditAccount({super.key,required this.isUpdated}) {
    var sharedInstance = serviceLocator<AppSharedPref>();
    FileManager fileManager = serviceLocator<FileManager>();
    fileManager
        .getFile(sharedInstance.getString(key: PrefKey.profileImage))
        .then((value) {
      _pickedImage = value;
      _gender.value = "";
      _gender.value = sharedInstance.getString(key: PrefKey.gender);
    });
    _dobEditingController.text =
        sharedInstance.getString(key: PrefKey.dob);
    _nameEditingController.text =
        sharedInstance.getString(key: PrefKey.fullName);
    _gender.value = sharedInstance.getString(key: PrefKey.gender);
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      Map<String, dynamic> params = {
        LoginApiKeys.name: _nameEditingController.text,
        LoginApiKeys.dob: _dobEditingController.text,
        LoginApiKeys.gender: _gender.value
      };
      if (_pickedImage != null) {
        params[LoginApiKeys.image] = _pickedImage;
      }
      _accountCubit.update(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditAccountCubit>(
        create: (context) => _accountCubit,
        child: Scaffold(
            appBar: AppBar(title: const Text(AppStrings.editAccount)),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: AppPaddingMarginConstant.regular,
                            right: AppPaddingMarginConstant.regular),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: SpacingConstant.accountWidgetVerticalSpacing10),
                                    child: ValueListenableBuilder(
                                        valueListenable: _gender,
                                        builder: (context, value, _) {
                                          return ProfileImage(
                                            pickerImage: (image) {
                                              _pickedImage = image;
                                            },
                                            gender: _gender.value,
                                            pickedImage: _pickedImage,
                                          );
                                        }),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: SpacingConstant.accountWidgetVerticalSpacing10),
                                    child: AppTextField(
                                        label: AppStrings.name,
                                        controller: _nameEditingController,
                                        validator: (value) {
                                          if (value != null) {
                                            if (Validator.isValidName(context,
                                                    name: value) !=
                                                null) {
                                              return Validator.isValidName(
                                                  context,
                                                  name: value);
                                            }
                                          }
                                          return null;
                                        },
                                        inputType: TextInputType.name),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: SpacingConstant.accountWidgetVerticalSpacing10),
                                    child: AppTextField(
                                        label: AppStrings.dob,
                                        readOnly: true,
                                        onTap: () {
                                          DatePicker(context, date: (date) {
                                            _dobEditingController.text = date;
                                          }).show();
                                        },
                                        controller: _dobEditingController,
                                        validator: (value) {
                                          if (value != null) {
                                            if (Validator.isEmpty(value)) {
                                              return AppStrings.dobMessage;
                                            }
                                          }
                                          return null;
                                        },
                                        inputType: TextInputType.emailAddress),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: SpacingConstant.accountWidgetVerticalSpacing10),
                                    child: AppRadioButton(
                                        label: AppStrings.gender,
                                        items: const [
                                          AppStrings.male,
                                          AppStrings.female,
                                          AppStrings.other
                                        ],
                                        selectedItem: _gender.value,
                                        onChange: (value) {
                                          _gender.value = value;
                                        }),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: SpacingConstant.accountWidgetVerticalSpacing10),
                                    child: BlocConsumer<EditAccountCubit,
                                            EditAccountState>(
                                        listener: (context, state) {
                                      if (state is SuccessState) {
                                        context.router.pop();
                                        isUpdated.call();
                                      }
                                    }, builder: (context, state) {
                                      return AppElevatedButton(
                                        title: 'update',
                                        onPressed: () {
                                          _validateForm();
                                        },
                                      );
                                    }),
                                  )
                                ])))))));
  }
}
