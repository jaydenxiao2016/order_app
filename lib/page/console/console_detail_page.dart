import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/event/console_refresh_event.dart';
import 'package:order_app/common/event/type_refresh_event.dart';
import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/date_format_base.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/console/record.dart';
import 'package:order_app/widget/flex_button.dart';
import 'package:order_app/common/utils/common_utils.dart';

//控制台详情
class ConsoleDetailPage extends StatefulWidget {
  /// 订单id
  int orderId;
  /// 台区
  String buyerName;

  ConsoleDetailPage(this.orderId, this.buyerName,{Key key}) : super(key: key);

  @override
  _ConsoleDetailPageState createState() => _ConsoleDetailPageState();
}

class _ConsoleDetailPageState extends State<ConsoleDetailPage> {
  CancelToken cancelToken = new CancelToken();

  ///订单详情
  OrderMasterEntity orderMasterEntity =
      new OrderMasterEntity(orderRounds: List());

  ///明细类型1：酒水 2：每轮订单 3:服务
  String type = "1";

  ///轮数ID
  int roundId;
  ///密码监听器
  TextEditingController _passwordController;

  @override
  void initState() {
    print("ordreId");
    print(widget.orderId.toString());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _getOrderDetail();
    });
  }

  ///获取主订单详情
  _getOrderDetail() async {
    print("获取订单详情");
    if (context == null) {
      return;
    }
    CommonUtils.showLoadingDialog(context, HttpGo.getInstance()
        .get(UrlPath.orderInfoPath + widget.orderId.toString() + "/info")
        .then((baseResult) {
      print("订单详情成功");
      setState(() {
        orderMasterEntity = OrderMasterEntity.fromJson(baseResult.data["data"]);
      });
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    }));
  }

  ///确认结账
  _requestSettlement() async {
    if (mounted) {
      BuildContext rootContext = context;
      showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
              CommonUtils.getLocale(context).tip,
              style: TextStyle(fontSize: MyTextStyle.normalTextSize),
            ),
            content: new Text(
              CommonUtils.getLocale(context).payedOrderSuccess,
              style: TextStyle(fontSize: MyTextStyle.bigTextSize),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  CommonUtils.getLocale(context).cancel,
                  style: TextStyle(
                      color: Colors.grey, fontSize: MyTextStyle.normalTextSize),
                ),
                onPressed: () {
                  NavigatorUtils.pop(context);
                },
              ),
              new FlatButton(
                child: new Text(
                  CommonUtils.getLocale(context).sure,
                  style: TextStyle(
                      color: Colors.blue, fontSize: MyTextStyle.normalTextSize),
                ),
                onPressed: () {
                  HttpGo.getInstance()
                      .post(
                          UrlPath.settlementPath +
                              "?orderId=" +
                              widget.orderId.toString(),
                          cancelToken: cancelToken)
                      .then((baseResult) {
                    Fluttertoast.showToast(
                        msg: CommonUtils.getLocale(rootContext)
                            .payedOrderSuccess);
                   CommonUtils.eventBus.fire(ConsoleRefreshEvent());
                    ///刷新工作面板
                    Navigator.pop(context);
                    Navigator.pop(rootContext);
                  }).catchError((error) {
                    Navigator.pop(context);
                      Fluttertoast.showToast(msg: error.toString());
                  });
                },
              ),
            ],
          );
        },
      ).then((val) {});
    }
  }

  ///取消订单
  _cancelOrder() {
    if (_passwordController != null) {
      _passwordController.dispose();
    }
     _passwordController = new TextEditingController();
    BuildContext rootContext = context;
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
                        .ctlAppPwd) {
                  Fluttertoast.showToast(
                      msg: CommonUtils.getLocale(context).passwordWrongTip);
                } else {
                 HttpGo.getInstance()
                      .post(
                          UrlPath.cancelPath +
                              "?orderId=" +
                              widget.orderId.toString()+"&pwd="+CommonUtils.getStore(context).state.loginResponseEntity.setting.cancelPwd,
                          cancelToken: cancelToken)
                      .then((baseResult) {
                    Fluttertoast.showToast(
                        msg: CommonUtils.getLocale(context).cancelOrderSuccess);
                    CommonUtils.eventBus.fire(ConsoleRefreshEvent());
                    ///刷新工作面板
                    Navigator.pop(context);
                    Navigator.pop(rootContext);
                  }).catchError((error) {
                    if(error==106){
                      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).passwordWrongTip);
                      Navigator.pop(context);
                      Navigator.of(rootContext).maybePop(true);
                    }else {
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: error.toString());
                    }
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ///开台时间
    String openTimeStr = orderMasterEntity.openTime != null
        ? formatDate(
            DateTime.fromMillisecondsSinceEpoch(orderMasterEntity.openTime),
            [dd, '-', mm, '-', yyyy, ' ', HH, ':', nn]).toString()
        : "";
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      String title = CommonUtils.getLocale(context).controlTitle;
      double adultPrice=orderMasterEntity.orderType=="1"?store.state.loginResponseEntity.setting.adultLunchPrice:store.state.loginResponseEntity.setting.adultDinnerPrice;
      double childPrice=orderMasterEntity.orderType=="1"?store.state.loginResponseEntity.setting.childLunchPrice:store.state.loginResponseEntity.setting.childDinnerPrice;
      double adultTotalPrice=adultPrice*(orderMasterEntity.adult??0);
      double childTotalPrice=childPrice*(orderMasterEntity.child??0);
      AppBar appBar = AppBar(
        title: Text(title),
      );
      print(appBar.preferredSize.height);
      return Scaffold(
        appBar: appBar,
        body: Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                ///上部分
                Expanded(
                  child: Row(
                    children: <Widget>[
                      ///左边轮数
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: orderMasterEntity.orderRounds.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      type = "2";
                                      roundId = orderMasterEntity
                                          .orderRounds[index].id;
                                      CommonUtils.eventBus.fire(
                                          new TypeRefreshEvent(
                                              type, widget.orderId, roundId));
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: orderMasterEntity
                                                    .orderRounds[index].id ==
                                                roundId
                                            ? Colors.lightBlue
                                            : Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)),
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: ScreenUtil.getInstance()
                                                .setWidth(2))),
                                    height:
                                        ScreenUtil.getInstance().setWidth(70),
                                    child: Text(CommonUtils.getLocale(context)
                                            .round +
                                        " " +
                                        orderMasterEntity.orderRounds[index].num
                                            .toString(),style: TextStyle(
                                      fontSize: MyTextStyle.normalTextSize,
                                        color:orderMasterEntity
                                            .orderRounds[index].id ==
                                            roundId?Colors.white:Colors.black
                                    ),),
                                  ),
                                );
                              }),
                        ),
                      ),

                      ///右边总金额和订单明细
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: <Widget>[
                            ///总金额和台号信息
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        CommonUtils.getLocale(context).drinkPrice,
                                        style: TextStyle(
                                            fontSize:
                                                MyTextStyle.normalTextSize),
                                      ),
                                      Text(
                                          orderMasterEntity.drinksTotalAmount!=null?orderMasterEntity.drinksTotalAmount.toString():"0",
                                          style: TextStyle(
                                              fontSize: MyTextStyle.bigTextSize,
                                              color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        CommonUtils.getLocale(context).adult.toString()+"("+orderMasterEntity.adult.toString()+")",
                                        style: TextStyle(
                                            fontSize:
                                            MyTextStyle.normalTextSize),
                                      ),
                                      Text(
                                          adultTotalPrice.toString(),
                                          style: TextStyle(
                                              fontSize: MyTextStyle.bigTextSize,
                                              color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        CommonUtils.getLocale(context).children.toString()+"("+(orderMasterEntity.child.toString()??"0")+")",
                                        style: TextStyle(
                                            fontSize:
                                            MyTextStyle.normalTextSize),
                                      ),
                                      Text(
                                          childTotalPrice.toString(),
                                          style: TextStyle(
                                              fontSize: MyTextStyle.bigTextSize,
                                              color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        CommonUtils.getLocale(context).tableNum,
                                        style: TextStyle(
                                            fontSize: MyTextStyle.bigTextSize),
                                      ),
                                      Text(
                                        widget.buyerName+"-"+orderMasterEntity.tableNum.toString() +
                                            "（" +
                                            openTimeStr +
                                            "）",
                                        style: TextStyle(
                                            fontSize: MyTextStyle.bigTextSize),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        CommonUtils.getLocale(context).totalPrice,
                                        style: TextStyle(
                                            fontSize:
                                                MyTextStyle.normalTextSize),
                                      ),
                                      Text(
                                          orderMasterEntity.totalAmount
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: MyTextStyle.bigTextSize,
                                              color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            ///订单详情
                            Expanded(
                              child: Record(
                                type,
                                widget.orderId,
                                round: roundId,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// 下部分操作按钮
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: ScreenUtil.getInstance().setWidth(70),
                          margin: EdgeInsets.all(5.0),
                          child: FlexButton(
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            fontSize: MyTextStyle.normalTextSize,
                            text: CommonUtils.getLocale(context).allOrderDetail,
                            onPress: () {
                              this.setState(() {
                                type = "1,2";
                                roundId = null;
                                CommonUtils.eventBus.fire(new TypeRefreshEvent(
                                    type, widget.orderId, roundId));
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: ScreenUtil.getInstance().setWidth(70),
                          margin: EdgeInsets.all(5.0),
                          child: FlexButton(
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            fontSize: MyTextStyle.normalTextSize,
                            text: CommonUtils.getLocale(context).drinkDetail,
                            onPress: () {
                              this.setState(() {
                                type = "1";
                                roundId = null;
                                CommonUtils.eventBus.fire(new TypeRefreshEvent(
                                    type, widget.orderId, roundId));
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: ScreenUtil.getInstance().setWidth(70),
                          margin: EdgeInsets.all(5.0),
                          child: FlexButton(
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            fontSize: MyTextStyle.normalTextSize,
                            text: CommonUtils.getLocale(context).payedOrder,
                            onPress: () {
                              _requestSettlement();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: ScreenUtil.getInstance().setWidth(70),
                          margin: EdgeInsets.all(5.0),
                          child: FlexButton(
                            color: Colors.grey,
                            textColor: Colors.white,
                            fontSize: MyTextStyle.normalTextSize,
                            text: CommonUtils.getLocale(context).cancelOrder,
                            onPress: () {
                              _cancelOrder();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      );
    });
  }

  @override
  void dispose() {
    //取消网络请求
    cancelToken.cancel("cancelled");
    if (_passwordController != null) {
      _passwordController.dispose();
    }
    super.dispose();
  }
}
