import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/config/route_path.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/event/timer_refresh_event.dart';
import 'package:order_app/common/model/login_response_entity.dart';
import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/login_info_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/control/language_setting.dart';
import 'package:order_app/widget/PlusDecreaseInput.dart';
import 'package:order_app/widget/flex_button.dart';
import 'package:order_app/widget/slide_bar.dart';
import 'package:redux/redux.dart';

///开台服务界面
class ServiceControlPage extends StatefulWidget {
  ///1：新增 2：修改
  int type;

  ServiceControlPage(this.type, {Key key}) : super(key: key);

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
  int _lunchItem = Config.LUNCH_ITEM;

  //晚餐设置
  int _dinnerItem = Config.DINNER_ITEM;

  //时间设置
  int _timerItem = Config.ROUND_TIME;

  //餐区
  int _buyerId = -1;

  //餐区名称
  String _buyerName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      if (mounted) {
        Store<StateInfo> store = CommonUtils.getStore(context);
        _lunchItem = store.state.loginResponseEntity.setting.lunchNum;
        _dinnerItem = store.state.loginResponseEntity.setting.dinnerNum;
        _timerItem = store.state.loginResponseEntity.setting.waitTime;

        ///修改进来时要初始化值
        if (widget.type == 2) {
          _adultController.text =
              store.state.loginResponseEntity.setting.adult.toString();
          _childrenController.text =
              store.state.loginResponseEntity.setting.children.toString();
          _tableNumController.text =
              store.state.loginResponseEntity.setting.tableNum.toString();
          this.setState(() {
            _buyerId = store.state.loginResponseEntity.setting.buyerId;
            _buyerName = store.state.loginResponseEntity.setting.buyerName;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      return Scaffold(
        resizeToAvoidBottomPadding: false, //输入框抵住键盘
        appBar: AppBar(
          title: Text(CommonUtils.getLocale(context).service),
          centerTitle: true,
        ),
        body: Container(
          child: Container(
            width: window.physicalSize.width,
            color: Colors.black,
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                ///餐区选择
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 3,
                            crossAxisSpacing: 5.0),
                        scrollDirection: Axis.vertical,
                        itemCount: store.state.loginResponseEntity.areas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              this.setState(() {
                                if (_buyerId ==
                                    store.state.loginResponseEntity.areas[index]
                                        .id) {
                                  _buyerId = -1;
                                  _buyerName = "";
                                } else {
                                  _buyerId = store.state.loginResponseEntity
                                      .areas[index].id;
                                  _buyerName = store.state.loginResponseEntity
                                      .areas[index].name;
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              color: _buyerId ==
                                      store.state.loginResponseEntity
                                          .areas[index].id
                                  ? Colors.lightBlue
                                  : Colors.white,
                              child: Text(
                                  store.state.loginResponseEntity.areas[index]
                                      .name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: _buyerId ==
                                            store.state.loginResponseEntity
                                                .areas[index].id
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: MyTextStyle.normalTextSize,
                                  )),
                            ),
                          );
                        }),
                  ),
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
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.0))),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: PlusDecreaseInput(
                                  textEditingController: _adultController,
                                  fontSize: MyTextStyle.bigTextSize,
                                  titleWidth:
                                      ScreenUtil.getInstance().setWidth(250),
                                  title: CommonUtils.getLocale(context).adult,
                                  titleFontSize: MyTextStyle.bigTextSize,
                                )),
                                Expanded(
                                    child: PlusDecreaseInput(
                                  textEditingController: _childrenController,
                                  fontSize: MyTextStyle.bigTextSize,
                                  titleWidth:
                                      ScreenUtil.getInstance().setWidth(250),
                                  title:
                                      CommonUtils.getLocale(context).children,
                                  titleFontSize: MyTextStyle.bigTextSize,
                                )),
                                Expanded(
                                    child: PlusDecreaseInput(
                                  textEditingController: _tableNumController,
                                  fontSize: MyTextStyle.bigTextSize,
                                  titleWidth:
                                      ScreenUtil.getInstance().setWidth(250),
                                  title:
                                      CommonUtils.getLocale(context).tableNum,
                                  titleFontSize: MyTextStyle.bigTextSize,
                                )),
                                Expanded(
                                    child: PlusDecreaseInput(
                                  textEditingController: _passwordController,
                                  fontSize: MyTextStyle.bigTextSize,
                                  titleWidth:
                                      ScreenUtil.getInstance().setWidth(250),
                                  decreaseVisible: false,
                                  plusVisible: false,
                                  title:
                                      CommonUtils.getLocale(context).password,
                                  titleFontSize: MyTextStyle.bigTextSize,
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
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.0))),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: SlideBar(
                                  title:
                                      CommonUtils.getLocale(context).lunchItem,
                                  titleFontSize: MyTextStyle.bigTextSize,
                                  titleColor: Colors.black,
                                  onChanged: (value) {
                                    _lunchItem = value.toInt();
                                  },
                                  min: 0.0,
                                  max: 50.0,
                                  value: _lunchItem.toDouble(),
                                  divisions: 50,
                                ),
                              ),
                              Expanded(
                                child: SlideBar(
                                  title:
                                      CommonUtils.getLocale(context).dinnerItem,
                                  titleFontSize: MyTextStyle.bigTextSize,
                                  titleColor: Colors.black,
                                  onChanged: (value) {
                                    _dinnerItem = value.toInt();
                                  },
                                  min: 0.0,
                                  max: 50.0,
                                  value: _dinnerItem.toDouble(),
                                  divisions: 50,
                                ),
                              ),
                              Expanded(
                                child: SlideBar(
                                  title: CommonUtils.getLocale(context).timer,
                                  titleFontSize: MyTextStyle.bigTextSize,
                                  titleColor: Colors.black,
                                  onChanged: (value) {
                                    _timerItem = value.toInt();
                                  },
                                  min: 0.0,
                                  max: 30.0,
                                  value: _timerItem.toDouble(),
                                  divisions: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //操作信息
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height:
                                        ScreenUtil.getInstance().setWidth(80),
                                    child: FlexButton(
                                      color: Colors.redAccent,
                                      textColor: Colors.white,
                                      text:
                                          CommonUtils.getLocale(context).lunch,
                                      fontSize: MyTextStyle.normalTextSize,
                                      onPress: () {
                                        _startToMenu(
                                            context,
                                            store,
                                            RoutePath.CUSTOM_MENU_PATH,
                                            true,
                                            false);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil.getInstance().setWidth(30),
                                ),
                                Expanded(
                                  child: Container(
                                    height:
                                        ScreenUtil.getInstance().setWidth(80),
                                    child: FlexButton(
                                      color: Colors.lightBlue,
                                      textColor: Colors.white,
                                      text:
                                          CommonUtils.getLocale(context).dinner,
                                      fontSize: MyTextStyle.normalTextSize,
                                      onPress: () {
                                        _startToMenu(
                                            context,
                                            store,
                                            RoutePath.CUSTOM_MENU_PATH,
                                            false,
                                            true);
                                      },
                                    ),
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
    });
  }

  ///开始点餐
  _startToMenu(BuildContext context, Store<StateInfo> store, String path,
      bool isLunch, bool isDinner) {
    if (_buyerId == -1) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).buyerEmptyTip);
      return;
    }
    if (_adultController.text.length <= 0 || _adultController.text == '0') {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).adultEmptyTip);
      return;
    }
    if (_tableNumController.text.length <= 0) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).tableEmptyTip);
      return;
    }
    if (_passwordController.text.length <= 0) {
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).passwordEmptyTip);
      return;
    }

    ///1.保存本次服务设置
    LoginResponseEntity loginInfoEntity = store.state.loginResponseEntity;
    LoginInfoSetting loginInfoSetting = loginInfoEntity.setting;
    if (_passwordController.text != loginInfoSetting.appPwd) {
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).passwordWrongTip);
      return;
    }
    loginInfoSetting.adult = int.parse(_adultController.text);
    if (_childrenController.text.length > 0) {
      loginInfoSetting.children = int.parse(_childrenController.text);
    }
    loginInfoSetting.tableNum = _tableNumController.text;
    loginInfoSetting.password = _passwordController.text;
    loginInfoSetting.lunchNum = _lunchItem;
    loginInfoSetting.dinnerNum = _dinnerItem;
    loginInfoSetting.waitTime = _timerItem;
    loginInfoSetting.isLunch = isLunch;
    loginInfoSetting.isDiner = isDinner;
    loginInfoSetting.buyerId = _buyerId;
    loginInfoSetting.buyerName = _buyerName;
    loginInfoEntity.setting = loginInfoSetting;

    OrderMasterEntity orderMasterEntity;
    ///2.下单
    if (1 == widget.type) {
      loginInfoSetting.isTimeFinish = true;
      orderMasterEntity = new OrderMasterEntity(orderRounds: new List());
    } else {
      orderMasterEntity = loginInfoEntity.orderMasterEntity;
    }
    orderMasterEntity.orderType = isLunch ? "1" : "2";
    orderMasterEntity.dinnerNum = loginInfoSetting.dinnerNum;
    orderMasterEntity.lunchNum = loginInfoSetting.lunchNum;
    orderMasterEntity.buyerId = loginInfoSetting.buyerId;
    orderMasterEntity.tableNum = loginInfoSetting.tableNum;
    orderMasterEntity.adult = loginInfoSetting.adult;
    orderMasterEntity.child = loginInfoSetting.children;
    orderMasterEntity.waitTime = loginInfoSetting.waitTime;

    ///新增订单
    if (1 == widget.type) {
      HttpGo.getInstance()
          .post(UrlPath.orderConfirmPath, params: orderMasterEntity.toJson())
          .then((baseResult) {
        ///1.保存本次订单主表信息
        OrderMasterEntity orderMasterEntity =
            OrderMasterEntity.fromJson(baseResult.data['data']);
        loginInfoEntity.orderMasterEntity = orderMasterEntity;

        ///2.更新到store
        store.dispatch(RefreshLoginInfoAction(loginInfoEntity));

        ///3.打开客户工作台
        NavigatorUtils.pushReplacementNamed(context, path);
      }).catchError((error) {
        if(error is int &&error==101){
          Fluttertoast.showToast(msg: CommonUtils.getLocale(context).tableUsingTip);
        }else {
          Fluttertoast.showToast(msg: error.toString());
        }
      });
    }

    ///修改订单
    else if (2 == widget.type) {
      HttpGo.getInstance()
          .post(UrlPath.orderUpdate, params: orderMasterEntity.toJson())
          .then((baseResult) {
        print(loginInfoEntity.setting.toJson());

        ///1.更新到store
        store.dispatch(RefreshLoginInfoAction(loginInfoEntity));

        ///2.如正在倒计时，重新按最新时间开始倒计时
        CommonUtils.eventBus.fire(TimerFreshEvent());

        ///3.退出
        Navigator.pop(context);
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).updateSuccess);
      }).catchError((error) {if(error is int &&error==101){
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).tableUsingTip);
      }else {
        Fluttertoast.showToast(msg: error.toString());
      }
      });
    }
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
