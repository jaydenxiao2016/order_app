import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/event/timer_event.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/widget/flex_button.dart';

///订单确认
class MenuRecord extends StatefulWidget {
  @override
  _MenuRecordState createState() => new _MenuRecordState();
}

///获取订单内容
Widget _getContent(int i, value) {
  return Container(
    color: i.isEven ? Colors.white : Color(0xFFF2F2F2),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '张三' + i.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
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
              '张三' + i.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
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
              '张三' + i.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
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
              '张三' + i.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
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
              '张三' + i.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}

class _MenuRecordState extends State<MenuRecord> {
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
                      height: 35.0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("类别", textAlign: TextAlign.center),
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
                              child: Text("类目", textAlign: TextAlign.center),
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
                              child: Text("名称", textAlign: TextAlign.center),
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
                              child: Text("价格", textAlign: TextAlign.center),
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
                              child: Text("分类", textAlign: TextAlign.center),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                        itemCount: 80,
                        itemBuilder: (BuildContext context, int index) {
                          return _getContent(index, "dfd");
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
                        CommonUtils.eventBus.fire(TimerEvent());
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
