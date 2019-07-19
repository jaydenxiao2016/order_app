import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/config/url_path.dart';
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

//酒水餐单
class MenuDrinkPage extends StatefulWidget {
  @override
  _MenuDrinkPageState createState() => _MenuDrinkPageState();
}

class _MenuDrinkPageState extends State<MenuDrinkPage> {
  CancelToken cancelToken = new CancelToken();

  ///已点数目
  int currentNum = 0;

  ///已点餐单和数目
  Map<int, int> selected = new Map();

  ///已点餐单key:分类id+商品id value:订单明细
  Map<int, OrderDetail> selectedProduct = new Map();
  List<OrderDetail> selectedProductList = new List();

  ///分类选择index
  int selectTypeIndex = 0;

  ///酒水分类
  CategoryResponseEntity categoryInfoEntity =
      new CategoryResponseEntity(data: List<Category>(), imgPath: "");

  ///当前商品信息
  List<Product> productList = new List();
  ProductResponseEntity productResponseEntity = new ProductResponseEntity(
      data: ProductInfoData()..list = List<Product>(), imgPath: "");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _requestDrinkCategoryData();
    });
  }

  ///计算已点数目
  _calculateCurrentNum() {
    int total = 0;
    selected.forEach((index, value) => total += value);
    print("total" + total.toString());
    selectedProductList.clear();
    selectedProduct.forEach((key, value) {
      selectedProductList.add(value);
    });
    setState(() {
      currentNum = total;
    });
  }

  ///获取酒水分类
  _requestDrinkCategoryData() async {
    print('请求酒水');
    if (mounted) {
      await HttpGo.getInstance()
          .get(UrlPath.getCategoryByPidPath +
              "?parentId=" +
              Config.DRINK_CATEGORY_ID.toString(),cancelToken: cancelToken)
          .then((baseResult) {
        ///默认选中第一个分类
        CategoryResponseEntity categoryResponseEntity =
            CategoryResponseEntity.fromJson(baseResult.data);
        if (categoryResponseEntity != null &&
            categoryResponseEntity.data != null &&
            categoryResponseEntity.data.length > 0) {
          ///请求商品
          _requestDrinkProductData(
              categoryResponseEntity.data[selectTypeIndex].id);
        }
        this.setState(() {
          categoryInfoEntity = CategoryResponseEntity.fromJson(baseResult.data);
        });
      }).catchError((error) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }
  }

  ///获取商品信息
  _requestDrinkProductData(int cId) async {
    print('请求商品');
    if (mounted) {
      await HttpGo.getInstance().post(UrlPath.productListPath, params: {
        "cid": cId,
        "pageSize": Config.PAGE_SIZE,
      },cancelToken: cancelToken).then((baseResult) {
        this.setState(() {
          productResponseEntity =
              ProductResponseEntity.fromJson(baseResult.data);
        });
      }).catchError((error) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }
  }

  ///跳转到确认菜单并监听返回结果
  _skipToRecordPage() {
    if (selectedProductList != null && selectedProductList.length > 0) {
      Navigator.push<bool>(
              context,
              new CupertinoPageRoute(
                  builder: (context) => MenuRecord(1, selectedProductList)))
          .then((isFinish) {
        if (isFinish != null && isFinish) {
          Navigator.pop(context);
        }
      });
    } else {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).emptyTip);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      String title = CommonUtils.getLocale(context).drink +
          " " +
          CommonUtils.getLocale(context).menu;
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          alignment: Alignment.topLeft,
          height: window.physicalSize.height,
          color: Colors.black,
          child: Row(
            children: <Widget>[
              ///左边
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    ///已点数目显示
                    SizedBox(
                      height: ScreenUtil.getInstance().setWidth(90),
                      child: Center(
                        child: Text(
                          currentNum.toInt().toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MyTextStyle.hugeTextSize,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    ///分类
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(ColorsStyle.lightGrayColor),
                                style: BorderStyle.solid,
                                width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: categoryInfoEntity.data.length,
                            separatorBuilder: (content, index) {
                              return new Container(
                                height: 1.0,
                                color: Color(ColorsStyle.lightGrayColor),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                color: index == selectTypeIndex
                                    ? Colors.lightBlue
                                    : Colors.black,
                                child: ListTile(
                                  onTap: () {
                                    _requestDrinkProductData(
                                        categoryInfoEntity.data[index].id);
                                    setState(() {
                                      selectTypeIndex = index;
                                    });
                                  },
                                  leading: CommonUtils.displayImageWidget(
                                      Config.BASE_URL +
                                              categoryInfoEntity.imgPath +
                                              (categoryInfoEntity
                                                  .data[index].pic) ??
                                          "",
                                      height:
                                          ScreenUtil.getInstance().setWidth(80),
                                      width: ScreenUtil.getInstance()
                                          .setWidth(80)),
                                  title: new Text(
                                    categoryInfoEntity.data[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MyTextStyle.bigTextSize,
                                        color: index == selectTypeIndex
                                            ? Colors.white
                                            : Color(
                                                ColorsStyle.lightGrayColor)),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(ColorsStyle.lightGrayColor),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),

                    ///操作按钮
                    Container(
                      height: ScreenUtil.getInstance().setWidth(80),
                      margin: EdgeInsets.all(5.0),
                      child: FlexButton(
                        color: Colors.deepOrange,
                        textColor: Colors.white,
                        fontSize: MyTextStyle.bigTextSize,
                        text: CommonUtils.getLocale(context).buy,
                        onPress: () {
                          _skipToRecordPage();
                        },
                      ),
                    )
                  ],
                ),
              ),

              ///右边
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil.getInstance().setWidth(90),
                      child: Center(
                        child: Text(
                          categoryInfoEntity.data.length > 0
                              ? categoryInfoEntity.data[selectTypeIndex].name
                              : "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MyTextStyle.bigTextSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: productResponseEntity.data.list.length,
                            separatorBuilder: (content, index) {
                              return new Container(
                                height: 3.0,
                                margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                color: Color(ColorsStyle.lightGrayColor),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              Product product =
                                  productResponseEntity.data.list[index];
                              return Container(
                                padding:
                                    EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    ///价钱
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 10.0, right: 15.0),
                                        padding: EdgeInsets.all(5.0),
                                        width: ScreenUtil.getInstance()
                                            .setWidth(130),
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3.0))),
                                        child: Text(
                                          product.price.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MyTextStyle.bigTextSize,
                                          ),
                                        )),

                                    ///标题
                                    Expanded(
                                      child: Text(
                                        product.id.toString() +
                                            ")    " +
                                            product.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MyTextStyle.bigTextSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    ///数量
                                    Container(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: PlusDecreaseText(
                                        inputValue: selected[categoryInfoEntity
                                                    .data[selectTypeIndex].id +
                                                product.id]
                                            ?.toString(),
                                        callback: (String value) {
                                          int key = categoryInfoEntity
                                                  .data[selectTypeIndex].id +
                                              product.id;
                                          int num = int.parse(value);
                                          if (num > 0) {
                                            selected[key] = num;
                                            print('已选中');
                                            print(selected);

                                            ///加入订单
                                            OrderDetail orderDetail =
                                                selectedProduct[key];
                                            if (orderDetail == null) {
                                              orderDetail = new OrderDetail(
                                                  productId: product.id,
                                                  orderId: store
                                                      .state
                                                      .loginResponseEntity
                                                      .orderMasterEntity
                                                      .orderId,
                                                  productNumber: num,
                                                  categoryName:
                                                      categoryInfoEntity
                                                          .data[selectTypeIndex]
                                                          .name,
                                                  productName: product.name,
                                                  detailType:
                                                      Config.DETAIL_DRINK_TYPE,
                                                  categoryId: categoryInfoEntity
                                                      .data[selectTypeIndex].id,
                                                  productPrice: product.price);
                                              selectedProduct[key] =
                                                  orderDetail;
                                            } else {
                                              orderDetail.productNumber = num;
                                            }
                                          } else {
                                            selected.remove(key);
                                            selectedProduct.remove(key);
                                          }

                                          ///计算已定餐单总数和总价
                                          _calculateCurrentNum();
                                        },
                                        color: Colors.white,
                                        fontSize: MyTextStyle.lagerTextSize,
                                        decreaseImg: 'static/images/minus.png',
                                        plusImg: 'static/images/plus.png',
                                      ),
                                      width: ScreenUtil.getInstance()
                                          .setWidth(280),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
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
