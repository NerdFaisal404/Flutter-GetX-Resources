import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_cafe/model/notification_counter.dart';
import 'package:food_cafe/shared/provider/firestore_provider.dart';
import 'package:get/get.dart';

class FireStoreDatabaseRepository {
  final FireStoreDatabaseProvider _fireStoreDatabaseFoodCafe = Get.find<FireStoreDatabaseProvider>();

  Stream<List<NotificationCounterResponse>> notificationCounter() {
    return _fireStoreDatabaseFoodCafe.fetchNotificationCounter();
  }

  Future<User> googleLogin(){
    return _fireStoreDatabaseFoodCafe.fetchGoogleLogin();
  }

  void googleLogout(){
    _fireStoreDatabaseFoodCafe.fetchGoogleLogout();
  }
}