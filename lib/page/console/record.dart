import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/event/type_refresh_event.dart';
import 'package:order_app/common/model/order_detail.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';

///订单明细
class Record extends StatefulWidget {
  ///1：酒水 2：每轮订单 3:服务
  String type;
  int orderId;
  int round;

  Record(this.type, this.orderId, {this.round, Key key}) : super(key: key);

  @override
  _RecordState createState() => new _RecordState();
}

///获取酒水内容
Widget _getContent(int i, OrderDetail value) {
  return Container(
    color: i.isEven ? Colors.white : Color(0xFFF2F2F2),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value.product.no.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black, fontSize: MyTextStyle.smallTextSize),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: 35.0,
          width: 1,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value.categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black, fontSize: MyTextStyle.smallTextSize),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: 35.0,
          width: 1,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value.productName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black, fontSize: MyTextStyle.smallTextSize),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: 35.0,
          width: 1,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value.productNumber.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black, fontSize: MyTextStyle.smallTextSize),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: 35.0,
          width: 1,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value.productPrice.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black, fontSize: MyTextStyle.smallTextSize),
            ),
          ),
        ),
      ],
    ),
  );
}

class _RecordState extends State<Record> {
  CancelToken cancelToken = new CancelToken();

  ///监听更新操作
  StreamSubscription streamUpdate;

  ///订单明细
  List<OrderDetail> orderDetailList = new List();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      /// 接口请求
      _requestOrderDetailData();

      ///监听更新操作
      streamUpdate =
          CommonUtils.eventBus.on<TypeRefreshEvent>().listen((event) {
        this.widget.type = event.type;
        this.widget.orderId = event.orderId;
        this.widget.round = event.roundId;
        _requestOrderDetailData();
      });
    });
  }

  ///获取订单详情信息
  _requestOrderDetailData() async {
    print('请求商品');
    if (mounted) {
      await HttpGo.getInstance()
          .post(UrlPath.orderDetailPath,
              params: {
                "detailType": widget.type,
                "orderId": widget.orderId,
                "roundId": widget.round,
                "pageNum": 1,
                "pageSize": Config.PAGE_SIZE,
              },
              cancelToken: cancelToken)
          .then((baseResult) {
        List<OrderDetail> selectedDrinkProduct = new List();
        (baseResult.data['data']['list'] as List).forEach((v) {
          selectedDrinkProduct.add(new OrderDetail.fromJson(v));
        });
        if(mounted) {
          this.setState(() {
            this.orderDetailList = selectedDrinkProduct;
          });
        }
      }).catchError((error) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: window.physicalSize.height,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          //订单
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(3.0))),

              ///表格
              child: Column(
                children: <Widget>[
                  ///表头
                  Container(
                    color: Colors.yellowAccent,
                    height: ScreenUtil.getInstance().setWidth(60),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              CommonUtils.getLocale(context).serialNum,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: MyTextStyle.smallTextSize),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 35.0,
                          width: 1,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                CommonUtils.getLocale(context).categories,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: MyTextStyle.smallTextSize)),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 35.0,
                          width: 1,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(CommonUtils.getLocale(context).name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: MyTextStyle.smallTextSize)),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 35.0,
                          width: 1,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(CommonUtils.getLocale(context).num,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: MyTextStyle.smallTextSize)),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 35.0,
                          width: 1,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(CommonUtils.getLocale(context).price,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: MyTextStyle.smallTextSize)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: ListView.builder(
                      itemCount: orderDetailList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _getContent(index, orderDetailList[index]);
                      },
                    ),
                  ))

                  ///内容
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
