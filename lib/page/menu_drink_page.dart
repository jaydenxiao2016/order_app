import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("酒水"),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        height: window.physicalSize.height,
        decoration: new BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme
                  .of(context)
                  .primaryColor,
              Color(ColorsStyle.white)
            ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1))),
        child: Row(
          children: <Widget>[
            //左边
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  //分类
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(3.0))),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 580,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Icon(Icons.mail),
                              title: new Text("分类" + index.toString()),
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
                      text: "确定",
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
              child: Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 20,

                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Row(
                          children: <Widget>[
                            Text("菜单内容" + index.toString()),
                            Expanded(child: Text(
                                "国家领导国家的福建高考的房间里感觉到" + index.toString())),
                            Container(
                              child: PlusDecreaseText(
                                title: "fds",
                                textEditingController: TextEditingController(),
                                color: Colors.white,
                                decreaseImg: 'static/images/minus.png',
                                plusImg: 'static/images/plus.png',
                              ),
                              width: 190.0,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
