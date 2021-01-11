import 'package:food_cafe/model/order/order.dart';
import 'package:food_cafe/model/order/order_response.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class AcceptedController extends GetxController {
  var rxAcceptedList = RxList<OrderMainList>([]);
  var search = Rx<String>('');
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

/*  @override
  onInit() {
    super.onInit();
    fetchAccepted();
  }*/

  Future<void> fetchAccepted() async {
    stateStatus.value = StateStatus.LOADING;

    List<OrderMainList> orderMainList = [
      OrderMainList(
          uniqueId: 'FCO2023',
          dateTime: '15-10-2020 - 3:17 PM',
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 2,
          totalAmount: 4000,
          otherCharge: 500,
          deliveryPersonDetail: DeliveryPersonDetail(
              uniqueId: '1',
              name: 'Lakhani Kamlesh',
              arrivingDateTime: '5 min',
              mobileNo: '9586331823',
              otp: '123456'),
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
                quantity: 2,
                price: 2000,
                orderType: 1)
          ])
    ];

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;
    rxAcceptedList =
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
        rxAcceptedList.indexWhere((element) => element.uniqueId == orderId);
    if (indexGet != -1) rxAcceptedList.removeAt(indexGet);
  }
}
