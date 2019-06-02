import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';

///登录界面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      return new Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(CommonUtils
                .getLocale(context)
                .loginTitle)),
        body: Container(
          decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme
                    .of(context)
                    .primaryColor,
                Color(ColorsStyle.white)
              ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1))),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(ColorsStyle.white),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              height: 270.0,
              padding: EdgeInsets.all(20.0),
              width: 300.0,
              child: new SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Padding(
                              padding:
                              new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: new Icon(Icons.account_circle),
                            ),
                            new Expanded(
                              child: new TextField(
                                controller: _userNameController,
                                autofocus: false,
                                keyboardType: TextInputType.phone,
                                decoration: new InputDecoration(
                                  labelText: CommonUtils
                                      .getLocale(context)
                                      .loginUserTitle,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear,
                                        color: Colors.black45),
                                    onPressed: () {
                                      _userNameController.text = "";
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    new Padding(
                      padding:
                      new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 30.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Padding(
                              padding:
                              new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: new Icon(Icons.https),
                            ),
                            new Expanded(
                              child: new TextField(
                                controller: _passwordController,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  labelText: CommonUtils
                                      .getLocale(context)
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
                    Container(
                      width: 230.0,
                      child: new MaterialButton(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        child: new Text(CommonUtils
                            .getLocale(context)
                            .login),
                        onPressed: () {
                          _login(context);
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
  _login(BuildContext context) {
//    if (_userNameController.text.length <= 0) {
//      Fluttertoast.showToast(
//          msg: CommonUtils.getLocale(context).loginUserEmpty);
//      return;
//    }
//    if (_passwordController.text.length <= 0) {
//      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loginPswEmpty);
//      return;
//    }
//    print("用户名：" + _userNameController.text + "密码：" + _passwordController.text);
    NavigatorUtils.goCustomMenuPage(context);
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }
}
