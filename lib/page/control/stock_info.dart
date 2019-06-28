import 'package:flutter/material.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/widget/flex_button.dart';
///菜单内容
class StockInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0,bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(3.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: Text(
              CommonUtils.getLocale(context).menuContent,
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
                  itemCount: 30,
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
          Container(
            color: Colors.black,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlexButton(
                    color: Colors.white,
                    textColor: Colors.black,
                    text: CommonUtils.getLocale(context).updateMenu,
                    onPress: () {

                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}