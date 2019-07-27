import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/config/route_path.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/event/timer_event.dart';
import 'package:order_app/common/event/timer_refresh_event.dart';
import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/login_info_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/control/service_control_page.dart';
import 'package:order_app/page/drink_record.dart';
import 'package:order_app/page/menu_drink_page.dart';
import 'package:order_app/page/menu_service_page.dart';
import 'package:order_app/widget/AvoidDoubleClickInkWell.dart';
import 'package:order_app/widget/flex_button.dart';
import 'package:redux/redux.dart';

import '../menu_food_page.dart';

///客户工作台
class CustomMenuPage extends StatefulWidget {
  @override
  _CustomMenuPageState createState() => _CustomMenuPageState();
}

class _CustomMenuPageState extends State<CustomMenuPage>
    with TickerProviderStateMixin {
  ///监听
  StreamSubscription stream;

  ///监听更新操作
  StreamSubscription streamUpdate;

  ///定时器
  Timer countdownTimer;

  ///倒计时总时长（秒）
  int currentTimeSecond = 0;

  ///时间字符串
  String get timerString {
    Duration duration = new Duration(seconds: currentTimeSecond);
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    ///监听触发计时器
    stream = CommonUtils.eventBus.on<TimerEvent>().listen((event) {
      ///获取最新订单详情
      _getOrderDetail();
    });

    ///监听更新操作
    streamUpdate = CommonUtils.eventBus.on<TimerFreshEvent>().listen((event) {
      print("接收到更新");
      if (!CommonUtils.getStore(context)
          .state
          .loginResponseEntity
          .setting
          .isTimeFinish) {
        print("更新");

        ///重新开始倒计时
        _startCountdown();
      }
    });
  }

  ///开始倒计时
  _startCountdown() {
    print("开始计时");
    currentTimeSecond = CommonUtils.getStore(context)
            .state
            .loginResponseEntity
            .setting
            .waitTime *
        60;
    if (countdownTimer != null) {
      countdownTimer.cancel();
      countdownTimer = null;
    }
    countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (currentTimeSecond > 0) {
        setState(() {
          currentTimeSecond = currentTimeSecond - 1;
        });
      } else {
        //倒计时结束
        countdownTimer.cancel();
        countdownTimer = null;
        Store<StateInfo> store = CommonUtils.getStore(context);
        store.state.loginResponseEntity.setting.isTimeFinish = true;
        store.dispatch(RefreshLoginInfoAction(store.state.loginResponseEntity));
      }
    });
  }

  ///获取主订单详情
  _getOrderDetail() async {
    print("获取订单详情");
    if (context == null) {
      return;
    }
    Store<StateInfo> store = CommonUtils.getStore(context);
    await HttpGo.getInstance()
        .get(UrlPath.orderInfoPath +
            store.state.loginResponseEntity.orderMasterEntity.orderId
                .toString() +
            "/info")
        .then((baseResult) {
      print("订单详情成功");

      ///1.轮数+1
      Store<StateInfo> store = CommonUtils.getStore(context);
      store.state.loginResponseEntity.setting.isTimeFinish = false;
      store.state.loginResponseEntity.orderMasterEntity =
          OrderMasterEntity.fromJson(baseResult.data["data"]);

      ///2.保存已点轮数和roundid
      if (store.state.loginResponseEntity.orderMasterEntity != null) {
        store.state.loginResponseEntity.orderMasterEntity.orderRounds
            .forEach((rounds) {
          store.state.loginResponseEntity.roundIdMap[rounds.num] = rounds.id;
        });
      }

      ///3.更新到store
      store.dispatch(RefreshLoginInfoAction(store.state.loginResponseEntity));

      ///4.开始倒计时
      _startCountdown();
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  ///去下单食品
  _toOrderFood() {
    if (CommonUtils.getStore(context)
            .state
            .loginResponseEntity
            .orderMasterEntity
            .orderRounds
            .length >
        10) {
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).orderFoodTooMuchTip);
    } else {
      NavigatorUtils.navigatorRouter(context, MenuFoodPage());
    }
  }

  ///通知付款
  _toNotifyPay() async {
    Store<StateInfo> store = CommonUtils.getStore(context);
    return await HttpGo.getInstance()
        .post(UrlPath.notifyPay +
            "?orderId=" +
            store.state.loginResponseEntity.orderMasterEntity.orderId
                .toString())
        .then((baseResult) {
      ///跳转到服务员设置界面
      Fluttertoast.showToast(msg: "通知付款成功");
      NavigatorUtils.pushReplacementNamed(context, RoutePath.LOGIN_PATH);
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  ///更新设置 type 1:退出确认 2：设置更新
  _updateOrderSetting(int type) {
    TextEditingController _passwordController = new TextEditingController();
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            CommonUtils.getLocale(context).password,
            style: TextStyle(fontSize: MyTextStyle.normalTextSize),
          ),
          content: new TextField(
            controller: _passwordController,
            autofocus: false,
            style: MyTextStyle.largeText,
            decoration: new InputDecoration(
              labelText: CommonUtils.getLocale(context).loginPswTip,
              suffixIcon: new IconButton(
                icon: new Icon(Icons.clear, color: Colors.black45),
                onPressed: () {
                  _passwordController.text = "";
                },
              ),
            ),
            obscureText: true,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                CommonUtils.getLocale(context).sure,
                style: TextStyle(
                    color: Colors.blue, fontSize: MyTextStyle.normalTextSize),
              ),
              onPressed: () {
                if (_passwordController.text !=
                    CommonUtils.getStore(context)
                        .state
                        .loginResponseEntity
                        .setting
                        .appPwd) {
                  Fluttertoast.showToast(
                      msg: CommonUtils.getLocale(context).passwordWrongTip);
                } else {
                  Navigator.of(context).pop();
                  if (1 == type) {
                    NavigatorUtils.pushReplacementNamed(
                        context, RoutePath.LOGIN_PATH);
                  } else {
                    NavigatorUtils.navigatorRouter(
                        context, ServiceControlPage(2));
                  }
                }
              },
            ),
          ],
        );
      },
    ).whenComplete(() {
      if (_passwordController != null) {
        _passwordController.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      return _updateOrderSetting(1);
    }, child: new StoreBuilder<StateInfo>(builder: (context, store) {
      return new Scaffold(
        appBar: AppBar(
          title: Text(CommonUtils.getLocale(context).customWorkbenchService),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              onTap: () {
                _updateOrderSetting(2);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20.0),
                child: Image.asset(
                  'static/images/icon_setting.png',
                  height: ScreenUtil.getInstance().setWidth(45),
                  width: ScreenUtil.getInstance().setWidth(45),
                ),
              ),
            )
          ],
        ),
        body: Container(
          alignment: Alignment.topLeft,
          height: window.physicalSize.height,
          decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Color(ColorsStyle.white)
          ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1))),
          child: Column(
            children: <Widget>[
              //top
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget>[
                    ///轮信息
                    Expanded(
                      flex: 4,
                      child: RoundInfo(),
                    ),

                    ///中间倒计时信息
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              CommonUtils.getLocale(context).waitingTip,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MyTextStyle.smallTextSize,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          ///倒计时文字
                          Expanded(
                            child: Center(
                                child: Text(
                              currentTimeSecond != 0
                                  ? timerString
                                  : CommonUtils.getLocale(context).countTimer,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: MyTextStyle.hugeBigTextSize,
                              ),
                            )),
                          ),

                          ///桌号
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'static/images/icon_table_num_logo.png',
                                fit: BoxFit.cover,
                              ),
                              Text(
                                store.state.loginResponseEntity.setting
                                        .buyerName +
                                    "-" +
                                    store.state.loginResponseEntity.setting
                                        .tableNum,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyTextStyle.bigTextSize,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ConstrainedBox(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                  style: BorderStyle.solid)),
                          child: Image.asset(
                            'static/images/icon_bg.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        constraints: BoxConstraints.expand(),
                      ),
                    ),
                  ],
                ),
              ),
              //bottom
              Expanded(
                flex: 4,
                child: Row(
                  children: <Widget>[
                    ///酒水
                    Expanded(
                      child: AvoidDoubleClickInkWell(
                        onTap: () {
                          NavigatorUtils.navigatorRouter(
                              context, MenuDrinkPage());
                        },
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5.0,
                            ),
                          ]),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Image.asset(
                                  'static/images/hm1_de.png',
                                  width: window.physicalSize.width / 4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  CommonUtils.getLocale(context).drink,
                                  style: MyTextStyle.largeTextWhiteBold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///餐单
                    Expanded(
                      child: AvoidDoubleClickInkWell(
                        onTap: () {
                          this._toOrderFood();
                        },
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5.0,
                            ),
                          ]),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Image.asset(
                                  'static/images/hm2_de.png',
                                  width: window.physicalSize.width / 4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  CommonUtils.getLocale(context).menu,
                                  style: MyTextStyle.largeTextWhiteBold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///服务
                    Expanded(
                      child: AvoidDoubleClickInkWell(
                        onTap: () {
                          NavigatorUtils.navigatorRouter(
                              context, MenuServicePage());
                        },
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5.0,
                            ),
                          ]),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Image.asset(
                                  'static/images/hm3_de.png',
                                  width: window.physicalSize.width / 4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  CommonUtils.getLocale(context).service,
                                  style: MyTextStyle.largeTextWhiteBold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///支付/买单
                    Expanded(
                      child: AvoidDoubleClickInkWell(
                        onTap: () {
                          ///提示
                          showDialog<Null>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                title: new Text(
                                  CommonUtils.getLocale(context).tip,
                                  style: TextStyle(
                                      fontSize: MyTextStyle.normalTextSize),
                                ),
                                content: new Text(
                                  CommonUtils.getLocale(context).payTip,
                                  style: TextStyle(
                                      fontSize: MyTextStyle.bigTextSize),
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text(
                                      CommonUtils.getLocale(context).cancel,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: MyTextStyle.normalTextSize),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text(
                                      CommonUtils.getLocale(context).sure,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: MyTextStyle.normalTextSize),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _toNotifyPay();
                                    },
                                  ),
                                ],
                              );
                            },
                          ).then((val) {
                            print(val);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5.0,
                            ),
                          ]),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Image.asset(
                                  'static/images/hm4_de.png',
                                  width: window.physicalSize.width / 4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  CommonUtils.getLocale(context).payment,
                                  style: MyTextStyle.largeTextWhiteBold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }

  @override
  void dispose() {
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
    if (streamUpdate != null) {
      streamUpdate.cancel();
      streamUpdate = null;
    }
    countdownTimer?.cancel();
    countdownTimer = null;
    super.dispose();
  }
}

