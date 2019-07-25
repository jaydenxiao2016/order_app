import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/event/type_refresh_event.dart';
import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/page/console/record.dart';
import 'package:order_app/widget/flex_button.dart';

//控制台详情
class ConsoleDetailPage extends StatefulWidget {
  /// 订单id
  int orderId;

  ConsoleDetailPage(this.orderId, {Key key}) : super(key: key);

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
        .get(UrlPath.orderInfoPath + widget.orderId.toString() + "/info")
        .then((baseResult) {
      print("订单详情成功");
      setState(() {
        orderMasterEntity = OrderMasterEntity.fromJson(baseResult.data["data"]);
      });
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  ///确认结账
  _requestSettlement() async {
    if (mounted) {
      ///提示
      showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(450),
                  height: ScreenUtil.getInstance().setWidth(90),
                  margin: EdgeInsets.all(10.0),
                  child: FlexButton(
                    color: Colors.grey,
                    textColor: Colors.white,
                    fontSize: MyTextStyle.bigTextSize,
                    text: CommonUtils.getLocale(context).cancelOrder,
                    onPress: () {
                      Navigator.of(context).pop();
                      HttpGo.getInstance()
                          .post(
                              UrlPath.cancelPath +
                                  "?orderId=" +
                                  widget.orderId.toString(),
                              cancelToken: cancelToken)
                          .then((baseResult) {
                        Fluttertoast.showToast(
                            msg: CommonUtils.getLocale(context)
                                .cancelOrderSuccess);

                        ///刷新工作面板
                      }).catchError((error) {
                        Fluttertoast.showToast(msg: error.toString());
                      });
                    },
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(450),
                  height: ScreenUtil.getInstance().setWidth(90),
                  margin: EdgeInsets.all(105.0),
                  child: FlexButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    fontSize: MyTextStyle.bigTextSize,
                    text: CommonUtils.getLocale(context).payedOrder,
                    onPress: () {
                      Navigator.of(context).pop();
                      HttpGo.getInstance()
                          .post(
                              UrlPath.settlementPath +
                                  "?orderId=" +
                                  widget.orderId.toString(),
                              cancelToken: cancelToken)
                          .then((baseResult) {
                        Fluttertoast.showToast(
                            msg: CommonUtils.getLocale(context)
                                .payedOrderSuccess);

                        ///刷新工作面板
                      }).catchError((error) {
                        Fluttertoast.showToast(msg: error.toString());
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      String title = CommonUtils.getLocale(context).controlTitle;
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
                                      CommonUtils.eventBus.fire(new TypeRefreshEvent(type,widget.orderId,roundId));
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
                                        border: Border.all(
                                            color: Colors.grey, width: 2)),
                                    height:
                                        ScreenUtil.getInstance().setWidth(80),
                                    child: Text(CommonUtils.getLocale(context)
                                            .round +
                                        " " +
                                        orderMasterEntity.orderRounds[index].num
                                            .toString()),
                                  ),
                                );
                              }),
                        ),
                      ),

                      ///右边总金额和订单明细
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            ///总金额和台号信息
                            Row(
                              children: <Widget>[
                                Text('酒水总价：1000'),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: ScreenUtil.getInstance()
                                          .setWidth(100),
                                      alignment: Alignment.center,
                                      child: Text("101")),
                                ),
                                Text("共消费：1230"),
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
                            color: Colors.grey,
                            textColor: Colors.white,
                            fontSize: MyTextStyle.normalTextSize,
                            text: "总订单",
                            onPress: () {
                              this.setState(() {
                                type = "1";
                                roundId=null;
                                CommonUtils.eventBus.fire(new TypeRefreshEvent(type,widget.orderId,roundId));
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
                            text: "酒水订单",
                            onPress: () {
                              this.setState(() {
                                type = "1";
                                roundId=null;
                                CommonUtils.eventBus.fire(new TypeRefreshEvent(type,widget.orderId,roundId));
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
                            text: "确认已付款",
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
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            fontSize: MyTextStyle.normalTextSize,
                            text: "取消订单",
                            onPress: () {
                              _requestSettlement();
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
    super.dispose();
  }
}
