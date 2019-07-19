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
import 'package:order_app/common/model/product.dart';
import 'package:order_app/common/model/product_response_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _requestAreaData();
    });
  }

  ///获取酒水分类
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
    print('请求确认结账');
    if (mounted) {
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
              "确认已经结账了吗",
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
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  CommonUtils.getLocale(context).sure,
                  style: TextStyle(
                      color: Colors.blue, fontSize: MyTextStyle.normalTextSize),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  HttpGo.getInstance()
                      .post(
                          UrlPath.settlementPath +
                              "?orderId=" +
                              orderId.toString(),
                          cancelToken: cancelToken)
                      .then((baseResult) {
                    Fluttertoast.showToast(msg: "确认结账成功");
                    _requestAreaData();
                  }).catchError((error) {
                    Fluttertoast.showToast(msg: error.toString());
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      String title = CommonUtils.getLocale(context).drink +
          " " +
          CommonUtils.getLocale(context).menu;
      AppBar appBar = AppBar(
        title: Text(title),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 20,
                width: 40,
                margin: EdgeInsets.all(5.0),
                color: Color(0xFFF2F2F2),
              ),
              Text("未结账")
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                height: 20,
                width: 40,
                margin: EdgeInsets.all(5.0),
                color: Colors.redAccent,
              ),
              Text("结账中"),
              SizedBox(
                width: 10,
              )
            ],
          )
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
                          height: ScreenUtil.getInstance().setWidth(80),
                          alignment: Alignment.center,
                          width: ScreenUtil.getInstance().setWidth(360),
                          color:
                              index.isEven ? Color(0xFFE0E0E0) : Colors.white,
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
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 25.0,
                                      childAspectRatio: 2,
                                      crossAxisSpacing: 10.0),
                              scrollDirection: Axis.vertical,
                              itemCount: areaList[index].orders.length,
                              itemBuilder: (BuildContext context, int index2) {
//                                订单状态 0未结账 1结账中 2已结账 3已取消
                                String status =
                                    areaList[index].orders[index2].status;
                                return Container(
                                    height: 60,
                                    width: 80,
                                    alignment: Alignment.center,
                                    child: FlexButton(
                                        text: areaList[index]
                                            .orders[index2]
                                            .tableNum,
                                        color: status == "0"
                                            ? Color(0xFFF2F2F2)
                                            : Colors.redAccent,
                                        fontSize: MyTextStyle.bigTextSize,
                                        onPress: () {
                                          _requestSettlement(areaList[index]
                                              .orders[index2]
                                              .orderId);
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
