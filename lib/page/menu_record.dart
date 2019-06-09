import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';

///订单确认
class MenuRecord extends StatefulWidget {
  @override
  _MenuRecordState createState() => new _MenuRecordState();
}

class _MenuRecordState extends State<MenuRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("订单确认"),
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
            //订单
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(3.0))
                ),
                //表格
                child: Table(
                  //所以列宽
                  columnWidths: const{
                    //列宽
                    0: const FlexColumnWidth(1),
                    1: const FlexColumnWidth(1),
                    2: const FlexColumnWidth(2),
                    3: const FlexColumnWidth(2),
                    4: const FlexColumnWidth(1),
                  },
                  //表格边框样式
                  border: TableBorder.all(
                    color: Colors.white10,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  children: [
                    TableRow(
                      //第一行样式 添加背景色
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                        ),
                        children: [
                          //增加行高
                          Padding(
                            child: Text('类别',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),),
                              padding: EdgeInsets.all(8.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('类目',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('名字',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('价格', textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('分类',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('张三',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black),),
                          ),
                        ]
                    ),
                  ],
                ),
              ),
            ),
            //操作按钮
            Container(
              height: 90.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 220.0,
                    margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                    child: RaisedButton.icon(onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text("返回")),
                  ),
                  Container(
                    width: 220.0,
                    margin: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: RaisedButton.icon(onPressed: () {},
                        icon: Icon(Icons.save),
                        label: Text("提交")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
