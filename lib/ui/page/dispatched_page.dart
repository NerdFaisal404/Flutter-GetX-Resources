import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/delivery_person_information.dart';
import 'package:food_cafe/ui/widget/order_detail.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class DispatchedPage extends StatefulWidget {
  @override
  createState() => _DispatchedState();
}

class _DispatchedState extends State<DispatchedPage> {
  final _infoKey = List<GlobalKey>();

  final _dispatchedController = Get.put(DispatchedController());
  final _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.searchController.clear();
    _homeController.dispatchedController.search.value = '';
    _dispatchedController.fetchDispatched();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => _dispatchedController.stateStatus.value ==
                StateStatus.LOADING
            ? widget.dataCircleProgressIndicator()
            : _dispatchedController.rxDispatchedList.isEmpty
                ? widget.emptyWidget()
                : ListView.builder(
                    itemCount: _dispatchedController.rxDispatchedList.length,
                    itemBuilder: (context, index) {
                      _infoKey.add(GlobalKey(debugLabel: '$index'));

                      return Obx(() => Visibility(
                          visible: _dispatchedController.findUniqueId(
                              _dispatchedController
                                  .rxDispatchedList[index].uniqueId),
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
                                            orderMainList: _dispatchedController
                                                .rxDispatchedList[index],
                                            orderList: _dispatchedController
                                                .rxDispatchedList[index]
                                                .orderList,
                                            otherChargeList:
                                                _dispatchedController
                                                    .rxDispatchedList[index]
                                                    .otherChargeList),
                                        DeliveryPersonInformation(
                                            deliveryPersonDetail:
                                                _dispatchedController
                                                    .rxDispatchedList[index]
                                                    .deliveryPersonDetail),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                                borderRadius: BorderRadius.circular(5.0),
                                                onTap: () => _dispatchedController
                                                    .removeOrder(
                                                        _dispatchedController
                                                            .rxDispatchedList[
                                                                index]
                                                            .uniqueId),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0)),
                                                    padding: EdgeInsets.all(3),
                                                    child: Text(
                                                        settleOrderButton,
                                                        style:
                                                            orderStatusStyle))))
                                      ])))));
                    })));
  }
}
