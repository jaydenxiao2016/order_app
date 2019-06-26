import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/widget/flex_button.dart';

///订单确认
class MenuRecord extends StatefulWidget {
  @override
  _MenuRecordState createState() => new _MenuRecordState();
}

///获取订单内容
List<TableRow> _getContent() {
  List<TableRow> widgets = new List();

  ///标题
  widgets.add(TableRow(
      //第一行样式 添加背景色
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
      ),
      children: [
        //增加行高
        Padding(
          child: Text(
            '类别',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(8.0),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '类目',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '名字',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '价格',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '分类',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
        ),
      ]));

  ///内容
  for (int i = 0; i < 80; i++) {
    widgets.add(TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '张三' + i.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '张三' + i.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '张三' + i.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '张三' + i.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '张三' + i.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
    ]));
  }
  print("我来了");
  print(widgets.length);
  return widgets;
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
                child: SingleChildScrollView(
                  child: Table(
                    ///所以列宽
                    columnWidths: const {
                      //列宽
                      0: const FlexColumnWidth(1),
                      1: const FlexColumnWidth(1),
                      2: const FlexColumnWidth(2),
                      3: const FlexColumnWidth(2),
                      4: const FlexColumnWidth(1),
                    },

                    ///表格边框样式
                    border: TableBorder.all(
                      color: Colors.white10,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),

                    ///内容
                    children: _getContent(),
                  ),
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
                    width: 300.0,
                    height: 60.0,
                    margin: EdgeInsets.all(5.0),
                    child: FlexButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      text: CommonUtils.getLocale(context).back,
                      onPress: () {
                        Navigator.pop(context, false);
                      },
                    ),
                  ),
                  Container(
                    width: 300.0,
                    height: 60.0,
                    margin: EdgeInsets.all(5.0),
                    child: FlexButton(
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      text: CommonUtils.getLocale(context).sure,
                      onPress: () {
                        Navigator.pop(context, true);
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
}
