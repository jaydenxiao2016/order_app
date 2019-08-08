import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/common/utils/sp_util.dart';
import 'package:redux/redux.dart';

///网络设置界面
class NetSettingPage extends StatefulWidget {
  @override
  _NetSettingPageState createState() => _NetSettingPageState();
}

class _NetSettingPageState extends State<NetSettingPage> {
  final _urlController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _urlController.text=SpUtil.getString(Config.BASH_URL_KEY,defValue: Config.BASE_URL);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      return new Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(CommonUtils.getLocale(context).service)),
        body: Container(
          color: Colors.black,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(ColorsStyle.white),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              height: ScreenUtil.getInstance().setWidth(380),
              padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30)),
              width: ScreenUtil.getInstance().setWidth(650),
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
                              child: new Icon(Icons.wifi),
                            ),
                            new Expanded(
                              child: new TextField(
                                controller: _urlController,
                                autofocus: false,
                                style: MyTextStyle.largeText,
                                decoration: new InputDecoration(
                                  labelText: CommonUtils.getLocale(context)
                                      .ipAddressTip,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear,
                                        color: Colors.black45),
                                    onPressed: () {
                                      _urlController.text = "";
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width: ScreenUtil.getInstance().setWidth(400),
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setWidth(20)),
                      child: new MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: new Text(CommonUtils.getLocale(context).appOk,
                            style: TextStyle(
                              fontSize: MyTextStyle.normalTextSize,
                            )),
                        onPressed: () {
                          _save(context, store);
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

  ///保存
  _save(BuildContext rootContext, Store<StateInfo> store) async {
    if (_urlController.text.length <= 0) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).ipAddressEmptyTip);
      return;
    }
    if (_urlController.text.startsWith("http")==false) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).ipAddressWrongTip);
      return;
    }
    SpUtil.putString(Config.BASH_URL_KEY, _urlController.text);
    HttpGo.reset();
    NavigatorUtils.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _urlController.dispose();
  }
}
