import 'package:get/get.dart';

class OrderMainList {
  String uniqueId, dateTime, typeDelivery, paymentType;
  int totalQuantity;
  double totalAmount, otherCharge;
  int whereToReachOrder;
  String orderStatus, remark;

  List<OrderList> orderList;
  List<PreparationTimeList> preparationTimeList;
  PreparationTimeDefault preparationTimeDefault;
  List<OtherChargeList> otherChargeList;
  DeliveryPersonDetail deliveryPersonDetail;

  OrderMainList(
      {this.uniqueId,
      this.dateTime,
      this.typeDelivery,
      this.paymentType,
      this.totalQuantity,
      this.totalAmount,
      this.otherCharge,
      this.orderList,
      this.preparationTimeList,
      this.preparationTimeDefault,
      this.otherChargeList,
      this.deliveryPersonDetail,
      this.whereToReachOrder,
      this.orderStatus = '',
      this.remark = ''});
}

class OrderList {
  String uniqueId, recipeName;
  int quantity;
  double price;
  int orderType;

  OrderList(
      {this.uniqueId,
      this.recipeName,
      this.quantity,
      this.price,
      this.orderType});
}

class PreparationTimeDefault {
  PreparationTimeDefault({int defaultTime, int selectTime, int isMinHour}) {
    this.setDefaultTime(defaultTime);
    this.setSelectTime(selectTime);
    this.setIsMinHour(isMinHour);
  }

  RxInt defaultTime = RxInt(null);
  setDefaultTime(int value) => defaultTime.value = value;

  RxInt selectTime = RxInt(null);
  setSelectTime(int value) => selectTime.value = value;

  RxInt isMinHour = RxInt(null);
  setIsMinHour(int value) => isMinHour.value = value;
}

class PreparationTimeList extends GetxController {
  PreparationTimeList({int time, bool isSelect}) {
    this.setSelect(isSelect);
    this.setTime(time);
  }

  RxInt time = RxInt(null);
  setTime(int value) => time.value = value;

  RxBool isSelect = RxBool(null);
  setSelect(bool value) => isSelect.value = value;
}

class DeliveryPersonDetail {
  String uniqueId, name, arrivingDateTime, mobileNo, otp;

  DeliveryPersonDetail(
      {this.uniqueId,
      this.name,
      this.arrivingDateTime,
      this.mobileNo,
      this.otp});
}

class OtherChargeList {
  String name;
  double chargeAmount;

  OtherChargeList({this.name, this.chargeAmount});
}
