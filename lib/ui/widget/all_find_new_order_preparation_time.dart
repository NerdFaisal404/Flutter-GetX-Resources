import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/model/order/order.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:get/get.dart';
import 'animation/bounceeffect.dart';

class AllFindNewOrderPreparationTime extends StatelessWidget {
  final List<PreparationTimeList> preparationTimeList;
  final PreparationTimeDefault preparationTimeDefault;
  final int index;

  final _allFindController = Get.put(AllFindController());

  AllFindNewOrderPreparationTime(
      {this.preparationTimeList, this.preparationTimeDefault, this.index});

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 1),
        Text(labelPreparationTime, style: preparationTimeStyle),
        Row(children: [
          Expanded(
              flex: 2500,
              child: Row(
              children: preparationTimeList
                  .map((item) => Container(
                  padding: EdgeInsets.all(10),
                  child: Obx(() => BouncingWidget(
                    scaleFactor: 1.5,
                    child: Text('${item.time}',
                        style: item.isSelect.value
                            ? preparationTimeSelectStyle
                            : preparationTimeUnSelectStyle),
                    onPressed: () {
                      _allFindController.preparationTimeSelect(
                          item, preparationTimeDefault, index);
                    },
                  ))))
                  .toList())),
          Expanded(
              flex: 1200,
              child:  Row(children: [
            GestureDetector(
                onTap: () {
                  _allFindController.timeSelectMinus(
                      _allFindController.isTimeSelect.value
                          ? preparationTimeDefault.selectTime.value
                          : preparationTimeDefault.defaultTime.value,
                      preparationTimeList,
                      preparationTimeDefault);
                },
                child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: preparationTimeDecoration,
                    child: Icon(minusIcon, color: Colors.red, size: 12))),
            SizedBox(width: 10),
            Obx(() => Text(
                _allFindController.isTimeSelect.value
                    ? '${preparationTimeDefault.selectTime}'.padLeft(2, '0')
                    : '${preparationTimeDefault.defaultTime}'.padLeft(2, '0'),
                style: preparationTimeUnSelectStyle)),
            SizedBox(width: 2),
            Text(labelMin, style: preparationTimeMinHourStyle),
            SizedBox(width: 10),
            GestureDetector(
                child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: preparationTimeDecoration,
                    child: Icon(plusIcon, color: Colors.red, size: 12)),
                onTap: () {
                  _allFindController.timeSelectPlus(
                      _allFindController.isTimeSelect.value
                          ? preparationTimeDefault.selectTime.value
                          : preparationTimeDefault.defaultTime.value,
                      preparationTimeList,
                      preparationTimeDefault);
                })
          ]))
        ]),
        SizedBox(height: 20)
      ]);
}
