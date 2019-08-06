import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///欢迎页
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;
    CommonUtils.initStatusBarHeight(context);
    //2s后跳到主页
    new Future.delayed(const Duration(seconds: 0), () {
      NavigatorUtils.goLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: Config.SCREEN_WIDTH,
        height: Config.SCREEN_HEIGHT,
        allowFontScaling: true)
      ..init(context);
    return StoreBuilder<StateInfo>(
      builder: (context, store) {
        return Scaffold(
          body: Container(
            color: Colors.black,
            width: window.physicalSize.width,
            height: window.physicalSize.height,
          ),
        );
      },
    );
  }
}
