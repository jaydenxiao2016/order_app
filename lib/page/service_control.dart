import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/widget/PlusDecreaseInput.dart';
import 'package:order_app/widget/slide_bar.dart';

///开台服务界面
class ServiceControl extends StatefulWidget {
  @override
  _ServiceControlState createState() => _ServiceControlState();
}

class _ServiceControlState extends State<ServiceControl> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("开台服务"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: window.physicalSize.width,
          decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme
                    .of(context)
                    .primaryColor,
                Color(ColorsStyle.white)
              ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1))),
          padding: EdgeInsets.all(20.0),
          child: Column(children: <Widget>[
            //客人位数信息
            PeopleAndNumInfo(),
            Padding(padding: EdgeInsets.all(5.0),),
            //设置信息
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(3.0))
              ),
              child: Column(
                children: <Widget>[
                  SlideBar(
                    title: '午餐数量',
                    titleColor: Colors.redAccent,
                    min: 0.0,
                    max: 10.0,
                    value: 5.0,
                    divisions: 10,),
                  SlideBar(
                    title: '晚餐数量',
                    titleColor: Colors.redAccent,
                    min: 0.0,
                    max: 10.0,
                    value: 5.0,
                    divisions: 10,),
                  SlideBar(
                    title: '每轮时间',
                    titleColor: Colors.redAccent,
                    min: 0.0,
                    max: 30.0,
                    value: 15.0,
                    divisions: 30,),
                ],
              ),
            ),
            //操作信息
            Operations(),
            //库存信息
            StockInfo(),
          ],),
        ),
      ),
    );
  }
}
class StockInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(3.0))
      ),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 200.0,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text("菜单内容"+index.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color(ColorsStyle.mainTextColor),
                          fontSize: MyTextStyle.smallTextSize,
                        )),
                  );
                }),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton.icon(
                    disabledColor: Theme
                        .of(context)
                        .primaryColor,
                    highlightColor: Theme
                        .of(context)
                        .primaryColor,
                    textColor: Colors.white,
                    textTheme: ButtonTextTheme.normal,
                    splashColor: Colors.white,
                    disabledTextColor: Colors.white,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    onPressed: () {},
                    icon: Icon(Icons.update, size: 25.0,),
                    label: Text("更新菜单")),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class Operations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton.icon(
                disabledColor: Colors.blueAccent,
                highlightColor: Colors.blue,
                textColor: Colors.white,
                textTheme: ButtonTextTheme.normal,
                splashColor: Colors.white,
                disabledTextColor: Colors.white,
                color: Colors.blue,
                onPressed: () {},
                icon: Icon(Icons.person_add, size: 25.0,),
                label: Text("午餐确认")),
          ),
          Padding(padding: EdgeInsets.all(5.0),),
          Expanded(
            child: RaisedButton.icon(
                disabledColor: Colors.blueAccent,
                highlightColor: Colors.blue,
                textColor: Colors.white,
                textTheme: ButtonTextTheme.normal,
                splashColor: Colors.white,
                disabledTextColor: Colors.white,
                color: Colors.blue,
                onPressed: () {},
                icon: Icon(Icons.person_add, size: 25.0,),
                label: Text("晚餐确认")),
          ),
        ],
      ),
    );
  }
}


class PeopleAndNumInfo extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(3.0))
      ),
      child: Column(
        children: <Widget>[
          Container(
              child: PlusDecreaseInput(
                textEditingController: controller, title: "成人",)
          ),
          Container(
              child: PlusDecreaseInput(
                textEditingController: controller, title: "小孩",)
          ),
          Container(
              child: PlusDecreaseInput(
                textEditingController: controller, title: "桌号",)
          ),
          Container(
              child: PlusDecreaseInput(
                textEditingController: controller,
                decreaseVisible: false,
                plusVisible: false,
                title: "密码",)
          ),
        ],
      ),
    );
  }
}





