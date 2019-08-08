import 'dart:io';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/route_path.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/model/login_response_entity.dart';
import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/login_info_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:redux/redux.dart';

import 'net_setting_page.dart';

///登录界面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = new TextEditingController();
  ///1:工作台 2：控制台
  String type="1";

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      return new Scaffold(
        appBar: AppBar(
          title: Text(CommonUtils.getLocale(context).loginTitle),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              onTap: () {
                NavigatorUtils.navigatorRouter(context, new NetSettingPage());
              },
              child: Container(
                padding: EdgeInsets.only(left:20.0,right: 20.0),
                child: Image.asset(
                  'static/images/icon_setting.png',color:Colors.white,
                  height: ScreenUtil.getInstance().setWidth(45),
                  width: ScreenUtil.getInstance().setWidth(45),
                ),
              ),
            )
          ],
        ),

        body: Container(
          color: Colors.black,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(ColorsStyle.white),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              height: ScreenUtil.getInstance().setWidth(450),
              padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30)),
              width: ScreenUtil.getInstance().setWidth(600),
              child: new SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Padding(
                              padding:
                                  new EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: new Icon(Icons.https),
                            ),
                            new Expanded(
                              child: new TextField(
                                controller: _passwordController,
                                autofocus: false,
                                style: MyTextStyle.largeText,
                                decoration: new InputDecoration(
                                  labelText: CommonUtils.getLocale(context)
                                      .loginPswTip,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear,
                                        color: Colors.black45),
                                    onPressed: () {
                                      _passwordController.text = "";
                                    },
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ]),
                    ),
                    Row(
                      children: <Widget>[
                        ///工作台
                        Expanded(
                          child: RadioListTile<String>(
                            value: "1",
                            title: Text(
                              CommonUtils.getLocale(context).workbenchTitle,
                              style: TextStyle(
                                fontSize: MyTextStyle.normalTextSize,
                              ),
                            ),
                            groupValue:type,
                            onChanged: (value) {
                              this.setState(() {
                                type="1";
                              });
                            },
                          ),
                        ),

                        ///控制台
                        Expanded(
                          child: RadioListTile<String>(
                            value: "2",
                            title: Text(
                                CommonUtils.getLocale(context).controlTitle,
                                style: TextStyle(
                                  fontSize: MyTextStyle.normalTextSize,
                                )),
                            groupValue:type,
                            onChanged: (value) {
                              this.setState(() {
                                type="2";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: ScreenUtil.getInstance().setWidth(400),
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setWidth(20)),
                      child: new MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: new Text(CommonUtils.getLocale(context).login,
                            style: TextStyle(
                              fontSize: MyTextStyle.normalTextSize,
                            )),
                        onPressed: () {
                          _login(context, store);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  ///登录
  _login(BuildContext rootContext, Store<StateInfo> store) async{
    if (_passwordController.text.length <= 0) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loginPswEmpty);
      return;
    }
    String macAddress;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      //ios相关代码
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      macAddress=iosInfo.identifierForVendor;
    }else if(Platform.isAndroid){
      //android相关代码
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      macAddress=androidInfo.id;
    }
    await HttpGo.getInstance().post(UrlPath.signInPath, params: {
      'mac': macAddress,
      'pwd': _passwordController.text,
      "type":type
    }).then((baseResult) {
      LoginResponseEntity loginInfo =
      LoginResponseEntity.fromJson(baseResult.data);
      loginInfo.orderMasterEntity =
          OrderMasterEntity(orderRounds: new List());
      print(loginInfo);
      store.dispatch(RefreshLoginInfoAction(loginInfo));
      if("1"==type) {
        NavigatorUtils.pushReplacementNamed(
            rootContext, RoutePath.SERVICE_CONTROL_PATH);
      }else{
        NavigatorUtils.pushNamed(rootContext, RoutePath.CONSOLE_PATH);
      }
    }).catchError((error) {
      if(error is int &&error==101){
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).tableUsingTip);
      }else {
        Fluttertoast.showToast(msg: error.toString());
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }
}
