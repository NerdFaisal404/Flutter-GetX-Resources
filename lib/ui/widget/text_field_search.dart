import 'package:flutter/material.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/font.dart';
import 'package:food_cafe/resource/images.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:get/get.dart';

class TextFieldSearch extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  final VoidCallback callBack;
  final RxBool isVisibleSearchClearIcon;

  TextFieldSearch(
      {@required this.isVisibleSearchClearIcon,
      @required this.textEditingController,
      @required this.onChanged,
      @required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(1),
        height: 50,
        margin: EdgeInsets.all(10),
        child: TextField(
            controller: textEditingController,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.words,
            cursorColor: appBarTitleColor,
            style: TextStyle(fontSize: 15, fontFamily: regularFont),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                suffixIcon: isVisibleSearchClearIcon.value
                    ? IconButton(
                        icon:
                            Icon(searchClearIcon, size: 20, color: Colors.grey),
                        onPressed: callBack)
                    : IconButton(
                        icon: Icon(searchIcon, size: 20, color: Colors.grey),
                        onPressed: () {}),
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10.0)),
                    borderSide: BorderSide(color: searchBorderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10.0)),
                    borderSide: BorderSide(color: searchBorderColor)),
                filled: true,
                hintStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: regularFont,
                    color: Colors.grey[800],
                    textBaseline: TextBaseline.alphabetic),
                hintText: hintSearch,
                fillColor: searchBackgroundColor)));
  }
}