///轮信息
class RoundInfo extends StatefulWidget {
  @override
  _RoundInfoState createState() => _RoundInfoState();
}

class _RoundInfoState extends State<RoundInfo> {
  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(1),
    const StaggeredTile.fit(2),
  ];

  @override
  Widget build(BuildContext context) {
    return new StaggeredGridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      staggeredTiles: _staggeredTiles,
      children: getWidgetList(context),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.all(4.0),
    );
  }

  List<String> getDataList(BuildContext context) {
    List<String> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(CommonUtils.getLocale(context).round + " " + (i + 1).toString());
    }
    //最后加上已点酒水
    list.add(CommonUtils.getLocale(context).drink);
    return list;
  }

  List<Widget> getWidgetList(BuildContext context) {
    List<Widget> widgets = new List();
    List<String> dataList = getDataList(context);
    for (int i = 0; i < dataList.length; i++) {
      widgets.add(getItemContainer(context, dataList[i], i));
    }
    return widgets;
  }

  Widget getItemContainer(BuildContext context, String item, int index) {
    Store<StateInfo> store = CommonUtils.getStore(context);
    return InkWell(
      onTap: () {
        NavigatorUtils.navigatorRouter(context, MenuFoodPage());
      },
      child: Container(
          alignment: Alignment.center,
          child: FlexButton(
            onPress: () {
              ///已点酒水
              if (index == 10) {
                NavigatorUtils.navigatorRouter(
                    context, DrinkRecord(Config.DETAIL_DRINK_TYPE));
              }

              ///已点轮菜单
              else if (store.state.loginResponseEntity.orderMasterEntity
                      .orderRounds.length >
                  index) {
                int roundId =
                    store.state.loginResponseEntity.roundIdMap[index + 1];
                if (roundId != null) {
                  NavigatorUtils.navigatorRouter(context,
                      DrinkRecord(Config.DETAIL_FOOD_TYPE, round: roundId));
                }
              }
            },
            color: store.state.loginResponseEntity.orderMasterEntity.orderRounds
                        .length >
                    index
                ? Colors.red
                : (index == 10 ? Colors.green : Colors.blueAccent),
            textColor: Colors.white,
            fontSize: MyTextStyle.normalTextSize,
            text: item,
          )),
    );
  }
}
