import 'package:flutter/material.dart';
///避免多次连续点击
class AvoidDoubleClickInkWell extends StatelessWidget {
  //点击返回
  final VoidCallback onTap;

  //
  final Widget child;

  //上次点击时间 初始化的时候是空，下面会做判断
  DateTime _lastPressedAdt;

  AvoidDoubleClickInkWell({
    Key key,
        this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: child,
      onTap: () {
        if (_lastPressedAdt == null ||
            DateTime.now().difference(_lastPressedAdt) > Duration(seconds: 1)) {
          if (onTap != null) {
            print("点击了");
            onTap();
          }
        }
        _lastPressedAdt = DateTime.now();
      },
    );
  }
}
