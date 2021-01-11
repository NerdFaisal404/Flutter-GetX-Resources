import 'package:food_cafe/model/order/order.dart';
import 'package:food_cafe/model/order/order_response.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class ReadyController extends GetxController {
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var rxReadyList = RxList<OrderMainList>([]);
  var search = Rx<String>('');

/*  @override
  onInit() {
    super.onInit();
    fetchReady();
  }*/

  Future<void> fetchReady() async {
    stateStatus.value = StateStatus.LOADING;

    List<OrderMainList> orderMainList = [
      OrderMainList(
          uniqueId: 'FCO2024',
          dateTime: '15-10-2020 - 3:17 PM',
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 1,
          otherCharge: 500,
          totalAmount: 2000,
          deliveryPersonDetail: DeliveryPersonDetail(
              uniqueId: '1',
              name: 'Lakhani Kamlesh',
              arrivingDateTime: '5 min',
              mobileNo: '9586331823',
              otp: '123456'),
          preparationTimeList: [
            PreparationTimeList(time: 10, isSelect: false),
            PreparationTimeList(time: 20, isSelect: false),
            PreparationTimeList(time: 30, isSelect: false),
            PreparationTimeList(time: 40, isSelect: false),
            PreparationTimeList(time: 50, isSelect: false),
            PreparationTimeList(time: 60, isSelect: false),
          ],
          otherChargeList: [
            OtherChargeList(name: 'GST', chargeAmount: 200),
            OtherChargeList(name: 'Delivery charge', chargeAmount: 100),
            OtherChargeList(name: 'Discount', chargeAmount: 100),
            OtherChargeList(name: 'CGST', chargeAmount: 50),
            OtherChargeList(name: 'SGST', chargeAmount: 50)
          ],
          orderList: [
            OrderList(
                uniqueId: 'FCO2021OR',
                recipeName: 'Chicken biryani',
                quantity: 1,
                price: 2000,
                orderType: 1)
          ])
    ];

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;
    rxReadyList =
        PendingResponse(orderMainList: orderMainList).orderMainList.obs;
  }

  bool findUniqueId(String value) {
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

  void removeOrder(String orderId) {
    int indexGet =
        rxReadyList.indexWhere((element) => element.uniqueId == orderId);
    if (indexGet != -1) rxReadyList.removeAt(indexGet);
  }
}
