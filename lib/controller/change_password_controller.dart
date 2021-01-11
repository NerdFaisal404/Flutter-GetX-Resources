import 'package:flutter/material.dart';
import 'package:food_cafe/utils/extensions.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var newPasswordController = TextEditingController();
  var newConfirmPasswordController = TextEditingController();
  var currentPasswordController = TextEditingController();

  String _changePassword = '',
      _changeConfirmPassword = '',
      _changeCurrentPassword;

  var autoValidate = Rx<bool>(false);
  var passwordVisible = Rx<bool>(true);

  newPassword(String value) {
    _changePassword = value;
  }

  newConfirmPassword(String value) {
    _changeConfirmPassword = value;
  }

  currentPassword(String value) {
    _changeCurrentPassword = value;
  }

  checkAutoValidate() {
    autoValidate.value = true;
  }

  togglePasswordVisibility() {
    this.passwordVisible.value = !passwordVisible.value;
  }

  Future<void> callChangePassword() async {
    stateStatus.value = StateStatus.LOADING;

    stateStatus.value = StateStatus.SUCCESS;

    _clearTextField();
    Get.back();
  }

  _clearTextField() {
    newPasswordController.clear();
    newConfirmPasswordController.clear();
    currentPasswordController.clear();

    _changePassword = '';
    _changeConfirmPassword = '';
    _changeCurrentPassword = '';
  }

  String isNewPasswordValid(String value) => value.validateCurrentPassword();

  String isCurrentPasswordValid(String value) => value.validateCurrentPassword();

  @override
  void dispose() {
    super.dispose();
    _clearTextField();
  }
}
