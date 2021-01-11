class PastOrderResponse {
  List<PastOrderStatus> pastOrderStatusList;
  List<PastOrder> pastOrderList;

  PastOrderResponse({this.pastOrderStatusList, this.pastOrderList});
}

class PastOrderStatus {
  String orderStatus;
  int id;
  bool isSelected;

  PastOrderStatus({this.id, this.orderStatus, this.isSelected = false});
}

class PastOrder {
  String uniqueId, dateTime, typeDelivery, orderStatus, paymentType, remark;
  double orderTotalAmount;
  int isRefundable, orderStatusId;

  PastOrder(
      {this.uniqueId,
      this.orderTotalAmount = 0.0,
      this.dateTime,
      this.typeDelivery,
      this.orderStatus,
      this.paymentType,
      this.remark,
      this.isRefundable,
      this.orderStatusId});
}
