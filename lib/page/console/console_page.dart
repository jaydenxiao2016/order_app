import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/model/area_entity.dart';
import 'package:order_app/common/model/category.dart';
import 'package:order_app/common/model/category_response_entity.dart';
import 'package:order_app/common/model/order_detail.dart';
import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/model/product.dart';
import 'package:order_app/common/model/product_response_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/console/console_detail_page.dart';
import 'package:order_app/page/menu_record.dart';
import 'package:order_app/widget/PlusDecreaseText.dart';
import 'package:order_app/widget/flex_button.dart';

//控制台
class ConsolePage extends StatefulWidget {
  @override
  _ConsolePageState createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  CancelToken cancelToken = new CancelToken();
  List<AreaEntity> areaList = new List();

  ///0:未付款 1：结账中 2：已付款 3:其他
  Color notPayColor = Color(0xFFF2F2F2);
  Color payingColor = Colors.redAccent;
  Color payedColor = Colors.green;
  Color otherColor = Colors.amber;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _requestAreaData();
    });
  }

  ///请求餐区信息
  _requestAreaData() async {
    print('请求餐区信息');
    if (mounted) {
      await HttpGo.getInstance()
          .get(UrlPath.consolePath, cancelToken: cancelToken)
          .then((baseResult) {
        if (baseResult.data['data'] != null) {
          List<AreaEntity> newAreaList = new List<AreaEntity>();
          (baseResult.data['data'] as List).forEach((v) {
            newAreaList.add(new AreaEntity.fromJson(v));
          });
          this.setState(() {
            areaList = newAreaList;
          });
        }
      }).catchError((error) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }
  }

  ///确认结账
  _requestSettlement(int orderId) async {
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
                                  orderId.toString(),
                              cancelToken: cancelToken)
                          .then((baseResult) {
                        Fluttertoast.showToast(
                            msg: CommonUtils.getLocale(context)
                                .cancelOrderSuccess);
                        _requestAreaData();
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
                                  orderId.toString(),
                              cancelToken: cancelToken)
                          .then((baseResult) {
                        Fluttertoast.showToast(
                            msg: CommonUtils.getLocale(context)
                                .payedOrderSuccess);
                        _requestAreaData();
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
        actions: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: ScreenUtil.getInstance().setWidth(30),
                width: ScreenUtil.getInstance().setWidth(50),
                margin: EdgeInsets.all(5.0),
                color: notPayColor,
              ),
              Text("未结账")
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                height: ScreenUtil.getInstance().setWidth(30),
                width: ScreenUtil.getInstance().setWidth(50),
                margin: EdgeInsets.all(5.0),
                color: payingColor,
              ),
              Text("结账中"),
              SizedBox(
                width: ScreenUtil.getInstance().setWidth(10),
              )
            ],
          ),
//          Row(
//            children: <Widget>[
//              Container(
//                height: 20,
//                width: 40,
//                margin: EdgeInsets.all(5.0),
//                color: payedColor,
//              ),
//              Text("已结账"),
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Container(
//                height: 20,
//                width: 40,
//                margin: EdgeInsets.all(5.0),
//                color: otherColor,
//              ),
//              Text("其他"),
//              SizedBox(
//                width: 10,
//              )
//            ],
//          )
        ],
      );
      print(appBar.preferredSize.height);
      return Scaffold(
        appBar: appBar,
        body: Container(
          alignment: Alignment.topLeft,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: areaList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: ScreenUtil.getInstance().setWidth(100),
                          alignment: Alignment.center,
                          width: ScreenUtil.getInstance().setWidth(360),
                          decoration: BoxDecoration(
                              color: index.isEven
                                  ? Color(0xFFE0E0E0)
                                  : Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey,
                                      width: ScreenUtil.getInstance()
                                          .setWidth(3)))),
                          child: new Text(
                            areaList[index].name,
                            style:
                                TextStyle(fontSize: MyTextStyle.lagerTextSize),
                          )),
                      Expanded(
                        child: Container(
                          color:
                              index.isEven ? Color(0xFFE0E0E0) : Colors.white,
                          padding: EdgeInsets.all(
                              ScreenUtil.getInstance().setWidth(20)),
                          width: ScreenUtil.getInstance().setWidth(360),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing:
                                          ScreenUtil.getInstance().setWidth(20),
                                      childAspectRatio: 4,
                                      crossAxisSpacing: ScreenUtil.getInstance()
                                          .setWidth(20)),
                              scrollDirection: Axis.vertical,
                              itemCount: areaList[index].orders.length,
                              itemBuilder: (BuildContext context, int index2) {
//                                订单状态 0未结账 1结账中 2已结账 3已取消
                                String status =
                                    areaList[index].orders[index2].status;
                                Color bgColor = otherColor;
                                switch (status) {
                                  case "0":
                                    bgColor = notPayColor;
                                    break;
                                  case "1":
                                    bgColor = payingColor;
                                    break;
                                  case "2":
                                    bgColor = payedColor;
                                    break;
                                  default:
                                    bgColor = otherColor;
                                    break;
                                }
                                return Container(
                                    height:
                                        ScreenUtil.getInstance().setWidth(100),
                                    width:
                                        ScreenUtil.getInstance().setWidth(100),
                                    alignment: Alignment.center,
                                    child: FlexButton(
                                        text: areaList[index]
                                                .orders[index2]
                                                .tableNum +
                                            "（" +
                                            areaList[index]
                                                .orders[index2]
                                                .adult
                                                .toString() +
                                            "." +
                                            (areaList[index]
                                                        .orders[index2]
                                                        .child !=
                                                    null
                                                ? areaList[index]
                                                    .orders[index2]
                                                    .child.toString()
                                                : "0") +
                                            "）",
                                        color: bgColor,
                                        fontSize: MyTextStyle.bigTextSize,
                                        onPress: () {
                                          NavigatorUtils.navigatorRouter(context, ConsoleDetailPage(areaList[index]
                                              .orders[index2]
                                              .orderId));
                                        }));
                              }),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
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
