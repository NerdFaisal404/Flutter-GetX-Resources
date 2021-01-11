import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/font.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:food_cafe/ui/widget/icon_shadow.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'state_status.dart';

extension DynamicUtil on dynamic {
  bool get isNull => GetUtils.isNull(this);

  bool get isNullOrBlank => GetUtils.isNullOrBlank(this);

  void printError(
          {String info = '', Function logFunction = GetUtils.printFunction}) =>
      logFunction('Error: ${this.runtimeType}', this, info, isError: true);

  void printInfo(
          {String info = '',
          Function printFunction = GetUtils.printFunction}) =>
      printFunction('Info: ${this.runtimeType}', this, info);
}

extension ContextExtensions on BuildContext {
  double widthInPercent(double percent) {
    var toDouble = percent / 100;
    return MediaQuery.of(this).size.width * toDouble;
  }

  double heightInPercent(double percent) {
    var toDouble = percent / 100;
    return MediaQuery.of(this).size.height * toDouble;
  }

  showProgress() {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) => Container(
            alignment: FractionalOffset.center,
            child: CircularProgressIndicator(strokeWidth: 1)));
  }

  void hideProgress() {
    Navigator.pop(this);
  }

  void toast({String message}) {
    Flushbar(
      boxShadows: [
        BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0)
      ],
      margin: const EdgeInsets.all(0),
      borderRadius: 0,
      backgroundColor: backgroundColor,
      messageText: Text(message, style: flushBarMessageStyle),
      duration: const Duration(seconds: 3),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeOut,
      animationDuration: const Duration(milliseconds: 500),
      flushbarStyle: FlushbarStyle.FLOATING,
    )..show(this);
  }
}

extension ValiationExtensions on String {
  mobileCalling() => launch('tel:'+ this);

  pastOrderColor(){
    switch (this){
      case 'completed':
        return pastOrderSettled;
        break;

      case 'rejected':
        return pastOrderRejected;
        break;

      case 'canceled':
        return pastOrderRejected;
        break;
    }
  }

  validateEmail() {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);
    if (this.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(this)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  validatePassword() {
    if (this.isEmpty) {
      return 'Password is required';
    } else if (this.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  validateMobile() {
    var pattern = r'(^[0-9]*$)';
    var regExp = RegExp(pattern);
    if (this.replaceAll(" ", "").isEmpty) {
      return 'Mobile is required';
    } else if (this.replaceAll(" ", "").length != 10) {
      return 'Mobile number must 10 digits';
    } else if (!regExp.hasMatch(this.replaceAll(" ", ""))) {
      return 'Mobile number must be digits';
    }
    return null;
  }

  String validUserName() {
    var pattern = r'(^[a-zA-Z]*$)';
    var regExp = RegExp(pattern);
    if (this.isEmpty) {
      return 'Name is required';
    } else if (!regExp.hasMatch(this)) {
      return 'Name must be a-z and A-Z';
    }
    return null;
  }

  String validateAddress() {
    var pattern = r'(^[a-zA-Z0-9-., ]*$)';
    var regExp = RegExp(pattern);
    if (this.isEmpty) {
      return 'Address is required';
    } else if (!regExp.hasMatch(this)) {
      return 'Address must be text and numeric';
    }
    return null;
  }

  String validatePinCode() {
    if (this.isEmpty) {
      return 'Pin code is required';
    } else if (this.length < 6) {
      return 'Pin code must be 6 characters';
    }
    return null;
  }

  String validateCurrentPassword() {
    if (this.isEmpty) {
      return 'Current password required';
    } else if (this.length < 6) {
      return 'Current password must be at least 6 characters';
    }
    return null;
  }

  String validateNewPassword() {
    if (this.isEmpty) {
      return 'New password required';
    } else if (this.length < 6) {
      return 'New password must be at least 6 characters';
    }
    return null;
  }

  bool validationEqual(String currentValue, String checkValue) {
    if (currentValue == checkValue) {
      return true;
    } else {
      return false;
    }
  }
}

extension WidgetExtensions on Widget {
  dataCircleProgressIndicator() => Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(strokeWidth: 1));

  emptyWidget() => Center(
      child: Text(dataNotAvailableMessage, style: dataNotAvailableStyle));

  emptySearchWidget() =>
      Text(noSearchResultMessage, style: searchDataNotAvailableStyle);

  inputField(TextEditingController textEditingController,
          {ValueChanged<String> onChanged,
          int maxLength,
          TextInputType keyboardType,
          String hintText,
          String labelText,
          int maxLines = 1,
          bool obscureText = false,
          InkWell inkWell,
          FormFieldValidator<String> validation}) =>
      TextFormField(
          controller: textEditingController,
          cursorColor: appBarTitleColor,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          style: TextStyle(fontFamily: regularFont),
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black, width: 1.0)),
              errorBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black, width: 1.0)),
              errorStyle: TextStyle(fontFamily: regularFont, color: Colors.red),
              labelStyle:
                  TextStyle(fontFamily: regularFont, color: Colors.black),
              suffixStyle:
                  TextStyle(fontFamily: regularFont, color: Colors.black),
              prefixStyle:
                  TextStyle(fontFamily: regularFont, color: Colors.black),
              counterStyle:
                  TextStyle(fontFamily: regularFont, color: Colors.black),
              helperStyle:
                  TextStyle(fontFamily: regularFont, color: Colors.black),
              hintText: hintText,
              counterText: '',
              labelText: labelText,
              suffix: inkWell),
          validator: validation);

  size({double widthScale = 0.0, double heightScale = 0.0}) =>
      SizedBox(width: widthScale, height: heightScale);

  socialIcon({Icon icon, backgroundColor: Colors, VoidCallback voidCallback}) =>
      Container(
          width: 40.0,
          height: 40.0,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
          child: RawMaterialButton(
              shape: CircleBorder(),
              onPressed: voidCallback,
              child: IconShadowWidget(icon)));

  roundCircleButton(
          {IconData iconData,
          Color color,
          bool isMini: true,
          VoidCallback voidCallback}) =>
      FloatingActionButton(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          mini: isMini,
          onPressed: voidCallback,
          child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientsButton)),
              child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[Icon(iconData, size: 30, color: color)])));

  customFloatForm(
          {IconData icon,
          Color color,
          VoidCallback qrCallback,
          bool isMini = false,
          StateStatus stateStatus}) =>
      FloatingActionButton(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          mini: isMini,
          onPressed: stateStatus != StateStatus.LOADING ? qrCallback : null,
          child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientsButton)),
              child: Stack(fit: StackFit.expand, children: <Widget>[
                stateStatus == StateStatus.LOADING
                    ? CircularProgressIndicator(strokeWidth: 1)
                    : Offstage(),
                Icon(icon, size: 30, color: color)
              ])));
}
