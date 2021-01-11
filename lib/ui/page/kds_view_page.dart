import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/custom_slidable/slidable.dart';
import 'package:food_cafe/ui/widget/custom_slidable/slidable_action_pane.dart';
import 'package:food_cafe/ui/widget/custom_slidable/slide_action.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class KDSViewPage extends StatelessWidget {
  KDSViewPage({Key key}) : super(key: key);
  final _kdsViewController = Get.put(KDSViewController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _kdsViewController.stateStatus.value == StateStatus.LOADING
        ? dataCircleProgressIndicator()
        : Column(children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    child: _kdsViewController.rxKDSViewList.isEmpty
                        ? emptyWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _kdsViewController.rxKDSViewList.length,
                            itemBuilder: (context, index) {
                              var kdsView =
                                  _kdsViewController.rxKDSViewList[index];
                              return Column(children: [
                                Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.25,
                                    child: _itemMenuPause(
                                        menu: kdsView.menuName,
                                        stockCounter: kdsView.stockCounter),
                                    secondaryActions: <Widget>[
                                      IconSlideAction(
                                          caption: kdsView.isPause
                                              ? 'Pause'
                                              : 'Start',
                                          color: Colors.deepOrange,
                                          onTap: () {})
                                    ]),
                                Container(
                                    padding: EdgeInsets.only(top: 2, bottom: 2),
                                    child: Dash(
                                        length: Get.width - 35,
                                        dashColor: Colors.grey,
                                        dashThickness: 1,
                                        dashLength: 2))
                              ]);
                            })))
          ]));
  }

  _itemMenuPause({String menu, double stockCounter}) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 0.0, right: 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: [
                          SizedBox(width: 10),
                          Text(menu,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kdsViewTitleStyle)
                        ]),
                        Text('$quantitySymbol $stockCounter',
                            style: kdsViewAmountStyle)
                      ]))
            ]));
  }
}
