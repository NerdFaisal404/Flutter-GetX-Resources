import 'package:food_cafe/controller/controller.dart';
import 'package:get/get.dart';

class NewOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewOrderController());
  }
}
