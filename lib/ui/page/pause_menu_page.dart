import 'package:flutter/material.dart';
import 'package:food_cafe/controller/pause_menu_controller.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/bottom_sheet_custom.dart';
import 'package:food_cafe/ui/widget/bottom_sheet_pause_menu.dart';
import 'package:food_cafe/ui/widget/custom_switch.dart';
import 'package:food_cafe/ui/widget/text_field_search.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class PauseMenuPage extends StatelessWidget {
  PauseMenuPage({Key key}) : super(key: key);
  final PauseMenuController _pauseMenuController =
      Get.put(PauseMenuController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor:
            _pauseMenuController.stateStatus.value == StateStatus.LOADING
                ? backgroundColor
                : backgroundPauseMenuColor,
        body: _pauseMenuController.stateStatus.value == StateStatus.LOADING
            ? dataCircleProgressIndicator()
            : Column(children: [
                Expanded(
                    flex: 0,
                    child: Column(children: [
                      SizedBox(height: 10),
                      Text(labelTurnOfOrdering, style: pauseMenuTitleStyle),
                      Column(
                          children: _pauseMenuController.rxPauseShopList
                              .map((item) => Container(
                                  margin: EdgeInsets.only(
                                      bottom: 10, left: 10, right: 10),
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(item.menuName.value,
                                                    style: switchLabelStyle),
                                                Text(
                                                    item.orderAvailableDateTime
                                                        .value,
                                                    style: menuAvailableStyle)
                                              ]),
                                          Obx(() => CustomSwitch(
                                              value: item.switchCase.value,
                                              onChanged: (bool value) {
                                                bottomSheetCustom(
                                                    isScrollControlled: true,
                                                    isDismissible: false,
                                                    backgroundColor:
                                                        Colors.white,
                                                    context: Get.context,
                                                    builder: (context) =>
                                                        BottomSheetPauseMenu(
                                                            menuName: item
                                                                .menuName.value,
                                                            voidCallbackOk: () {
                                                              _pauseMenuController
                                                                  .isTurnOfOrdering(
                                                                      item);

                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              Get.back();
                                                            }));
                                              },
                                              activeColor: switchActiveColor,
                                              inactiveTrackColor:
                                                  switchTrackColor,
                                              inactiveThumbColor:
                                                  switchInActiveColor))
                                        ])
                                  ])))
                              .toList())
                    ])),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0))),
                        child: Column(children: [
                          Obx(() => TextFieldSearch(
                              isVisibleSearchClearIcon:
                                  _pauseMenuController.search.value == ''
                                      ? false.obs
                                      : true.obs,
                              textEditingController:
                                  _pauseMenuController.searchController.value,
                              callBack: () {
                                if (_pauseMenuController
                                    .searchController.value.text.isNotEmpty) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  _pauseMenuController.searchController.value
                                      .clear();
                                  _pauseMenuController.search('');
                                }
                              },
                              onChanged: _pauseMenuController.search)),
                          Expanded(
                              child: Obx(() =>
                                  _pauseMenuController.rxPauseMenuList.isEmpty
                                      ? emptySearchWidget()
                                      : Column(children: [
                                          Text(labelMenu,
                                              style: pauseMenuTitleStyle),
                                          Expanded(child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _pauseMenuController
                                                  .rxPauseMenuList.length,
                                              itemBuilder: (context, index) {
                                                var item = _pauseMenuController
                                                    .rxPauseMenuList[index];
                                                return Obx(() => Visibility(
                                                    visible:
                                                    _pauseMenuController
                                                        .findRecipeName(item
                                                        .menuName
                                                        .value),
                                                    child: Container(
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              item.menuName.value,
                                                                              style: switchLabelStyle),
                                                                          Text(
                                                                              item.orderAvailableDateTime.value,
                                                                              style: menuAvailableStyle)
                                                                        ]),
                                                                    Obx(() => CustomSwitch(
                                                                        value: item.switchCase.value,
                                                                        onChanged: (bool value) {
                                                                          bottomSheetCustom(
                                                                              isScrollControlled: true,
                                                                              isDismissible: false,
                                                                              backgroundColor: Colors.white,
                                                                              context: Get.context,
                                                                              builder: (context) => BottomSheetPauseMenu(
                                                                                  menuName: item.menuName.value,
                                                                                  voidCallbackOk: () {
                                                                                    _pauseMenuController.isTurnOfOrdering(item);

                                                                                    FocusScope.of(context).unfocus();
                                                                                    Get.back();
                                                                                  }));
                                                                        },
                                                                        activeColor: switchActiveColor,
                                                                        inactiveTrackColor: switchTrackColor,
                                                                        inactiveThumbColor: switchInActiveColor))
                                                                  ])
                                                            ]))));
                                              }))
                                        ])))
                        ])))
              ])));
  }
}
