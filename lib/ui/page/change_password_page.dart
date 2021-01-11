import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  var _changePasswordController = Get.put(ChangePasswordController());

  final GlobalKey<FormState> _key = GlobalKey();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          elevation: cardViewElevation,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
          title: Text(titleChangePassword, style: appBarTitleStyle)),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [_formUI()])));

  _formUI() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        widget.size(heightScale: 30.0),
        _newPasswordInput(),
        _newConfirmPasswordInput(),
        _currentPasswordInput(),
        widget.size(heightScale: 20.0),
        _changePasswordPress(),
        SizedBox(height: 10.0)
      ]));

  _changePasswordPress() =>
      Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: _changePasswordController.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _changePasswordValidate());

  _changePasswordValidate() {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_key.currentState.validate()) {
      _key.currentState.save();
      _changePasswordController.callChangePassword();
    } else {
      _changePasswordController.checkAutoValidate();
    }
  }

  _newPasswordInput() => widget.inputField(
      _changePasswordController.newPasswordController,
      labelText: hintNewPassword,
      validation: _changePasswordController.isNewPasswordValid,
      obscureText: _changePasswordController.passwordVisible.value,
      onChanged: _changePasswordController.newPassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(_changePasswordController.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => _changePasswordController.togglePasswordVisibility()));

  _newConfirmPasswordInput() =>
      widget.inputField(_changePasswordController.newConfirmPasswordController,
          labelText: hintNewConfirmPassword, validation: (value) {
        return value.isEmpty
            ? 'New confirm password is required'
            : value == _changePasswordController.newPasswordController.text
                ? null
                : 'New Password and new confirm password not match';
      },
          obscureText: _changePasswordController.passwordVisible.value,
          onChanged: _changePasswordController.newConfirmPassword,
          maxLength: passwordMaxLength,
          inkWell: InkWell(
              child: Icon(_changePasswordController.passwordVisible.value
                  ? passwordInVisibleIcon
                  : passwordVisibleIcon),
              onTap: () =>
                  _changePasswordController.togglePasswordVisibility()));

  _currentPasswordInput() => widget.inputField(
      _changePasswordController.currentPasswordController,
      labelText: hintCurrentPassword,
      validation: _changePasswordController.isCurrentPasswordValid,
      obscureText: _changePasswordController.passwordVisible.value,
      onChanged: _changePasswordController.newPassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(_changePasswordController.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => _changePasswordController.togglePasswordVisibility()));
}
