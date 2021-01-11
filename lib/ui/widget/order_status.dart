import 'package:flutter/material.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';

class OrderStatus extends StatelessWidget {
  final String orderStatus;
  final bool isBillShow, isRejectShow;
  final VoidCallback rejectCallBack, orderCallBack;

  OrderStatus(
      {this.orderStatus,
      this.isRejectShow = true,
      this.isBillShow = true,
      this.rejectCallBack,
      this.orderCallBack});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        isRejectShow
            ? IntrinsicWidth(
                child: InkWell(
                    highlightColor: Colors.blue.withOpacity(0.2),
                    onTap: rejectCallBack,
                    borderRadius: BorderRadius.circular(5.0),
                    child: Column(children: [
                      Text(rejectButton, style: orderStatusLinkStyle),
                      Container(color: Colors.blue, height: 1)
                    ])))
            : Container(),
        SizedBox(width: isRejectShow ? 20 : 0),
        isBillShow
            ? IntrinsicWidth(
                child: InkWell(
                    highlightColor: Colors.blue.withOpacity(0.2),
                    onTap: () {},
                    borderRadius: BorderRadius.circular(5.0),
                    child: Column(children: [
                      Text(BillButton, style: orderStatusLinkStyle),
                      Container(color: Colors.blue, height: 1)
                    ])))
            : Container()
      ]),
      InkWell(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(3),
              child: Text(' $orderStatus ', style: orderStatusStyle)),
          onTap: orderCallBack)
    ]);
  }
}
