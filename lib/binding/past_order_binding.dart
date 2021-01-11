import 'package:food_cafe/controller/controller.dart';
import 'package:get/get.dart';

class PastOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PastOrderController());
  }
}
