import 'package:flutter/material.dart';
import 'package:food_cafe/model/order/order.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/utils/extensions.dart';

class DeliveryPersonInformation extends StatelessWidget {
  final DeliveryPersonDetail deliveryPersonDetail;

  DeliveryPersonInformation({this.deliveryPersonDetail});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 10),
      Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: borderDeliveryPersonInformationColor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Image.asset(deliveryBoyImage, scale: 4),
              SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(deliveryPersonDetail.name, style: deliveryPersonNameStyle),
                Row(children: [
                  Text(
                      '$deliveryBoyArrivingIn ${deliveryPersonDetail.arrivingDateTime}',
                      style: arrivingMinuteStyle),
                  SizedBox(width: 8),
                  Text('$otp : ${deliveryPersonDetail.otp}',
                      style: otpLabelStyle)
                ])
              ])
            ]),
            GestureDetector(child: Image.asset(callImage, scale: 4), onTap: (){
              deliveryPersonDetail.mobileNo.mobileCalling();
            })
          ])),
      SizedBox(height: 10)
    ]);
  }
}
