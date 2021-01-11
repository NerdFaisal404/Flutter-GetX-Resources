# food_cafe

0) Path set java: Path - still bin

1) flutter pub pub run flutter_automation --android-sign
2) CN="Kamlesh Lakhani", OU=1, O=jdkgroup, L=Ahmedabad, S=Gujarat, C=91

3) keytool -list -v -keystore C:/Users/Kamlesh/AndroidStudioProjects/food_cafe\keys/keystore.jks -alias food_cafe -storepass food_cafe -keypass food_cafe

4) SH1 KEY
   Debug
   12:7B:3B:C3:C6:B7:45:24:0C:4E:36:AE:2E:D4:40:47:C8:A3:03:E6

   MAC
   D6:B3:2C:C7:FD:70:60:B4:35:99:4A:BD:2D:B5:76:60:01:65:4D:65

   Release
   68:D1:6B:62:50:AA:E3:16:6E:5E:D7:77:0C:AD:5D:94:8C:AA:13:B0

6) Application detail:
   package name: com.jdkgroup.food_cafe

7) CMD Command MAC:
   Get flutter version: /Library/Software/flutter/bin/flutter --version


LOGIC PART
1) Preparation Time login
   if value % 10 == 0 value selected display else un-select

2) Biker boy / Delivery boy information
   class name: DeliveryPersonInformation

3) class name
   Syntax
   ------
   Reactive syntax GetX

   var search = Rx<String>('');
   var search = Rx<String>('');
   var rxReadyList = RxList<OrderMainList>([]);

   Common
   ------
   - When data not available class name and method : extensions.dart, emptyWidget()
   - Data progressbar class name and method: extensions.dart, dataCircleProgressIndicator()
   - extension method use:
     import 'package:food_cafe/utils/extensions.dart';

     stateless class: functionName();
     stateful class: widget.functionName();

   - LazyPut getx
   class DependencyInjection {
     static void init() {
       Get.lazyPut<FlutterSecureStorage>(() => FlutterSecureStorage(), fenix: true);
       Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance, fenix: true);

       //SECURE STORAGE
       Get.lazyPut<LocalAuthProvider>(() => LocalAuthProvider(), fenix: true);
       Get.lazyPut<LocalAuthRepository>(() => LocalAuthRepository(), fenix: true);

       //FIRESTORE
       Get.lazyPut<FireStoreDatabaseProvider>(() => FireStoreDatabaseProvider(Get.find()), fenix: true);
       Get.lazyPut<FireStoreDatabaseRepository>(() => FireStoreDatabaseRepository(), fenix: true);
     }
   }

   Bottom navigation bar
   ---------------------
   class name and function name: home_page.dart and _bottomBar()

   Tab 1) Pending class name: pending_page.dart
   - Change the notification counter every 1 minute. (Bottom tab counter - notification_min_controller.dart)

   Tab 2) Accepted class name: accepted_page.dart
   Tab 3) Ready class name: ready_page.dart
   Tab 4) Dispatched class name: dispatched_page.dart

   All 4 tab contain the initState() that used to clear common search textField.
   - Appbar right side search icon press the open search dialog (dialog_search.dart)
   - Find: all_find_page that is find all the data with status.

   Notification bottom bar icon:
   1) Every min (NotificationMinController), Evert 1 min API calling.
   2) Firebase using (NotificationFirebaseController), That is live stream data

   BottomNavigationBarItem(
                  icon: _renderTabBar(
                      iconData: tabPendingIcon,
                      selectIndex:
                          _homeController.currentPageIndex.value == pendingIndex),
                  label: drawerMenuPending),
   - iconData: Set icon
   - selectIndex: Select the current index, change background color notification
   - label: Set label name

   Drawer Menu
   -----------
   drawer class name: drawer_menu.dart

   Pause Menu class name: pause_menu_page.dart
   Turn Of Ordering class name: turn_of_ordering.dart
   Past Order class name:past_order_page.dart
   New order class name: new_order_page.dart, display only new pending data.
   KDS View class name: kds_view_page.dart
   Profile class name: profile_edit_page.dart
   Logout exit dialog name: dialog_exit.dart

   Notification
   ------------
   notification_page.dart

   Dialog
   ------
   GST, Delivery charge, CGST, SGST class name: order_detail.dart and method name showPopupWindow()
   - That is rendorbox dialog

   Logout code class name and method: login_controller.dart and logout

   Firebase
   --------
   Firebase insert

   Future<void> addValue() {
     return values
         .add({
       'DeviceId': deviceId,
       'Temperature': temperature,
       'Time': timeStamp
     })
         .then((value) => print("Value Added"))
         .catchError((error) => print("Failed to add value: $error"));
   }

