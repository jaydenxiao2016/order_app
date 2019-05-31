import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';

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
    new Future.delayed(const Duration(seconds: 2), () {
      NavigatorUtils.goLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<StateInfo>(
      builder: (context, store) {
        return Scaffold(
          body: Container(
            color: Color(ColorsStyle.white),
            child: Stack(
              children: <Widget>[
                new Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset(
                      'static/images/bg_logo.jpg',
                      width: 120.0,
                      height: 120.0,
                    ),
                  ),
                ),
                new Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                      CommonUtils.getLocale(context).appName,
                      style: TextStyle(
                        color: Color(ColorsStyle.mainTextColor),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
