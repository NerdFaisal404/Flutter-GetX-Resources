import 'package:food_cafe/model/order/order.dart';
import 'package:food_cafe/model/order/order_response.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class PendingController extends GetxController {
  var rxPendingList = RxList<OrderMainList>([]);
  var rxTempPendingList = RxList<OrderMainList>([]);
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  final search = Rx<String>('');
  final isTimeSelect = Rx<bool>(false);

/*  @override
  onInit() {
    super.onInit();
    fetchPending();
  }*/

  Future<void> fetchPending() async {
    stateStatus.value = StateStatus.LOADING;

    List<OrderMainList> orderMainList = [
      OrderMainList(
          uniqueId: 'FCO2021',
          dateTime: '15-10-2020 - 3:17 PM',
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 3,
          totalAmount: 6000,
          otherCharge: 500,
          preparationTimeList: [
            PreparationTimeList(time: 10, isSelect: false),
            PreparationTimeList(time: 20, isSelect: false),
            PreparationTimeList(time: 30, isSelect: false),
            PreparationTimeList(time: 40, isSelect: false),
            PreparationTimeList(time: 50, isSelect: false),
            PreparationTimeList(time: 60, isSelect: false),
          ],
          preparationTimeDefault: PreparationTimeDefault(
              defaultTime: 5, selectTime: 0, isMinHour: 1),
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
                orderType: 1),
            OrderList(
                uniqueId: 'FCO2021OR',
                recipeName: 'Chicken biryani',
                quantity: 2,
                price: 2000,
                orderType: 2)
          ]),
      OrderMainList(
          uniqueId: 'FCO2022',
          dateTime: '15-10-2020 - 3:17 PM',
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 3,
          totalAmount: 6000,
          otherCharge: 500,
          preparationTimeList: [
            PreparationTimeList(time: 10, isSelect: false),
            PreparationTimeList(time: 20, isSelect: false),
            PreparationTimeList(time: 30, isSelect: false),
            PreparationTimeList(time: 40, isSelect: false),
            PreparationTimeList(time: 50, isSelect: false),
            PreparationTimeList(time: 60, isSelect: false),
          ],
          preparationTimeDefault: PreparationTimeDefault(
              defaultTime: 5, selectTime: 0, isMinHour: 1),
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
                orderType: 1),
            OrderList(
                uniqueId: 'FCO2021OR',
                recipeName: 'Chicken biryani',
                quantity: 2,
                price: 2000,
                orderType: 2)
          ])
    ];
    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;

    rxPendingList =
        PendingResponse(orderMainList: orderMainList).orderMainList.obs;
    rxTempPendingList = rxPendingList;
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

  void preparationTimeSelect(PreparationTimeList preparationTimeList,
      PreparationTimeDefault preparationTimeDefault, int index) {
    if (preparationTimeList.isSelect.value) {
      preparationTimeList.isSelect.value = false;
      isTimeSelect.value = false;
      preparationTimeDefault.selectTime.value = 0;
    } else {
      rxPendingList[index].preparationTimeList.forEach((values) {
        values.isSelect.value = false;
      });

      preparationTimeList.isSelect.value = !preparationTimeList.isSelect.value;
      preparationTimeDefault.selectTime.value = preparationTimeList.time.value;
      isTimeSelect.value = preparationTimeList.isSelect.value;
    }
  }

  void timeSelectPlus(int time, List<PreparationTimeList> preparationTimeList,
      PreparationTimeDefault preparationTimeDefault) {
    isTimeSelect.value = true;
    preparationTimeDefault.selectTime.value = time + 5;

    _preparationTimeSelectUnSelect(preparationTimeList, preparationTimeDefault);
  }

  void removeOrder(String orderId) {
    int indexGet =
        rxPendingList.indexWhere((element) => element.uniqueId == orderId);
    if (indexGet != -1) rxPendingList.removeAt(indexGet);
  }

  void timeSelectMinus(
    int time,
    List<PreparationTimeList> preparationTimeList,
    PreparationTimeDefault preparationTimeDefault,
  ) {
    isTimeSelect.value = true;
    if (time != 0) {
      preparationTimeDefault.selectTime.value = time - 5;

      if (preparationTimeDefault.selectTime.value > 0)
        preparationTimeList[int.parse(
                    (preparationTimeDefault.selectTime.value / 10)
                        .toStringAsFixed(0)) -
                1]
            .isSelect
            .value = true;

      _preparationTimeSelectUnSelect(
          preparationTimeList, preparationTimeDefault);
    }
  }
}

//LOGIC PART 1
void _preparationTimeSelectUnSelect(
    List<PreparationTimeList> preparationTimeList,
    PreparationTimeDefault preparationTimeDefault) {
  if (preparationTimeDefault.selectTime.value % 10 == 0) {
    preparationTimeList.forEach((values) {
      values.isSelect.value = false;
    });

    preparationTimeList[int.parse((preparationTimeDefault.selectTime.value / 10)
                .toStringAsFixed(0)) -
            1]
        .isSelect
        .value = true;
  } else {
    preparationTimeList.forEach((values) {
      values.isSelect.value = false;
    });
  }
}
