import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/route_path.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/control/language_setting.dart';
import 'package:order_app/page/control/stock_info.dart';
import 'package:order_app/widget/PlusDecreaseInput.dart';
import 'package:order_app/widget/flex_button.dart';
import 'package:order_app/widget/slide_bar.dart';

///开台服务界面
class ServiceControlPage extends StatefulWidget {
  @override
  _ServiceControlPageState createState() => _ServiceControlPageState();
}

class _ServiceControlPageState extends State<ServiceControlPage> {
  //成人
  TextEditingController _adultController = TextEditingController();

  //小孩
  TextEditingController _childrenController = TextEditingController();

  //桌号
  TextEditingController _tableNumController = TextEditingController();

  //密码
  TextEditingController _passwordController = TextEditingController();

  //午餐设置
  double _lunchItem;

  //晚餐设置
  double _dinnerItem;

  //时间设置
  double _timerItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
      appBar: AppBar(
        title: Text(CommonUtils.getLocale(context).service),
        centerTitle: true,
      ),
      body: Container(
        child: Container(
          width: window.physicalSize.width,
          decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Color(ColorsStyle.white)
          ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1))),
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              //库存信息
              Expanded(
                flex: 1,
                child: StockInfo(),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: LanguageSetting(),
                    ),
                    //客人位数信息
                    Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.0))),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: PlusDecreaseInput(
                                textEditingController: _adultController,
                                titleWidth: 200.0,
                                title: CommonUtils.getLocale(context).adult,
                              )),
                              Expanded(
                                  child: PlusDecreaseInput(
                                textEditingController: _childrenController,
                                titleWidth: 200.0,
                                title: CommonUtils.getLocale(context).children,
                              )),
                              Expanded(
                                  child: PlusDecreaseInput(
                                textEditingController: _tableNumController,
                                titleWidth: 200.0,
                                title: CommonUtils.getLocale(context).tableNum,
                              )),
                              Expanded(
                                  child: PlusDecreaseInput(
                                textEditingController: _passwordController,
                                titleWidth: 200.0,
                                decreaseVisible: false,
                                plusVisible: false,
                                title: CommonUtils.getLocale(context).password,
                              )),
                            ],
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    //设置信息
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0))),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: SlideBar(
                                title: CommonUtils.getLocale(context).lunchItem,
                                titleFontSize: 18.0,
                                titleColor: Colors.redAccent,
                                onChanged: (value) {
                                  _lunchItem = value;
                                },
                                min: 0.0,
                                max: 10.0,
                                value: 5.0,
                                divisions: 10,
                              ),
                            ),
                            Expanded(
                              child: SlideBar(
                                title:
                                    CommonUtils.getLocale(context).dinnerItem,
                                titleFontSize: 18.0,
                                titleColor: Colors.redAccent,
                                onChanged: (value) {
                                  _dinnerItem = value;
                                },
                                min: 0.0,
                                max: 10.0,
                                value: 5.0,
                                divisions: 10,
                              ),
                            ),
                            Expanded(
                              child: SlideBar(
                                title: CommonUtils.getLocale(context).timer,
                                titleFontSize: 18.0,
                                titleColor: Colors.redAccent,
                                onChanged: (value) {
                                  _timerItem = value;
                                },
                                min: 0.0,
                                max: 30.0,
                                value: 15.0,
                                divisions: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //操作信息
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: FlexButton(
                                  color: Colors.deepOrange,
                                  textColor: Colors.white,
                                  text: CommonUtils.getLocale(context).lunch,
                                  onPress: () {
                                    _startToMenu(
                                        context, RoutePath.CUSTOM_MENU_PATH);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                              ),
                              Expanded(
                                child: FlexButton(
                                  color: Colors.deepOrange,
                                  textColor: Colors.white,
                                  text: CommonUtils.getLocale(context).dinner,
                                  onPress: () {
                                    _startToMenu(
                                        context, RoutePath.CUSTOM_MENU_PATH);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///开始点餐
  _startToMenu(BuildContext context, String path) {
    if (_adultController.text.length <= 0 || _adultController.text == '0') {
      Fluttertoast.showToast(msg: "成人数不能为空");
      return;
    }
    if (_tableNumController.text.length <= 0) {
      Fluttertoast.showToast(msg: "台号不能为空");
      return;
    }
    if (_passwordController.text.length <= 0) {
      Fluttertoast.showToast(msg: "密码不能为空");
      return;
    }
    NavigatorUtils.pushReplacementNamed(context, path);
  }

  @override
  void dispose() {
    super.dispose();
    _adultController.dispose();
    _childrenController.dispose();
    _tableNumController.dispose();
    _passwordController.dispose();
  }
}
