import 'package:flutter/material.dart';

///充满的button
class FlexButton extends StatelessWidget {
  //文字
  final String text;
  //背景颜色
  final Color color;
  //字体颜色
  final Color textColor;
  //点击返回
  final VoidCallback onPress;
  //字体大小
  final double fontSize;
  //最大行数
  final int maxLines;
  //主方向对齐方式
  final MainAxisAlignment mainAxisAlignment;

  FlexButton(
      {Key key,
      this.text,
      this.color,
      this.textColor,
      this.onPress,
      this.fontSize = 20.0,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
        padding: new EdgeInsets.only(
            left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
        textColor: textColor,
        color: color,
        child: new Flex(
          mainAxisAlignment: mainAxisAlignment,
          direction: Axis.horizontal,
          children: <Widget>[
            new Text(text,
                style: new TextStyle(fontSize: fontSize),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis)
          ],
        ),
        onPressed: () {
          this.onPress?.call();
        });
  }
}
