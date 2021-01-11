import 'package:flutter/material.dart';
import 'package:food_cafe/resource/api.dart';
import 'package:food_cafe/shared/repository/local_auth_repository.dart';
import 'package:get/get.dart';
import 'controller.dart';

class HomeController extends GetxController {
  var _iLocalAuthRepository = Get.find<ILocalAuthRepository>();
  var searchController = TextEditingController();

  final pendingController = Get.put(PendingController());
  final acceptedController = Get.put(AcceptedController());
  final readyController = Get.put(ReadyController());
  final dispatchedController = Get.put(DispatchedController());
  PageController pageController;

  var currentPageIndex = Rx<int>(0);
  var drawerMenuIndex = Rx<int>(0);

  var secureStorageUserName = Rx<String>('');
  var secureStorageProfileURL = Rx<String>('');
  var secureStorageEmail = Rx<String>('');
  var secureStorageMobile = Rx<String>('');
  var secureStoragePinCode = Rx<String>('');
  var secureStorageAddress = Rx<String>('');
  var secureStorageWhereLogin = Rx<String>('');

  @override
  onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPageIndex.value);
    getUserDetails();
  }

  onTabChange(int index) {
    currentPageIndex.value = index;

    if (drawerMenuIndex.value > 3) drawerMenuIndex.value = 0;
  }

  drawerMenuChange(int index) {
    drawerMenuIndex.value = index;
  }

  void getUserDetails() {
    _iLocalAuthRepository.get(SECURE_STORAGE_USERNAME).then((value) {
      secureStorageUserName.value = value;
    });

    _iLocalAuthRepository.get(SECURE_STORAGE_PROFILE_URL).then((value) {
      secureStorageProfileURL.value = value;
    });

    _iLocalAuthRepository.get(SECURE_STORAGE_EMAIL).then((value) {
      secureStorageEmail.value = value;
    });

    _iLocalAuthRepository.get(SECURE_STORAGE_MOBILE).then((value) {
      secureStorageMobile.value = value;
    });

    _iLocalAuthRepository.get(SECURE_STORAGE_PINCODE).then((value) {
      secureStoragePinCode.value = value;
    });

    _iLocalAuthRepository.get(SECURE_STORAGE_ADDRESS).then((value) {
      secureStorageAddress.value = value;
    });

    _iLocalAuthRepository.get(SECURE_STORAGE_WHERE_LOGIN).then((value) {
      secureStorageWhereLogin.value = value;
    });
  }

  void setUserDetails(
      {String userName,
      String mobile,
      String pinCode,
      String address,
      String profileUrl}) {
    _iLocalAuthRepository.insert(SECURE_STORAGE_USERNAME, userName);
    _iLocalAuthRepository.insert(SECURE_STORAGE_MOBILE, mobile);
    _iLocalAuthRepository.insert(SECURE_STORAGE_PINCODE, pinCode);
    _iLocalAuthRepository.insert(SECURE_STORAGE_ADDRESS, address);
  }

  @override
  onClose() {
    super.onClose();
    pageController.dispose();

    secureStorageUserName.value = '';
    secureStorageProfileURL.value = '';
    secureStorageEmail.value = '';
    secureStorageMobile.value = '';
    secureStoragePinCode.value = '';
    secureStorageAddress.value = '';
  }
}
