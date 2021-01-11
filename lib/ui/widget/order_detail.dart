import 'package:flutter/material.dart';
import 'package:food_cafe/model/order/order.dart';
import 'package:food_cafe/resource/font.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:line_icons/line_icons.dart';
import 'popup_window.dart';

class OrderDetail extends StatelessWidget {
  final GlobalKey infoKey;
  final List<OrderList> orderList;
  final OrderMainList orderMainList;
  final List<OtherChargeList> otherChargeList;

  OrderDetail(
      {this.infoKey, this.orderList, this.orderMainList, this.otherChargeList});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(orderMainList.uniqueId, style: id),
        Text(orderMainList.dateTime, style: dateTimeStyle)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(orderMainList.typeDelivery, style: deliveryType),
        Text(timeAgoRemove, style: timeCalculationStyle)
      ]),
      SizedBox(height: 5),
      Column(
          children: orderList
              .map((item) => Row(children: [
                    Flexible(
                        flex: 2500,
                        child: Row(children: [
                          Icon(LineIcons.check_circle_o,
                              color: item.orderType == fullOrderTypeApi
                                  ? Colors.green
                                  : Colors.red,
                              size: 14),
                          SizedBox(width: 5),
                          Text(item.recipeName, style: menuNameStyle),
                          SizedBox(width: 5),
                          Text(
                              item.orderType == fullOrderTypeApi
                                  ? fullOrderType
                                  : halfOrderType,
                              style: orderTypeStyle)
                        ])),
                    Flexible(
                        flex: 700,
                        child: Row(children: [
                          Text('$quantitySymbol', style: quantitySymbolStyle),
                          Text('${item.quantity}', style: quantityStyle)
                        ])),
                    Flexible(
                        flex: 0,
                        child: Text('$rsSymbol ${item.price}',
                            style: menuPriceStyle))
                  ]))
              .toList()),
      SizedBox(height: 3),
      Divider(color: Colors.grey.withOpacity(0.2)),
      Row(children: [
        Flexible(
            flex: 3200,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(orderMainList.paymentType,
                        style: paymentPaidStatusStyle),
                    SizedBox(width: 3),
                    Text('($CODPaymentType)', style: paymentCollectStyle)
                  ]),
                  Row(children: [
                    Text(labelTotal, style: totalQuantityStyle),
                    SizedBox(width: 3),
                    GestureDetector(
                        key: infoKey,
                        onTap: () {
                          RenderBox renderBox =
                              infoKey.currentContext.findRenderObject();
                          Offset offset = renderBox.localToGlobal(Offset.zero);
                          showPopupWindow(
                              context: context,
                              fullWidth: false,
                              //isShowBg:true,
                              position: RelativeRect.fromLTRB(
                                  0, offset.dy + renderBox.size.height, 0, 0),
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Column(
                                        children: otherChargeList
                                            .map((item) => Column(children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(item.name,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    regularFont)),
                                                        Text(
                                                            '$rsSymbol ${item.chargeAmount}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    regularFont))
                                                      ])
                                                ]))
                                            .toList()),
                                    Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(labelTotalAmount,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontFamily: mediumFont)),
                                          Text(
                                              '$rsSymbol ${orderMainList.otherCharge}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: mediumFont))
                                        ])
                                  ])));
                        },
                        child: Column(children: [
                          Icon(LineIcons.info_circle,
                              size: 20, color: Colors.blue),
                          SizedBox(height: 2)
                        ])),
                    SizedBox(width: 3)
                  ])
                ])),
        Flexible(
            flex: 700,
            child: Row(children: [
              Text('$quantitySymbol', style: quantitySymbolStyle),
              Text('${orderMainList.totalQuantity}', style: quantityStyle)
            ])),
        Flexible(
            flex: 0,
            child: Text(
                '$rsSymbol ${(orderMainList.totalAmount + orderMainList.otherCharge)}',
                style: totalAmountStyle))
      ])
    ]);
  }
}
