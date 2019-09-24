import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/config/url_path.dart';
import 'package:order_app/common/event/timer_event.dart';
import 'package:order_app/common/model/order_detail.dart';
import 'package:order_app/common/model/order_round_detail_entity.dart';
import 'package:order_app/common/model/order_service_detail_entity.dart';
import 'package:order_app/common/net/http_go.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/widget/flex_button.dart';

///订单确认
class MenuRecord extends StatefulWidget {
  ///1：酒水 2：每轮订单 3:服务
  int type;
  ///图片地址
  String imgPath;
  ///订单明细
  List<OrderDetail> selectedDrinkProduct = new List();
  MenuRecord(this.type,this.imgPath,this.selectedDrinkProduct,{Key key}):super(key:key);
  @override
  _MenuRecordState createState() => new _MenuRecordState();
}



class _MenuRecordState extends State<MenuRecord> {
  CancelToken cancelToken = new CancelToken();
  ///酒水下单
  _requestDrinkConfirm(BuildContext context) async{
    print('请求酒水下单');
    CommonUtils.showLoadingDialog(context, HttpGo.getInstance().post(UrlPath.drinkConfirmPath, params: widget.selectedDrinkProduct.map((v) => v.toJson()).toList(),cancelToken: cancelToken).then((baseResult) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).orderSuccess);
      Navigator.maybePop(context, true);
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    }));
  }
  ///每轮点餐下单
  _requestRoundFoodConfirm(BuildContext context) async{
    if (CommonUtils.getStore(context)
        .state
        .loginResponseEntity
        .orderMasterEntity
        .orderRounds
        .length >=
        Config.ROUND_MAX) {
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).orderFoodTooMuchTip);
      return;
    }
    ///倒计时结束才能下单
    if(!CommonUtils.getStore(context).state.loginResponseEntity.setting.isTimeFinish){
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).reOrderFoodTip);
      return;
    }
    print('请求每轮点餐下单');
    OrderRoundDetailEntity orderRoundDetailEntity=new OrderRoundDetailEntity();
    orderRoundDetailEntity.orderDetails=widget.selectedDrinkProduct;
    orderRoundDetailEntity.num=CommonUtils.getStore(context).state.loginResponseEntity.orderMasterEntity.orderRounds.length+1;
    orderRoundDetailEntity.orderId=CommonUtils.getStore(context).state.loginResponseEntity.orderMasterEntity.orderId;
    CommonUtils.showLoadingDialog(context, HttpGo.getInstance().post(UrlPath.orderRoundConfirmPath, params: orderRoundDetailEntity.toJson(),cancelToken: cancelToken).then((baseResult) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).orderSuccess);
      CommonUtils.eventBus.fire(TimerEvent());
      Navigator.maybePop(context, true);
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    }));
  }
///服务下单
  _requestServiceConfirm(BuildContext context) async{
    print('请求服务下单');
    OrderServiceDetailEntity orderServiceDetailEntity=new OrderServiceDetailEntity(orderId: CommonUtils.getStore(context).state.loginResponseEntity.orderMasterEntity.orderId,
    needServiceDetails: widget.selectedDrinkProduct);
    CommonUtils.showLoadingDialog(context, HttpGo.getInstance().post(UrlPath.orderNeedServicePath, params: orderServiceDetailEntity.toJson(),cancelToken: cancelToken).then((baseResult) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).orderSuccess);
      if(widget.type==2) {
        CommonUtils.eventBus.fire(TimerEvent());
      }
      Navigator.maybePop(context, true);
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    }));
  }

  ///获取订单内容
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
                child: CommonUtils.displayImageWidget(Config.getSettingBaseUrl() +widget.imgPath+(value.product.pic??""),height: ScreenUtil.getInstance().setWidth(90),width: ScreenUtil.getInstance().setWidth(110)),
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
                value.product.no.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontSize: MyTextStyle.smallTextSize),
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
                style: TextStyle(color: Colors.black,fontSize: MyTextStyle.smallTextSize),
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
                style: TextStyle(color: Colors.black,fontSize: MyTextStyle.smallTextSize),
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
                value.productPrice.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontSize: MyTextStyle.smallTextSize),
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
                      height: ScreenUtil.getInstance().setWidth(50),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(CommonUtils.getLocale(context).picture, textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: MyTextStyle.smallTextSize
                                ),),
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
                              child: Text(CommonUtils.getLocale(context).serialNum, textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                fontSize: MyTextStyle.smallTextSize
                              ),),
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
                              child: Text(CommonUtils.getLocale(context).num, textAlign: TextAlign.center,style: TextStyle(
                                  fontSize: MyTextStyle.smallTextSize
                              )),
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
                              child: Text(CommonUtils.getLocale(context).name, textAlign: TextAlign.center,style: TextStyle(
                                  fontSize: MyTextStyle.smallTextSize
                              )),
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
                              child: Text(CommonUtils.getLocale(context).price, textAlign: TextAlign.center,style: TextStyle(
                                  fontSize: MyTextStyle.smallTextSize
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                        itemCount: widget.selectedDrinkProduct.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _getContent(index, widget.selectedDrinkProduct[index]);
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
                        Navigator.maybePop(context, false);
                      },
                    ),
                  ),
                  Container(
                    width: ScreenUtil.getInstance().setWidth(400),
                    height: ScreenUtil.getInstance().setWidth(70),
                    margin: EdgeInsets.all(5.0),
                    child: FlexButton(
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      fontSize: MyTextStyle.normalTextSize,
                      text: CommonUtils.getLocale(context).sure,
                      onPress: () {
                        if(widget.type==1){
                          this._requestDrinkConfirm(context);
                        }else if(widget.type==2){
                          this._requestRoundFoodConfirm(context);
                        }else{
                          this._requestServiceConfirm(context);
                        }
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
