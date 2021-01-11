import 'package:flutter/material.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/animation/slide_in_transition.dart';
import 'package:food_cafe/ui/widget/header_container.dart';
import 'package:food_cafe/ui/widget/rounded_shadow_container.dart';

class NotificationPage extends StatefulWidget {
  @override
  createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  SlideInController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = SlideInController(vsync: this);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HeaderContainer(
            child: Column(children: <Widget>[
      _buildHeader(context),
      Expanded(
          child: SlideInTransition(
              controller: _animationController,
              child: RoundedShadowContainer(child: Container(child: _notificationList(), margin: EdgeInsets.only(top: 15)))))
    ])));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              SizedBox(width: double.infinity),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  icon: Icon(backIcon)),
              Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 34.0, vertical: 10.0),
                  child: _notificationHeader())
            ])));
  }

  _notificationHeader() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('TOTAL NOTIFICATION', style: notificationTitleStyle),
          Text('00', style: totalNotificationStyle)
        ]);
  }

  _notificationList() {
    return ListView.builder(
        key: const Key('debtors-list'),
        itemCount: 20,
        itemBuilder: (BuildContext context, int i) {
          return Card(
              elevation: cardViewElevation,
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            child: Text('10-11-2020 4:45 PM',
                                style: dateTimeStyle),
                            alignment: Alignment.topRight),
                        Text('Title', style: getNotificationTitleStyle),
                        Text('Message', style: getNotificationDescriptionStyle)
                      ])));
        });
  }
}
