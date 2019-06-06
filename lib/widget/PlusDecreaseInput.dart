import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';

///带增加减少的输入框
class PlusDecreaseInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;

  final bool decreaseVisible;
  final bool plusVisible;

  ///输入框宽
  final double inputWidth;

  ///输入框高
  final double inputHeight;

  ///输入框字体大小
  final double fontSize;

  ///标题是否可见
  final bool titleVisible;

  ///标题
  final String title;

  ///标题字体大小
  final double titleFontSize;

  ///标题颜色
  final Color titleColor;

  PlusDecreaseInput({Key key,
    @required this.textEditingController,
    this.title,
    this.titleVisible = true,
    this.decreaseVisible = true,
    this.plusVisible = true,
    this.inputWidth,
    this.inputHeight = 50.0,
    this.fontSize = 30.0,
    this.titleFontSize = 25.0,
    this.titleColor = Colors.orange,
    this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //输入框
    return Row(
      children: <Widget>[
        //标题
        Offstage(
          offstage: titleVisible,
          child: Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
            color: titleColor,
          )),
        ),
        Opacity(
          opacity: decreaseVisible ? 1.0 : 0.0,
          child: IconButton(
            icon: Image.asset(
              "static/images/icon_decrease.png",
              height: 60.0,
              width: 60.0,
            ),
            onPressed: () {
              if (textEditingController.text.length > 0) {
                int num = int.parse(textEditingController.text);
                if (num > 1) {
                  num -= 1;
                } else {
                  num = 1;
                }
                textEditingController.text = num.toString();
              } else {
                textEditingController.text = "1";
              }
            },
          ),
        ),
        Expanded(
          child: Container(
            width: inputWidth,
            height: inputHeight,
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
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
                      color: Theme
                          .of(context)
                          .primaryColor,
                      width: 1, //宽度为5
                    )),
              ),
              controller: textEditingController,
              onChanged: onChanged,
            ),
          ),
        ),
        Opacity(
          opacity: plusVisible ? 1.0 : 0.0,
          child: IconButton(
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
        ),
      ],
    );
  }
}