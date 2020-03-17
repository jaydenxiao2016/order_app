import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/date_format_base.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/console/record.dart';
import 'package:order_app/widget/flex_button.dart';

//支付详情
class PageDetailPage extends StatefulWidget {
  /// 订单id
  int orderId;

  /// 台区
  String buyerName;

  PageDetailPage(this.orderId, this.buyerName, {Key key}) : super(key: key);

  @override
  _PageDetailPageState createState() => _PageDetailPageState();
}

class _PageDetailPageState extends State<PageDetailPage> {
  CancelToken cancelToken = new CancelToken();

  ///订单详情
  OrderMasterEntity orderMasterEntity =
      new OrderMasterEntity(orderRounds: List());

  ///明细类型1：酒水 2：每轮订单 3:服务
  String type = "1";

  ///轮数ID
  int roundId;

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
    await HttpGo.getInstance()
        .get(UrlPath.orderInfoPath + widget.orderId.toString() + "/info",
            cancelToken: cancelToken)
        .then((baseResult) {
      print("订单详情成功");
      print(OrderMasterEntity.fromJson(baseResult.data["data"]).toJson());
      if (mounted) {
        setState(() {
          orderMasterEntity =
              OrderMasterEntity.fromJson(baseResult.data["data"]);
        });
      }
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  ///确认支付订单
  _payNotify() {
    BuildContext rootContext = context;

    ///提示
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
            CommonUtils.getLocale(context).payTip,
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
                CommonUtils.showLoadingDialog(
                    context,
                    HttpGo.getInstance()
                        .post(
                            UrlPath.notifyPay +
                                "?orderId=" +
                                widget.orderId.toString(),
                            cancelToken: cancelToken)
                        .then((baseResult) {
                      ///跳转到服务员设置界面
                      Fluttertoast.showToast(
                          msg: CommonUtils.getLocale(context).payTipSuccess);
                      Navigator.of(context).maybePop();
                      Navigator.of(rootContext).maybePop(true);
                    }).catchError((error) {
                      if (error == 102) {
                        Fluttertoast.showToast(
                            msg: CommonUtils.getLocale(context).payTipSuccess);
                        Navigator.of(context).maybePop();
                        Navigator.of(rootContext).maybePop(true);
                      } else {
                        Navigator.of(context).maybePop();
                        Fluttertoast.showToast(msg: error.toString());
                      }
                    }));
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    ///开台时间
//    String openTimeStr = orderMasterEntity.openTime != null
//        ? formatDate(
//            DateTime.fromMillisecondsSinceEpoch(orderMasterEntity.openTime),
//            [dd, '-', mm, '-', yyyy, ' ', HH, ':', nn]).toString()
//        : "";
    String openTimeStr=orderMasterEntity.openTime??"";
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      String title = CommonUtils.getLocale(context).payment;
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
                      ///总金额和订单明细
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
                                        CommonUtils.getLocale(context)
                                            .drinkPrice,
                                        style: TextStyle(
                                            fontSize:
                                                MyTextStyle.normalTextSize),
                                      ),
                                      Text(
                                          orderMasterEntity.drinksTotalAmount !=
                                                  null
                                              ? orderMasterEntity
                                                  .drinksTotalAmount
                                                  .toString()
                                              : "0",
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
                                        CommonUtils.getLocale(context)
                                                .adult
                                                .toString() +
                                            "(" +
                                            orderMasterEntity.adult.toString() +
                                            ")",
                                        style: TextStyle(
                                            fontSize:
                                                MyTextStyle.normalTextSize),
                                      ),
                                      Text(orderMasterEntity.adultAmount??"",
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
                                        CommonUtils.getLocale(context)
                                                .children
                                                .toString() +
                                            "(" +
                                            (orderMasterEntity.child
                                                    .toString() ??
                                                "0") +
                                            ")",
                                        style: TextStyle(
                                            fontSize:
                                                MyTextStyle.normalTextSize),
                                      ),
                                      Text(orderMasterEntity.childAmount??"",
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
                                        widget.buyerName +
                                            "-" +
                                            orderMasterEntity.tableNum
                                                .toString() +
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
                                        CommonUtils.getLocale(context)
                                            .totalPrice,
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
                      Container(
                        height: ScreenUtil.getInstance().setWidth(70),
                        width: ScreenUtil.getInstance().setWidth(500),
                        margin: EdgeInsets.all(5.0),
                        child: FlexButton(
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          fontSize: MyTextStyle.normalTextSize,
                          text: CommonUtils.getLocale(context).payment,
                          onPress: () {
                            _payNotify();
                          },
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
    super.dispose();
  }
}
