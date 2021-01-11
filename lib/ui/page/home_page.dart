import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/controller/notification_firebase_controller.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/routes.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/bottom_sheet_custom.dart';
import 'package:food_cafe/ui/widget/dialog_search.dart';
import 'package:food_cafe/ui/widget/drawer_menu.dart';
import 'package:get/get.dart';
import 'accepted_page.dart';
import 'dispatched_page.dart';
import 'kds_view_page.dart';
import 'past_order_page.dart';
import 'pause_menu_page.dart';
import 'pending_page.dart';
import 'ready_page.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<HomePage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  var _homeController = Get.put(HomeController());
  var _notificationFirebaseController =
      Get.put(NotificationFirebaseController());

  //var _notificationMinController = Get.put(NotificationMinController());

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => _renderBody(context);

  _renderBody(BuildContext context) {
    return Obx(() => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            elevation: 0.3,
            actions: [
              _homeController.drawerMenuIndex.value == 0
                  ? Container(
                      margin: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                          child: Icon(searchIcon,
                              size: 18, color: appBarTitleColor),
                          onTap: () => showDialog(
                              barrierColor: Colors.white.withOpacity(0),
                              context: context,
                              builder: (BuildContext context) {
                                return Obx(() => DialogSearch(
                                    isVisibleSearchClearIcon:
                                        _isVisibleSearchClearIcon(
                                            _homeController
                                                .currentPageIndex.value),
                                    callSearchClear: () {
                                      _searchClear(_homeController
                                          .currentPageIndex.value);
                                      _homeController.searchController.clear();
                                    },
                                    textEditingController:
                                        _homeController.searchController,
                                    callBackCancel: () => Get.back(),
                                    callFind: () {
                                      Get.offAndToNamed(allFindRoute);
                                    },
                                    onChanged: (onChange) {
                                      _search(
                                          onChange,
                                          _homeController
                                              .currentPageIndex.value);
                                    }));
                              })))
                  : Container()
            ],
            leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());

                  bottomSheetCustom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      isScrollControlled: true,
                      isDismissible: true,
                      backgroundColor: backgroundColor,
                      context: context,
                      builder: (context) => Obx(() => DrawerMenu(
                          userName: _homeController.secureStorageUserName.value,
                          email: _homeController.secureStorageEmail.value,
                          profileURL:
                              _homeController.secureStorageProfileURL.value,
                          whereLogin:
                              _homeController.secureStorageWhereLogin.value)));
                },
                icon: Icon(navigationIcon, size: 18, color: appBarTitleColor)),
            title: Text(appName, style: appBarTitleStyle)),
        body: PageView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _redirectPage(),
              _redirectPage(),
              _redirectPage(),
              _redirectPage()
            ],
            controller: _homeController.pageController),
        bottomNavigationBar: _bottomBar()));
  }

  _isVisibleSearchClearIcon(int currentPageIndex) {
    switch (currentPageIndex) {
      case pendingIndex:
        return _homeController.pendingController.search.value == ''
            ? false.obs
            : true.obs;
        break;

      case acceptedIndex:
        return _homeController.acceptedController.search.value == ''
            ? false.obs
            : true.obs;
        break;

      case readyIndex:
        return _homeController.readyController.search.value == ''
            ? false.obs
            : true.obs;
        break;

      case dispatchedIndex:
        return _homeController.dispatchedController.search.value == ''
            ? false.obs
            : true.obs;
        break;
    }
  }

  _search(String value, int currentPageIndex) {
    switch (currentPageIndex) {
      case pendingIndex:
        _homeController.pendingController.search(value);
        break;

      case acceptedIndex:
        _homeController.acceptedController.search(value);
        break;

      case readyIndex:
        _homeController.readyController.search(value);
        break;

      case dispatchedIndex:
        _homeController.dispatchedController.search(value);
        break;
    }
  }

  _searchClear(int currentPageIndex) {
    switch (currentPageIndex) {
      case pendingIndex:
        _homeController.pendingController.search.value = '';
        break;

      case acceptedIndex:
        _homeController.acceptedController.search.value = '';
        break;

      case readyIndex:
        _homeController.readyController.search.value = '';
        break;

      case dispatchedIndex:
        _homeController.dispatchedController.search.value = '';
        break;
    }
  }

  _redirectPage() {
    if (_homeController.drawerMenuIndex.value == pauseMenuIndex) {
      return PauseMenuPage();
    } else if (_homeController.drawerMenuIndex.value == pastOrder) {
      return PastOrderPage();
    } else if (_homeController.drawerMenuIndex.value == KDSView) {
      return KDSViewPage();
    } else {
      return _tabPages(_homeController.currentPageIndex.value);
    }
  }

  _tabPages(int index) {
    switch (index) {
      case pendingIndex:
        return PendingPage();
        break;
      case acceptedIndex:
        return AcceptedPage();
        break;
      case readyIndex:
        return ReadyPage();
        break;
      case dispatchedIndex:
        return DispatchedPage();
        break;
    }
  }

  _bottomBar() => BottomNavigationBar(
          elevation: 4,
          backgroundColor: tabBackgroundColor,
          fixedColor: tabSelectColor,
          unselectedItemColor: tabUnSelectColor,
          type: BottomNavigationBarType.fixed,
          onTap: _homeController.onTabChange,
          selectedLabelStyle: tabSelectStyle,
          unselectedLabelStyle: tabUnSelectStyle,
          currentIndex: _homeController.currentPageIndex.value,
          items: [
            BottomNavigationBarItem(
                icon: _renderTabBar(
                    iconData: tabPendingIcon,
                    notificationCounter:
                        _notificationFirebaseController.notificationList.isEmpty
                            ? '0'
                            : _notificationFirebaseController
                                .notificationList[0].pending,
                    selectIndex:
                        _homeController.currentPageIndex.value == pendingIndex),
                label: drawerMenuPending),
            BottomNavigationBarItem(
                icon: _renderTabBar(
                    iconData: tabAcceptedIcon,
                    notificationCounter:
                        _notificationFirebaseController.notificationList.isEmpty
                            ? '0'
                            : _notificationFirebaseController
                                .notificationList[0].accepted,
                    selectIndex: _homeController.currentPageIndex.value ==
                        acceptedIndex),
                label: drawerMenuAccepted),
            BottomNavigationBarItem(
                icon: _renderTabBar(
                    iconData: tabReadyIcon,
                    notificationCounter:
                        _notificationFirebaseController.notificationList.isEmpty
                            ? '0'
                            : _notificationFirebaseController
                                .notificationList[0].ready,
                    selectIndex:
                        _homeController.currentPageIndex.value == readyIndex),
                label: drawerMenuReady),
            BottomNavigationBarItem(
                icon: _renderTabBar(
                    iconData: tabDispatchedIcon,
                    notificationCounter:
                        _notificationFirebaseController.notificationList.isEmpty
                            ? '0'
                            : _notificationFirebaseController
                                .notificationList[0].dispatched,
                    selectIndex: _homeController.currentPageIndex.value ==
                        dispatchedIndex),
                label: drawerMenuDispatched)
          ]);

  _renderTabBar(
          {@required IconData iconData,
          String notificationCounter,
          bool selectIndex = false}) =>
      Stack(children: <Widget>[
        Container(
            width: 30,
            height: 25,
            padding: const EdgeInsets.only(right: 0.0, top: 4),
            child: Icon(iconData)),
        Positioned(
            right: 0,
            top: 0,
            child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: selectIndex
                        ? countSelectBackgroundColor
                        : countBackgroundColor,
                    borderRadius: BorderRadius.circular(8)),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(notificationCounter,
                    style: countStyle, textAlign: TextAlign.center)))
      ]);
}
