import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/model/turn_of_ordering/turn_of_ordering_response.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class TurnOfOrderingPage extends StatefulWidget {
  @override
  createState() => _TurnOfOrderingState();
}

class _TurnOfOrderingState extends State<TurnOfOrderingPage> {
  var _turnOfOrderingController = TurnOfOrderingController();

  @override
  void initState() {
    super.initState();
    _turnOfOrderingController.callTurnOfOrdering();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.3,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(titleTurnOfOrdering, style: appBarTitleStyle)),
        body: Obx(() => _turnOfOrderingController.stateStatus.value ==
                StateStatus.LOADING
            ? Container().dataCircleProgressIndicator()
            : _turnOfOrderingController
                    .turnOfOrderingResponse.value.turnOfOrderingList.isEmpty
                ? widget.emptyWidget()
                : ListView.builder(
                    itemCount: _turnOfOrderingController
                        .turnOfOrderingResponse.value.turnOfOrderingList.length,
                    itemBuilder: (context, index) {
                      TurnOfOrdering turnOfOrdering = _turnOfOrderingController
                          .turnOfOrderingResponse
                          .value
                          .turnOfOrderingList[index];
                      return Container(
                          margin: EdgeInsets.all(0),
                          child: Card(
                              elevation: cardViewElevation,
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(turnOfOrdering.userName,
                                                  style:
                                                      turnOfOrderingNameStyle),
                                              Text(turnOfOrdering.dateTime,
                                                  style: dateTimeStyle)
                                            ]),
                                        Text(turnOfOrdering.recipeName,
                                            style: turnOfOrderingMenuStyle),
                                        Text(
                                            '$availableOn ${turnOfOrdering.availableRecipe}',
                                            style: menuAvailableStyle)
                                      ]))));
                    })));
  }
}
