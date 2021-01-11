import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/model/pastorder/past_order_response.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/past_order_widget.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class PastOrderPage extends StatefulWidget {
  @override
  createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrderPage> {
  final _pastOrderController = PastOrderController();

  @override
  void initState() {
    super.initState();
    _pastOrderController.callPastOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => _pastOrderController.stateStatus.value == StateStatus.LOADING
            ? Container().dataCircleProgressIndicator()
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 40,
                      width: 140,
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(
                              color: borderDeliveryPersonInformationColor,
                              style: BorderStyle.solid,
                              width: 0.80)),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<PastOrderStatus>(
                              value: _pastOrderController
                                  .pastOrderStatusSelected.value,
                              onChanged: (PastOrderStatus value) {
                                _pastOrderController
                                    .pastOrderStatusSelected.value = value;
                              },
                              items: _pastOrderController
                                  .pastOrder.value.pastOrderStatusList
                                  .map((PastOrderStatus selectValue) =>
                                      DropdownMenuItem<PastOrderStatus>(
                                          value: selectValue,
                                          child: Text(selectValue.orderStatus,
                                              style: dropDownTextStyle)))
                                  .toList()))),
                  Text(labelTotal, style: totalStyle),
                  SizedBox(width: 3),
                  Text('${_pastOrderController.totalRecord}',
                      style: totalCountStyle)
                ]),
                Expanded(
                    child: Obx(() => _pastOrderController
                            .pastOrder.value.pastOrderList.isEmpty
                        ? widget.emptyWidget()
                        : ListView.builder(
                            itemCount: _pastOrderController
                                .pastOrder.value.pastOrderList.length,
                            itemBuilder: (context, index) {
                              PastOrder pastOrder = _pastOrderController
                                  .pastOrder.value.pastOrderList[index];
                              return PastOrderWidget(
                                  uniqueId: pastOrder.uniqueId,
                                  dateTime: pastOrder.dateTime,
                                  orderTotalAmount: pastOrder.orderTotalAmount,
                                  typeDelivery: pastOrder.typeDelivery,
                                  orderStatus: pastOrder.orderStatus,
                                  paymentType: pastOrder.paymentType,
                                  remark: pastOrder.remark,
                                  isRefundable: pastOrder.isRefundable,
                                  selectOrderStatus: _pastOrderController
                                      .pastOrderStatusSelected
                                      .value
                                      .orderStatus);
                            })))
              ]));
  }
}
