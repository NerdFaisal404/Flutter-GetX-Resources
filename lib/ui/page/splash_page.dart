import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  @override
  build(BuildContext context) => GetBuilder<SplashController>(
      builder: (controller) => Scaffold(
          body: Center(child: Text(appName, style: splashTitleStyle))));
}
