import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/widget/PlusDecreaseInput.dart';
import 'package:order_app/widget/flex_button.dart';

//餐单
class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          Theme.of(context).primaryColor,
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
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Icon(Icons.mail),
                              title: new Text("分类" + index.toString()),
                            );
                          }),
                    ),
                  ),
                  //操作按钮
                  FlexButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    text: "确定",
                    onPress: () {},
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
                            Expanded(child: Text("价格" + index.toString())),
                            Container(
                              child: PlusDecreaseInput(
                                title: "fds",
                                textEditingController: TextEditingController(),
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
      ),
    );
  }
}
