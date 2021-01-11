import 'package:food_cafe/resource/api.dart';
import 'package:food_cafe/resource/routes.dart';
import 'package:food_cafe/shared/repository/local_auth_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SplashController extends GetxController {
  var _iLocalAuthRepository = Get.find<ILocalAuthRepository>();

  @override
  void onReady() {
    super.onReady();
    _launchPage();
  }

  _launchPage() async {
    var _requestToken = await _iLocalAuthRepository.get(SECURE_STORAGE_USERNAME);
    Get.offNamed(_requestToken != null ? homeRoute : loginRoute);
  }
}
