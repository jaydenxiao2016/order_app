import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/utils/common_utils.dart';

///控制台
class ConsolePage extends StatefulWidget {
  @override
  _ConsolePageState createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  CancelToken cancelToken = new CancelToken();

  @override
  void initState() {
    super.initState();
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
            color: Colors.white,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              separatorBuilder: (content, index) {
                return new Container(
                  height:200,
                  color: Color(ColorsStyle.lightGrayColor),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 200,
                  height: window.physicalSize.height,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60, width: 200, child: Text("测试"+index.toString())),
                      Container(
                        width: 200,
                        height: window.physicalSize.height,
                        child: GridView.builder(
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5.0,
                                childAspectRatio: 3,
                                crossAxisSpacing: 5.0),
                            scrollDirection: Axis.vertical,
                            itemCount: 50,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  alignment: Alignment.center,
                                  child: Text("桌号"),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ));
    });
  }

  @override
  void dispose() {
    //取消网络请求
    cancelToken.cancel("cancelled");
    super.dispose();
  }
}
