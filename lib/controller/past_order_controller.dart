import 'package:food_cafe/model/pastorder/past_order_response.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class PastOrderController extends GetxController {
  var pastOrder = Rx<PastOrderResponse>();
  var pastOrderStatusSelected = Rx<PastOrderStatus>();
  var totalRecord = Rx<int>(0);
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  Future<void> callPastOrder({int orderStatus = 1}) async {
    stateStatus.value = StateStatus.LOADING;

    var pastOrderResponse = PastOrderResponse(pastOrderStatusList: [
      PastOrderStatus(id: 1, orderStatus: 'All', isSelected: true),
      PastOrderStatus(id: 2, orderStatus: 'Completed'),
      PastOrderStatus(id: 3, orderStatus: 'Rejected'),
      PastOrderStatus(id: 4, orderStatus: 'Canceled')
    ], pastOrderList: [
      PastOrder(
          uniqueId: 'ECOM2000',
          orderTotalAmount: 6000.0,
          typeDelivery: 'Home delivery',
          orderStatus: 'Completed',
          paymentType: 'Paid',
          orderStatusId: 2,
          dateTime: '08 Oct 2020 - 4:30 PM'),
      PastOrder(
          uniqueId: 'ECOM2001',
          orderTotalAmount: 3000,
          typeDelivery: 'ome delivery',
          orderStatus: 'Rejected',
          paymentType: 'Paid',
          dateTime: '08 Oct 2020 - 4:30 PM',
          isRefundable: 1,
          orderStatusId: 3,
          remark: 'Items are not available')
    ]);

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;

    totalRecord.value = pastOrderResponse.pastOrderList.length;

    pastOrderStatusSelected.value = pastOrderResponse.pastOrderStatusList
        .singleWhere((element) => element.isSelected);

    pastOrder.value = pastOrderResponse;
  }
}
