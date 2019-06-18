import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';
///滑动块
class SlideBar extends StatefulWidget {
  ///标题
  final String title;

  ///标题字体大小
  final double titleFontSize;

  ///标题颜色
  final Color titleColor;
  double max;
  double min;
  int divisions;
  num value;
  final ValueChanged<double> onChanged;

  @override
  _SlideBarState createState() => new _SlideBarState();

  SlideBar({Key key,
    this.max = 100,
    @required this.title,
    this.titleFontSize = 15.0,
    this.titleColor = Colors.orange,
    this.min = 0,
    this.divisions = 1000,
    this.value,
    this.onChanged,
  }) :super(key: key);
}

class _SlideBarState extends State<SlideBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        //标题
        Container(
          width: 150.0,
          child: Text(widget.title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: widget.titleFontSize,
            color: widget.titleColor,
          )),
        ),
        //内容
        Container(
          padding: EdgeInsets.all(5.0),
          width: 45.0,
          margin: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
          decoration: BoxDecoration(
            color: Color(ColorsStyle.white),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
          child: Text(widget.value.toInt().toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(ColorsStyle.mainTextColor),
            ),
          ),
        ),
        //滑动块
        Expanded(
          child: new Slider(
            value: widget.value,
            max: widget.max,
            min: widget.min,
            label: widget.value.toInt().toString(),
            divisions: widget.divisions,
            activeColor: Colors.blue,
            onChanged: (double val) {
              this.setState(() {
                widget.value = val;
              });
              if(widget.onChanged!=Null) {
                widget.onChanged(val);
              }
            },
          ),
        ),
      ],
    );
  }
}