import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/delivery_person_information.dart';
import 'package:food_cafe/ui/widget/order_detail.dart';
import 'package:food_cafe/ui/widget/order_status.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class AcceptedPage extends StatefulWidget {
  @override
  createState() => _AcceptedState();
}

class _AcceptedState extends State<AcceptedPage> {
  final _infoKey = List<GlobalKey>();

  final _acceptedController = Get.put(AcceptedController());
  final _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.searchController.clear();
    _homeController.acceptedController.search.value = '';
    _acceptedController.fetchAccepted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
            () => _acceptedController.stateStatus.value == StateStatus.LOADING
                ? widget.dataCircleProgressIndicator()
                : _acceptedController.rxAcceptedList.isEmpty
                    ? widget.emptyWidget()
                    : ListView.builder(
                        itemCount: _acceptedController.rxAcceptedList.length,
                        itemBuilder: (context, index) {
                          _infoKey.add(GlobalKey(debugLabel: '$index'));
                          return Obx(() => Visibility(
                              visible: _acceptedController.findUniqueId(
                                  _acceptedController.rxAcceptedList[index].uniqueId),
                          child: Card(
                              elevation: cardViewElevation,
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OrderDetail(
                                            infoKey: _infoKey[index],
                                            orderMainList: _acceptedController
                                                .rxAcceptedList[index],
                                            orderList: _acceptedController
                                                .rxAcceptedList[index]
                                                .orderList,
                                            otherChargeList: _acceptedController
                                                .rxAcceptedList[index]
                                                .otherChargeList),
                                        DeliveryPersonInformation(
                                            deliveryPersonDetail:
                                                _acceptedController
                                                    .rxAcceptedList[index]
                                                    .deliveryPersonDetail),
                                        OrderStatus(
                                            orderStatus: foodReadyButton,
                                            rejectCallBack: () =>
                                                _acceptedController.removeOrder(
                                                    _acceptedController
                                                        .rxAcceptedList[index]
                                                        .uniqueId),
                                            orderCallBack: () =>
                                                _acceptedController.removeOrder(
                                                    _acceptedController
                                                        .rxAcceptedList[index]
                                                        .uniqueId))
                                      ])))));
                        })));
  }
}
