import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/resource/api.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/all_find_new_order_preparation_time.dart';
import 'package:food_cafe/ui/widget/delivery_person_information.dart';
import 'package:food_cafe/ui/widget/order_detail.dart';
import 'package:food_cafe/ui/widget/order_status.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class AllFindPage extends StatelessWidget {
  final _infoKey = List<GlobalKey>();
  final HomeController _homeController = Get.put(HomeController());
  final AllFindController _allFindController = Get.put(AllFindController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.3,
            leading: IconButton(
                onPressed: () {
                  _homeController.searchController.clear();
                  _homeController.pendingController.search.value = '';
                  Get.back();
                },
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(titleAllFind, style: appBarTitleStyle)),
        body: Obx(() => _allFindController.stateStatus.value ==
                StateStatus.LOADING
            ? dataCircleProgressIndicator()
            : _allFindController.rxAllFindList.isEmpty
                ? emptyWidget()
                : ListView.builder(
                    itemCount: _allFindController.rxAllFindList.length,
                    itemBuilder: (context, index) {
                      _infoKey.add(GlobalKey(debugLabel: '$index'));
                      var orderMainList =
                          _allFindController.rxAllFindList[index];

                      return Card(
                          elevation: cardViewElevation,
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OrderDetail(
                                        infoKey: _infoKey[index],
                                        orderMainList: orderMainList,
                                        orderList: orderMainList.orderList,
                                        otherChargeList:
                                            orderMainList.otherChargeList),
                                    Visibility(
                                        visible:
                                            orderMainList.whereToReachOrder ==
                                                whereToReachOrderPending,
                                        child: AllFindNewOrderPreparationTime(
                                            index: index,
                                            preparationTimeDefault:
                                                orderMainList
                                                    .preparationTimeDefault,
                                            preparationTimeList: orderMainList
                                                .preparationTimeList)),
                                    Visibility(
                                        visible: orderMainList
                                                    .whereToReachOrder ==
                                                whereToReachOrderAccepted ||
                                            orderMainList.whereToReachOrder ==
                                                whereToReachOrderReady ||
                                            orderMainList.whereToReachOrder ==
                                                whereToReachOrderDispatched || orderMainList.orderStatus == 'Completed',
                                        child: DeliveryPersonInformation(
                                            deliveryPersonDetail: orderMainList
                                                .deliveryPersonDetail)),
                                    Visibility(
                                        visible:
                                            orderMainList.whereToReachOrder ==
                                                whereToReachOrderPending,
                                        child: OrderStatus(
                                            orderStatus: acceptButton,
                                            rejectCallBack: () =>
                                                _allFindController.removeOrder(
                                                    orderMainList.uniqueId,
                                                    orderMainList
                                                        .whereToReachOrder),
                                            orderCallBack: () =>
                                                _allFindController.removeOrder(
                                                    orderMainList.uniqueId,
                                                    orderMainList
                                                        .whereToReachOrder))),
                                    Visibility(
                                        visible:
                                            orderMainList.whereToReachOrder ==
                                                whereToReachOrderAccepted,
                                        child: OrderStatus(
                                            orderStatus: foodReadyButton,
                                            rejectCallBack: () =>
                                                _allFindController.removeOrder(
                                                    orderMainList.uniqueId,
                                                    orderMainList
                                                        .whereToReachOrder),
                                            orderCallBack: () =>
                                                _allFindController.removeOrder(
                                                    orderMainList.uniqueId,
                                                    orderMainList
                                                        .whereToReachOrder))),
                                    Visibility(
                                        visible:
                                            orderMainList.whereToReachOrder ==
                                                whereToReachOrderReady,
                                        child: OrderStatus(
                                            orderCallBack: () =>
                                                _allFindController.removeOrder(
                                                    orderMainList.uniqueId,
                                                    orderMainList
                                                        .whereToReachOrder),
                                            orderStatus: dispatchButton,
                                            isRejectShow: false)),
                                    Visibility(
                                        visible: orderMainList.whereToReachOrder ==
                                            whereToReachOrderDispatched,
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                onTap: () =>
                                                    _allFindController.removeOrder(
                                                        orderMainList.uniqueId,
                                                        orderMainList
                                                            .whereToReachOrder),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0)),
                                                    padding: EdgeInsets.all(3),
                                                    child: Text(settleOrderButton,
                                                        style: orderStatusStyle))))),
                                    Visibility(
                                        visible:
                                            orderMainList.orderStatus != '',
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('$remarkItem',
                                                        style:
                                                            pastOrderRemarkStyle),
                                                    Text(
                                                        orderMainList.remark ==
                                                                ''
                                                            ? ''
                                                            : orderMainList
                                                                .remark,
                                                        style:
                                                            pastOrderRemarkCommentStyle)
                                                  ]),
                                              Text(orderMainList.orderStatus,
                                                  style: pastOrderStatusStyle(
                                                      orderMainList.orderStatus
                                                          .toLowerCase()
                                                          .pastOrderColor()))
                                            ]))
                                  ])));
                    })));
  }
}
