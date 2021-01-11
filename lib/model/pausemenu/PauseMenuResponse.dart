import 'package:get/get.dart';

class PauseMenuResponse {
  List<PauseOrderMenu> pauseMenuList;
  List<PauseOrderMenu> pauseShopList;

  PauseMenuResponse({this.pauseMenuList, this.pauseShopList});
}

class PauseOrderMenu {
  PauseOrderMenu({int id, String menuName, String orderAvailableDateTime, bool switchCase}) {
    this.setId(id);
    this.setMenuName(menuName);
    this.setOrderAvailableDateTime(orderAvailableDateTime);
    this.setSwitchCase(switchCase);
  }

  RxInt id = RxInt(null);
  setId(int value) => id.value = value;

  RxString menuName = RxString(null);
  setMenuName(String value) => menuName.value = value;

  RxString orderAvailableDateTime = RxString(null);
  setOrderAvailableDateTime(String value) =>
      orderAvailableDateTime.value = value;

  RxBool switchCase = RxBool(false);
  setSwitchCase(bool value) => switchCase.value = value;
}
