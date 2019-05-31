import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';

///开台服务界面
class ServiceControl extends StatefulWidget {
  @override
  _ServiceControlState createState() => _ServiceControlState();
}

class _ServiceControlState extends State<ServiceControl> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("开台服务"),
        centerTitle: true,
      ),
      body: Container(
        height: window.physicalSize.height,
        width: window.physicalSize.width,
        decoration: new BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Color(ColorsStyle.white)
        ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1))),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 250.0,
                child: PlusDecreaseInput(textEditingController: controller)
            ),
            Container(
                width: 250.0,
                child: PlusDecreaseInput(textEditingController: controller)
            ),
          ],
        ),
      ),
    );
  }
}

class PlusDecreaseInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  final double inputWidth;
  final double inputHeight;
  final double fontSize;

  PlusDecreaseInput(
      {Key key,
      @required this.textEditingController,
      this.inputWidth,
      this.inputHeight=60.0,
      this.fontSize=30.0,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        new IconButton(
          icon: Image.asset(
            "static/images/icon_decrease.png",
            height: 60.0,
            width: 60.0,
          ),
          onPressed: () {
            if (textEditingController.text.length > 0) {
              int num = int.parse(textEditingController.text);
              if(num>1) {
                num -= 1;
              }else{
                num=1;
              }
              textEditingController.text = num.toString();
            } else {
              textEditingController.text = "1";
            }
          },
        ),
        Expanded(
          child: Container(
            width: inputWidth,
            height: inputHeight,
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              style: TextStyle(
                fontSize: fontSize,
                color: Color(ColorsStyle.mainTextColor),
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  /*边角*/
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0), //边角为30
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1, //边线宽度为2
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color:Theme.of(context).primaryColor,
                  width: 1, //宽度为5
                )),
              ),
              controller: textEditingController,
              onChanged: onChanged,
            ),
          ),
        ),
        new IconButton(
          icon: Image.asset(
            "static/images/icon_plus.png",
            height: 60.0,
            width: 60.0,
          ),
          onPressed: () {
            if (textEditingController.text.length > 0) {
              int num = int.parse(textEditingController.text);
              if (num > 0) {
                num += 1;
              } else {
                num = 1;
              }
              textEditingController.text = num.toString();
            } else {
              textEditingController.text = "1";
            }
          },
        ),
      ],
    );
  }
}
