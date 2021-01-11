import 'package:food_cafe/model/notification_counter.dart';
import 'package:food_cafe/shared/repository/firestore_database_repository.dart';
import 'package:get/get.dart';

class NotificationFirebaseController extends GetxController {
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var rxNotificationList = Rx<List<NotificationCounterResponse>>([]);

  List<NotificationCounterResponse> get notificationList => rxNotificationList.value;

  @override
  void onInit() {
    super.onInit();
    rxNotificationList.bindStream(fireStoreDatabaseRepository.notificationCounter());
  }
}
