import 'package:flutter/material.dart';
import 'package:food_cafe/controller/controller.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:get/get.dart';
import 'package:food_cafe/utils/extensions.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEditPage> {
  var _profileEditController = Get.put(ProfileEditController());

  final GlobalKey<FormState> _key = GlobalKey();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          elevation: 0.3,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
          title: Text(titleChangeProfile, style: appBarTitleStyle)),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [_formUI()])));

  _formUI() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        _formIcon(),
        widget.size(heightScale: 30.0),
        _userNameInput(),
        _mobileInput(),
        _pinCodeInput(),
        _addressInput(),
        widget.size(heightScale: 20.0),
        _loginPress(),
        SizedBox(height: 10.0),
      ]));

  _formIcon() => Column(children: [
        Obx(() => CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.withOpacity(0.1),
            backgroundImage: _profileEditController.profileURL.value.isEmpty
                ? ExactAssetImage(profileImage)
                : NetworkImage(_profileEditController.profileURL.value))),
        Text(_profileEditController.userName.value, style: appBarTitleStyle)
      ]);

  _loginPress() => Align(alignment: Alignment.bottomCenter).customFloatForm(
      color: appBarTitleColor,
      stateStatus: _profileEditController.stateStatus.value,
      icon: Icons.navigate_next,
      isMini: false,
      qrCallback: () => _loginValidate());

  _loginValidate() {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_key.currentState.validate()) {
      _key.currentState.save();
      _profileEditController.callProfile();
    } else {
      _profileEditController.checkAutoValidate();
    }
  }

  _userNameInput() => widget.inputField(
        _profileEditController.userNameController,
        validation: _profileEditController.isUserNameValid,
        onChanged: _profileEditController.changeUserName,
        labelText: hintUserName,
        keyboardType: TextInputType.text,
      );

  _mobileInput() => widget.inputField(
        _profileEditController.mobileController,
        validation: _profileEditController.isMobileValid,
        onChanged: _profileEditController.changeMobile,
        maxLength: mobileMaxLength,
        labelText: hintMobile,
        keyboardType: TextInputType.number,
      );

  _pinCodeInput() => widget.inputField(
        _profileEditController.pinCodeController,
        validation: _profileEditController.isPinCodeValid,
        onChanged: _profileEditController.changePinCode,
        labelText: hintPinCode,
        maxLength: pinCodeMaxLength,
        keyboardType: TextInputType.number,
      );

  _addressInput() => widget.inputField(
        _profileEditController.addressController,
        validation: _profileEditController.isAddressValid,
        onChanged: _profileEditController.changeAddress,
        labelText: hintAddress,
        keyboardType: TextInputType.text,
      );
}
