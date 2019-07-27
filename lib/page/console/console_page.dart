import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/event/console_refresh_event.dart';
import 'package:order_app/common/model/area_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/console/console_detail_page.dart';
import 'package:order_app/widget/AvoidDoubleClickInkWell.dart';
import 'package:order_app/widget/flex_button.dart';

//控制台
class ConsolePage extends StatefulWidget {
  @override
  _ConsolePageState createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  CancelToken cancelToken = new CancelToken();

  ///监听更新操作
  StreamSubscription streamUpdate;
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
      ///监听更新操作
      streamUpdate =
          CommonUtils.eventBus.on<ConsoleRefreshEvent>().listen((event) {
        _requestAreaData();
      });
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
              Text(CommonUtils.getLocale(context).statusNotPay)
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
              Text(CommonUtils.getLocale(context).statusPaying),
              SizedBox(
                width: ScreenUtil.getInstance().setWidth(10),
              )
            ],
          ),
          AvoidDoubleClickInkWell(
            onTap: (){
              _requestAreaData();
            },
            child: Container(
              alignment: Alignment.center,
                padding: EdgeInsets.only(left: 15,right: 25),
                child: Text("刷新",style: TextStyle(
                  fontSize: MyTextStyle.normalTextSize
                ),)),
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
                          width: ScreenUtil.getInstance().setWidth(300),
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
                          width: ScreenUtil.getInstance().setWidth(300),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing:
                                          ScreenUtil.getInstance().setWidth(20),
                                      childAspectRatio: 3,
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
                                    width:
                                        ScreenUtil.getInstance().setWidth(100),
                                    color: Colors.black,
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
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
                                                      .child
                                                      .toString()
                                                      : "0") +
                                                  "）",
                                              color: bgColor,
                                              fontSize: MyTextStyle.bigTextSize,
                                              maxLines: 2,
                                              onPress: () {
                                                NavigatorUtils.navigatorRouter(
                                                    context,
                                                    ConsoleDetailPage(areaList[index]
                                                        .orders[index2]
                                                        .orderId,areaList[index].name));
                                              })
                                        )
                                      ],
                                    ));
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
    if (streamUpdate != null) {
      streamUpdate.cancel();
    }
    super.dispose();
  }
}
