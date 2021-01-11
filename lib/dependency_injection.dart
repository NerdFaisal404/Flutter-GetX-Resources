import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'shared/provider/firestore_provider.dart';
import 'shared/provider/local_auth_provider.dart';
import 'shared/repository/firestore_database_repository.dart';
import 'shared/repository/local_auth_repository.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance, fenix: true);
    Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance, fenix: true);

    //SECURE STORAGE
    Get.lazyPut<ILocalAuthRepository>(() => LocalAuthProvider(), fenix: true);

    //FIRESTORE
    Get.lazyPut<FireStoreDatabaseProvider>(() => FireStoreDatabaseProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut<FireStoreDatabaseRepository>(() => FireStoreDatabaseRepository(), fenix: true);
  }
}
