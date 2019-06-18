import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
///菜单内容
class StockInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(3.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: Text(
              "菜单内容",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            padding: EdgeInsets.all(5.0),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      child: Text("菜单内容" + index.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(ColorsStyle.mainTextColor),
                            fontSize: MyTextStyle.smallTextSize,
                          )),
                    );
                  }),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton.icon(
                    disabledColor: Theme.of(context).primaryColor,
                    highlightColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    textTheme: ButtonTextTheme.normal,
                    splashColor: Colors.white,
                    disabledTextColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    icon: Icon(
                      Icons.update,
                      size: 25.0,
                    ),
                    label: Text(CommonUtils.getLocale(context).updateMenu)),
              ),
            ],
          )
        ],
      ),
    );
  }
}