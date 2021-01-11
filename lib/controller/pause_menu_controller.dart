import 'package:flutter/material.dart';
import 'package:food_cafe/model/pausemenu/PauseMenuResponse.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class PauseMenuController extends GetxController {
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var rxPauseMenuList = RxList<PauseOrderMenu>([]);
  var rxPauseShopList = RxList<PauseOrderMenu>([]);
  var rxTempPauseMenuList = RxList<PauseOrderMenu>([]);
  var searchController = Rx<TextEditingController>();

  var search = Rx<String>('');

  @override
  onInit() {
    super.onInit();
    fetchPauseMenu();
  }

  Future<void> fetchPauseMenu() async {
    stateStatus.value = StateStatus.LOADING;

    var pauseMenuResponse = PauseMenuResponse(pauseShopList: [
      PauseOrderMenu(
          id: 1001,
          menuName: 'Online ordering',
          switchCase: false,
          orderAvailableDateTime: ''),
      PauseOrderMenu(
          id: 1002,
          menuName: 'Offline ordering',
          switchCase: false,
          orderAvailableDateTime: '')
    ], pauseMenuList: [
      PauseOrderMenu(
          id: 1003,
          menuName: 'Chicken biryani',
          switchCase: true,
          orderAvailableDateTime: '11-Sep.-2020 4:15 PM')
    ]);

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;

    rxPauseShopList = pauseMenuResponse.pauseShopList.obs;
    rxPauseMenuList = pauseMenuResponse.pauseMenuList.obs;

    rxTempPauseMenuList = rxPauseMenuList;
  }

  void isTurnOfOrdering(PauseOrderMenu pauseOrderMenu) {
    pauseOrderMenu.switchCase.value = !pauseOrderMenu.switchCase.value;
  }

  bool findRecipeName(String value) {
    if (search.value == null) {
      return true;
    } else if (search.value.isEmpty) {
      return true;
    } else if (value.toLowerCase().contains(search.value.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  /*void search(String value) {
    if (value.isEmpty || value == '') {
      isVisibleSearchClearIcon.value = false;
      rxPauseMenuList = rxTempPauseMenuList;
    } else {
      isVisibleSearchClearIcon.value = true;
      List<PauseOrderMenu> filterList = rxTempPauseMenuList[0]
          .pauseOrderMenuList
          .where((element) => element.menuName.value.contains(value))
          .toList();

      if (filterList.isEmpty) {
        rxPauseMenuList = RxList<PauseMenu>([]);
      } else {
        List<PauseMenu> addFilter = List();
        addFilter.add(PauseMenu(
            id: rxTempPauseMenuList[0].id,
            title: rxTempPauseMenuList[0].title,
            pauseOrderMenuList: filterList));

        rxPauseMenuList = addFilter.obs;
      }
    }
  }*/
}
