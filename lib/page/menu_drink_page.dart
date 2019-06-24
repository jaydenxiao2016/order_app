import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/navigator_utils.dart';
import 'package:order_app/page/menu_record.dart';
import 'package:order_app/widget/PlusDecreaseText.dart';
import 'package:order_app/widget/flex_button.dart';

//酒水餐单
class MenuDrinkPage extends StatefulWidget {
  @override
  _MenuDrinkPageState createState() => _MenuDrinkPageState();
}

class _MenuDrinkPageState extends State<MenuDrinkPage> {
  ///已点数目
  int currentNum = 0;

  ///已点餐单和数目
  Map<int, int> selected = new Map();

  ///分类选择index
  int selectTypeIndex = 0;

  ///计算已点数目
  _calculateCurrentNum() {
    int total = 0;
    selected.forEach((index, value) => total += value);
    print("total" + total.toString());
    setState(() {
      currentNum = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      String title=CommonUtils.getLocale(context).drink+" " +CommonUtils.getLocale(context).menu;
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
              //左边
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    //已点数目显示
                    SizedBox(
                      height: 70.0,
                      child: Center(
                        child: Text(
                          currentNum.toInt().toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 60.0,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    //分类
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
                            itemCount: 20,
                            separatorBuilder: (content, index) {
                              return new Container(
                                height: 1.0,
                                color: Color(ColorsStyle.lightGrayColor),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 60.0,
                                color: index == selectTypeIndex
                                    ? Colors.lightBlue
                                    : Colors.black,
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      selectTypeIndex = index;
                                    });
                                  },
                                  leading: Image.asset(
                                    'static/images/41.png',
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                  title: new Text(
                                    "寿司" + index.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
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
                    //操作按钮
                    Container(
                      height: 70.0,
                      margin: EdgeInsets.all(5.0),
                      child: FlexButton(
                        color: Colors.deepOrange,
                        textColor: Colors.white,
                        text: CommonUtils.getLocale(context).buy,
                        onPress: () {
                          NavigatorUtils.navigatorRouter(context, MenuRecord());
                        },
                      ),
                    )
                  ],
                ),
              ),
              //右边
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70.0,
                      child: Center(
                        child: Text(
                          "酒水" + selectTypeIndex.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: 20,
                            separatorBuilder: (content, index) {
                              return new Container(
                                height: 3.0,
                                margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                color: Color(ColorsStyle.lightGrayColor),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0,right: 15.0),
                                      child: Image.asset(
                                        "static/images/27.png",
                                        width: 90.0,
                                        height: 90.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              index.toString() + ")  " + "第一标题",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:8.0),
                                              child: Text(
                                                "第二标题",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                      child: PlusDecreaseText(
                                        inputValue: selected[index]?.toString(),
                                        callback: (String value) {
                                          int num = int.parse(value);
                                          if (num > 0) {
                                            selected[index] = num;
                                          } else {
                                            selected.remove(index);
                                          }
//                                    //计算已定餐单
                                          _calculateCurrentNum();
                                        },
                                        color: Colors.white,
                                        decreaseImg: 'static/images/minus.png',
                                        plusImg: 'static/images/plus.png',
                                      ),
                                      width: 200.0,
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
}
