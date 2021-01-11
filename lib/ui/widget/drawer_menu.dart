import 'package:flutter/material.dart';
import 'package:food_cafe/controller/home_controller.dart';
import 'package:food_cafe/controller/login_controller.dart';
import 'package:food_cafe/resource/api.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/routes.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/dialog_exit.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

class DrawerMenu extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());
  final LoginController _loginController = Get.put(LoginController());

  final String userName, email, profileURL, whereLogin;
  DrawerMenu(
      {@required this.userName,
      @required this.email,
      @required this.profileURL,
      @required this.whereLogin,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.1),
              backgroundImage: profileURL.isEmpty
                  ? ExactAssetImage(profileImage)
                  : NetworkImage(profileURL)),
          title: Text(userName.titleCase, style: drawerUserNameStyle),
          subtitle: Text(email.toLowerCase(), style: drawerEmailStyle),
          trailing: GestureDetector(
              child: Icon(notificationIcon, color: accentColor),
              onTap: () {
                Get.back();
                Get.toNamed(notificationRoute);
              }),
          onTap: () {}),
      ListTile(
          leading: Icon(pauseMenuIcon, size: 16),
          title: Text(titlePauseMenu, style: drawerMenuStyle),
          onTap: () {
            _homeController.currentPageIndex.value = pendingIndex; //Tab selected 0 index
            _homeController.drawerMenuChange(pauseMenuIndex);
            Get.back();
          }),
      ListTile(
          leading: Icon(turnOfOrderingIcon, size: 16),
          title: Text(titleTurnOfOrdering, style: drawerMenuStyle),
          onTap: () {
            Get.back();
            Get.toNamed(turnOfOrderingRoute);
          }),
      ListTile(
          leading: Icon(pastOrderIcon, size: 16),
          title: Text(titlePastOrder, style: drawerMenuStyle),
          onTap: () {
            _homeController.currentPageIndex.value = pendingIndex; //Tab selected 0 index
            _homeController.drawerMenuChange(pastOrder);
            Get.back();
          }),
      ListTile(
          leading: Icon(newOrderIcon, size: 16),
          title: Text(titleNewOrder, style: drawerMenuStyle),
          onTap: () {
            Get.back();
            Get.toNamed(newOrderRoute);
          }),
      ListTile(
          leading: Icon(kdsViewIcon, size: 16),
          title: Text(titleKDSView, style: drawerMenuStyle),
          onTap: () {
            _homeController.currentPageIndex.value = pendingIndex; //Tab selected 0 index
            _homeController.drawerMenuChange(KDSView);
            Get.back();
          }),
      ListTile(
          leading: Icon(profileIcon, size: 16),
          title: Text(titleProfile, style: drawerMenuStyle),
          onTap: () {
            Get.back();
            Get.toNamed(profileEditRoute);
          }),
      whereLogin == WHERE_LOGIN
          ? ListTile(
              leading: Icon(changePasswordIcon, size: 16),
              title: Text(titleChangePassword, style: drawerMenuStyle),
              onTap: () {
                Get.back();
                Get.toNamed(changePasswordRoute);
              })
          : Container(),
      ListTile(
          leading: Icon(logoutIcon, size: 16),
          title: Text(titleLogout, style: drawerMenuStyle),
          onTap: () {
            Get.back();
            showDialog(
                context: context,
                builder: (_) => DialogExit(
                    callBackCancel: () => Get.back(),
                    callBackOk: () => _loginController.callLogout()));
          })
    ]));
  }
}
