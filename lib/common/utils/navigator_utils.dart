import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_app/common/config/route_path.dart';

///导航栏
class NavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///切换有参数页面
  static navigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context, new CupertinoPageRoute(builder: (context) => widget));
  }

  ///主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, RoutePath.HOME_PATH);
  }

  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, RoutePath.LOGIN_PATH);
  }
  ///客户工作台
  static goCustomMenuPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, RoutePath.CUSTOM_MENU_PATH);
  }

}
