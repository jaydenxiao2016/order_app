import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/model/order_detail.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/widget/flex_button.dart';

///已点记录
class OrderRecord extends StatefulWidget {
  ///1：酒水 2：每轮订单 3:服务
  String type;
  int round;

  OrderRecord(this.type, {this.round, Key key}) : super(key: key);

  @override
  _OrderRecordState createState() => new _OrderRecordState();
}

class _OrderRecordState extends State<OrderRecord> {
  CancelToken cancelToken = new CancelToken();
  String imgPath = "";

  ///订单明细
  List<OrderDetail> orderDetailList = new List();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      /// 接口请求
      _requestOrderDetailData();
    });
  }

  ///获取订单详情信息
  _requestOrderDetailData() async {
    print('请求商品');
    if (mounted) {
      CommonUtils.showLoadingDialog(
          context,
          HttpGo.getInstance()
              .post(UrlPath.orderDetailPath,
                  params: {
                    "detailType": widget.type,
                    "orderId": CommonUtils.getStore(context)
                        .state
                        .loginResponseEntity
                        .orderMasterEntity
                        .orderId,
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
            if (mounted) {
              this.setState(() {
                this.imgPath = baseResult.data['imgPath'];
                this.orderDetailList = selectedDrinkProduct;
              });
            }
          }).catchError((error) {
            Fluttertoast.showToast(msg: error.toString());
          }));
    }
  }

  ///获取酒水内容
  Widget _getContent(int i, OrderDetail value) {
    return Container(
      color: i.isEven ? Colors.white : Color(0xFFF2F2F2),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: CommonUtils.displayImageWidget(
                    Config.getSettingBaseUrl() + imgPath + value.product.pic,
                    height: ScreenUtil.getInstance().setWidth(90),
                    width: ScreenUtil.getInstance().setWidth(110)),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 90.0,
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
            height: 90.0,
            width: 1,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value.productId.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontSize: MyTextStyle.smallTextSize),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 90.0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(CommonUtils.getLocale(context).orderSure),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        height: window.physicalSize.height,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            //订单
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10.0),
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
                                CommonUtils.getLocale(context).picture,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                              child: Text(
                                CommonUtils.getLocale(context).serialNum,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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

            ///操作按钮
            Container(
              margin: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil.getInstance().setWidth(400),
                    height: ScreenUtil.getInstance().setWidth(70),
                    margin: EdgeInsets.all(5.0),
                    child: FlexButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      fontSize: MyTextStyle.normalTextSize,
                      text: CommonUtils.getLocale(context).back,
                      onPress: () {
                        Navigator.pop(context, false);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //取消网络请求
    cancelToken.cancel("cancelled");
    super.dispose();
  }
}
