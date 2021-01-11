import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/delivery_person_information.dart';
import 'package:food_cafe/ui/widget/order_detail.dart';
import 'package:food_cafe/ui/widget/order_status.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class ReadyPage extends StatefulWidget {
  @override
   createState() => _ReadyState();
}

class _ReadyState extends State<ReadyPage> {
  final _infoKey = List<GlobalKey>();

  final _readyController = Get.put(ReadyController());
  final _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.searchController.clear();
    _homeController.readyController.search.value = '';
    _readyController.fetchReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => _readyController.stateStatus.value ==
                StateStatus.LOADING
            ? widget.dataCircleProgressIndicator()
            : _readyController.rxReadyList.isEmpty
                ? widget.emptyWidget()
                : ListView.builder(
                    itemCount: _readyController.rxReadyList.length,
                    itemBuilder: (context, index) {
                      _infoKey.add(GlobalKey(debugLabel: '$index'));

                      return Obx(() => Visibility(
                          visible: _readyController.findUniqueId(
                              _readyController.rxReadyList[index].uniqueId),
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
                                            orderMainList: _readyController
                                                .rxReadyList[index],
                                            orderList: _readyController
                                                .rxReadyList[index].orderList,
                                            otherChargeList: _readyController
                                                .rxReadyList[index]
                                                .otherChargeList),
                                        DeliveryPersonInformation(
                                            deliveryPersonDetail:
                                                _readyController
                                                    .rxReadyList[index]
                                                    .deliveryPersonDetail),
                                        OrderStatus(
                                            orderCallBack: () =>
                                                _readyController.removeOrder(
                                                    _readyController
                                                        .rxReadyList[index]
                                                        .uniqueId),
                                            orderStatus: dispatchButton,
                                            isRejectShow: false)
                                      ])))));
                    })));
  }
}
