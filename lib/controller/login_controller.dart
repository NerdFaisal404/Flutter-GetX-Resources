import 'package:flutter/material.dart';
import 'package:food_cafe/resource/api.dart';
import 'package:food_cafe/resource/routes.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/shared/repository/firestore_database_repository.dart';
import 'package:food_cafe/shared/repository/local_auth_repository.dart';
import 'package:food_cafe/utils/extensions.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var _iLocalAuthRepository = Get.find<ILocalAuthRepository>();
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String _email = '', _password = '';

  var _autoValidate = Rx<bool>(false);
  var passwordVisible = Rx<bool>(true);

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  checkAutoValidate() {
    _autoValidate.value = true;
  }

  togglePasswordVisibility() {
    this.passwordVisible.value = !passwordVisible.value;
  }

  Future<void> callLogin() async {
    stateStatus.value = StateStatus.LOADING;

    _iLocalAuthRepository.insert(SECURE_STORAGE_USERNAME, developerName);
    _iLocalAuthRepository.insert(SECURE_STORAGE_EMAIL, developerEmail);
    _iLocalAuthRepository.insert(SECURE_STORAGE_PROFILE_URL, '');
    _iLocalAuthRepository.insert(SECURE_STORAGE_TOKEN, '');
    _iLocalAuthRepository.insert(SECURE_STORAGE_USER_ID, '');
    _iLocalAuthRepository.insert(SECURE_STORAGE_MOBILE, '');

    stateStatus.value = StateStatus.SUCCESS;
    Get.context.toast(message: 'Email or Password invalid');
    _clearTextField();

    Get.offNamed(homeRoute);
  }

  Future<void> callGoogleLogin() async {
    fireStoreDatabaseRepository.googleLogin().then((user) {
      if (user != null) {
        stateStatus.value = StateStatus.SUCCESS;

        _iLocalAuthRepository.insert(
            SECURE_STORAGE_USERNAME, user.displayName.split(' ')[0]);
        _iLocalAuthRepository.insert(SECURE_STORAGE_EMAIL, user.email);
        _iLocalAuthRepository.insert(
            SECURE_STORAGE_PROFILE_URL, user.photoURL);
        _iLocalAuthRepository.insert(SECURE_STORAGE_TOKEN, user.refreshToken);
        _iLocalAuthRepository.insert(SECURE_STORAGE_USER_ID, user.uid);
        _iLocalAuthRepository.insert(SECURE_STORAGE_MOBILE, user.phoneNumber);
        _iLocalAuthRepository.insert(SECURE_STORAGE_PINCODE, '362130');
        _iLocalAuthRepository.insert(
            SECURE_STORAGE_ADDRESS, 'To. Ravani Ta.Visavadar Dis.Junagadh');

        _iLocalAuthRepository.insert(
            SECURE_STORAGE_WHERE_LOGIN, WHERE_GOOGLE_LOGIN);

        stateStatus.value = StateStatus.SUCCESS;
        _clearTextField();
        //Get.offNamed(homeRoute);
        Get.offNamedUntil(homeRoute, (_) => false);
      }
    });
  }

  Future<void> callLogout() async {
    fireStoreDatabaseRepository.googleLogout();
    _iLocalAuthRepository.logout();

    //Get.offAllNamed(loginRoute);
    Get.offNamedUntil(loginRoute, (_) => false);
  }

  _clearTextField() {
    if (_email.isNotEmpty || _password.isNotEmpty) {
      emailController.clear();
      passwordController.clear();

      _email = '';
      _password = '';
    }
  }

  signUpLink() => Get.toNamed(signUpRoute);

  String isPasswordValid(String value) => value.validatePassword();

  String isEmailValid(String value) => value.validateEmail();

  @override
  void dispose() {
    super.dispose();
    _clearTextField();
  }
}
