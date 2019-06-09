import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';

///带增加减少的输入框
class PlusDecreaseText extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;

  final String decreaseImg;
  final String plusImg;
  final bool decreaseVisible;
  final bool plusVisible;
  final Color color;
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

  PlusDecreaseText({Key key,
    @required this.textEditingController,
    this.title,
    this.titleVisible = true,
    this.decreaseImg = "static/images/icon_decrease.png",
    this.plusImg = "static/images/icon_plus.png",
    this.decreaseVisible = true,
    this.plusVisible = true,
    this.color=const Color(ColorsStyle.mainTextColor),
    this.inputWidth,
    this.inputHeight = 50.0,
    this.fontSize = 30.0,
    this.titleFontSize = 25.0,
    this.titleColor = Colors.orange,
    this.onChanged})
      : super(key: key){
    textEditingController.text="0";
  }

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
          child: Container(
            height: 65.0,
            width: 65.0,
            child: IconButton(
              icon:Image.asset(
                  decreaseImg,
                ),
              onPressed: () {
                if (textEditingController.text.length > 0) {
                  int num = int.parse(textEditingController.text);
                  if (num > 0) {
                    num -= 1;
                  } else {
                    num = 0;
                  }
                  textEditingController.text = num.toString();
                } else {
                  textEditingController.text = "0";
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: inputWidth,
            height: inputHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              enabled: false,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
              ),
              controller: textEditingController,
              onChanged: onChanged,
            ),
          ),
        ),
        Opacity(
          opacity: plusVisible ? 1.0 : 0.0,
          child: Container(
            height: 65.0,
            width: 65.0,
            child: IconButton(
              icon: Image.asset(
               plusImg,
                height: 80.0,
                width: 80.0,
              ),
              onPressed: () {
                if (textEditingController.text.length > 0) {
                  int num = int.parse(textEditingController.text);
                  if (num >= 0) {
                    num += 1;
                  } else {
                    num = 0;
                  }
                  textEditingController.text = num.toString();
                } else {
                  textEditingController.text = "0";
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}