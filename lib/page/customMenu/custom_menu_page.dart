import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/event/timer_event.dart';
import 'package:order_app/common/model/ServiceSetting.dart';
import 'package:order_app/common/redux/service_control_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/customMenu/timer_painter.dart';
import 'package:order_app/page/menu_drink_page.dart';
import 'package:order_app/page/menu_record.dart';
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

  ///倒计时
  AnimationController animationController;

  ///时间字符串
  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    ///监听触发计时器
    stream = CommonUtils.eventBus.on<TimerEvent>().listen((event) {
      if (animationController != null) {
        Store<StateInfo> store = CommonUtils.getStore(context);
        ServiceSetting serviceSetting = store.state.serviceSetting;
        serviceSetting.currentRound += 1;
        print(serviceSetting.currentRound);
        store.dispatch(RefreshServiceControlAction(serviceSetting));
        //开始动画
        animationController.reverse(from: 1.0);
      }
    });
  }

  @override
  void didChangeDependencies() {
    if (context == null) {
      return;
    }
    if (animationController == null) {
      Store<StateInfo> store = CommonUtils.getStore(context);
      animationController = AnimationController(
          vsync: this,
          duration:
              Duration(minutes: store.state.serviceSetting.timer.toInt()));
    }
    super.didChangeDependencies();
  }

  ///去下单食品
  _toOrderFood() {
    if (animationController.value != 0) {
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).reOrderFoodTip);
    } else if (CommonUtils.getStore(context).state.serviceSetting.currentRound >
        10) {
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).orderFoodTooMuchTip);
    } else {
      NavigatorUtils.navigatorRouter(context, MenuFoodPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      return new Scaffold(
        appBar: AppBar(
          title: Text(CommonUtils.getLocale(context).customWorkbenchService),
          centerTitle: true,
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
                      child: RoundInfo(
                          currentRound:
                              store.state.serviceSetting.currentRound),
                    ),

                    ///中间倒计时信息
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Warten auf die nächste runde',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Stack(
                                    children: <Widget>[
                                      ///倒计时进度条
                                      Positioned.fill(
                                        child: AnimatedBuilder(
                                          animation: animationController,
                                          builder: (BuildContext context,
                                              Widget child) {
                                            return CustomPaint(
                                              painter: TimerPainter(
                                                  animation:
                                                      animationController,
                                                  backgroundColor: Colors.white,
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            );
                                          },
                                        ),
                                      ),

                                      ///倒计时文字
                                      Align(
                                        alignment: Alignment.center,
                                        child: AnimatedBuilder(
                                            animation: animationController,
                                            builder: (_, Widget child) {
                                              return animationController
                                                          .value !=
                                                      0
                                                  ? Text(
                                                      timerString,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 42.0,
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        this._toOrderFood();
                                                      },
                                                      child: Text(
                                                        CommonUtils.getLocale(
                                                                context)
                                                            .order,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    );
                                            }),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'static/images/icon_table_num_logo.png',
                                fit: BoxFit.cover,
                              ),
                              Text(
                                store.state.serviceSetting.tableNum,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
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
                      child: InkWell(
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
                      child: InkWell(
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

                    ///支付/买单
                    Expanded(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController.dispose();
    }
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
    super.dispose();
  }
}

///轮信息
class RoundInfo extends StatefulWidget {
  final int currentRound;

  RoundInfo({Key key, this.currentRound}) : super(key: key);

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
    list.add(CommonUtils.getLocale(context).order);
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
    return InkWell(
      onTap: () {
        NavigatorUtils.navigatorRouter(context, MenuFoodPage());
      },
      child: Container(
          alignment: Alignment.center,
          child: FlexButton(
            onPress: () {
              ///已点菜单
              if (index == 10) {
                NavigatorUtils.navigatorRouter(context, MenuRecord());
              }
            },
            color: widget.currentRound > index + 1
                ? Colors.red
                : (index == 10 ? Colors.green : Colors.blueAccent),
            textColor: Colors.white,
            text: item,
          )),
    );
  }
}
