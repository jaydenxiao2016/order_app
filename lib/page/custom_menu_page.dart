import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';

///客户工作台
class CustomMenuPage extends StatelessWidget {
  double height = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("客户工作台服务"),
        centerTitle: true,
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
        child: Column(
          children: <Widget>[
            //top
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  //轮信息
                  Expanded(
                    flex: 4,
                    child: RoundInfo(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text('15:00',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('101-K3',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.orange,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ConstrainedBox(
                      child: Image.asset(
                        'static/images/bg_logo.jpg',
                        fit: BoxFit.cover,
                      ), constraints: BoxConstraints.expand(),
                    ),
                  ),
                ],
              ),
            ),
            //middle
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ConstrainedBox(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              'static/images/hm1_de.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            child: Text(
                              '酒水',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ), onPressed: () {},
                          )
                        ],
                      ), constraints:  new BoxConstraints.expand(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ConstrainedBox(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              'static/images/hm2_de.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            child: Text(
                              '餐单',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ), onPressed: () {},
                          )
                        ],
                      ), constraints:  new BoxConstraints.expand(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ConstrainedBox(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              'static/images/hm3_de.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            child: Text(
                              '服务',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ), onPressed: () {},
                          )
                        ],
                      ), constraints:  new BoxConstraints.expand(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ConstrainedBox(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              'static/images/hm4_de.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            child: Text(
                              '结账',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ), onPressed: () {},
                          )
                        ],
                      ), constraints:  new BoxConstraints.expand(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///轮信息
class RoundInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      //水平子Widget之间间距
      crossAxisSpacing: 5.0,
      //垂直子Widget之间间距
      mainAxisSpacing: 5.0,
      //GridView内边距
      padding: EdgeInsets.all(5.0),
      //一行的Widget数量
      crossAxisCount: 3,
      //子Widget宽高比例
      childAspectRatio: 2.0,
      //子Widget列表
      children: getWidgetList(),
    );
  }
}


List<String> getDataList() {
  List<String> list = [];
  for (int i = 0; i < 10; i++) {
    list.add("第" + (i + 1).toString() + "轮");
  }
  return list;
}

List<Widget> getWidgetList() {
  return getDataList().map((item) => getItemContainer(item)).toList();
}

Widget getItemContainer(String item) {
  return Container(
    alignment: Alignment.center,
    child: RaisedButton(
      color: Colors.blue,
      child: Text(
        item,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ), onPressed: () {},
    ),
  );
}
