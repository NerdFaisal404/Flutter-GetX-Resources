import 'package:flutter/material.dart';
import 'package:food_cafe/resource/colors.dart';
import 'package:food_cafe/resource/style.dart';
import 'package:food_cafe/resource/value.dart';
import 'package:get/get.dart';
import 'text_field_search.dart';

class DialogSearch extends StatelessWidget {
  final VoidCallback callBackCancel;
  final VoidCallback callFind;
  final VoidCallback callSearchClear;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final RxBool isVisibleSearchClearIcon;

  DialogSearch(
      {@required this.callBackCancel,
      @required this.callFind,
      @required this.isVisibleSearchClearIcon,
      @required this.callSearchClear,
      @required this.textEditingController,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(top: 57),
          width: double.infinity,
          child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(4.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFieldSearch(
                        isVisibleSearchClearIcon: isVisibleSearchClearIcon,
                        textEditingController: textEditingController,
                        callBack: callSearchClear,
                        onChanged: onChanged),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      FlatButton(
                          //splashColor: appBarTitleColor,
                          //highlightColor: appBarTitleColor,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: appBarTitleColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(cancelButton, style: btnCancelStyle),
                          onPressed: callBackCancel),
                      SizedBox(width: 10),
                      FlatButton(
                          //splashColor: appBarTitleColor,
                          //highlightColor: appBarTitleColor,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(findButton, style: btnFindStyle),
                          onPressed: callFind),
                      SizedBox(width: 15)
                    ])
                  ]))));
}
