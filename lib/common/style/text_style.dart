import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_app/common/style/colors_style.dart';

///文本样式
class MyTextStyle {

  static const String app_default_share_url = "https://github.com/CarGuo/GSYGithubAppFlutter";

  static var hugeBigTextSize =  ScreenUtil.getInstance().setSp(60.0);
  static var hugeTextSize =  ScreenUtil.getInstance().setSp(50.0);
  static var lagerTextSize =  ScreenUtil.getInstance().setSp(40.0);
  static var bigTextSize = ScreenUtil.getInstance().setSp(30.0);
  static var normalTextSize =  ScreenUtil.getInstance().setSp(23.0);
  static var middleTextWhiteSize =  ScreenUtil.getInstance().setSp(23.0);
  static var smallTextSize = ScreenUtil.getInstance().setSp(20.0);
  static var minTextSize = ScreenUtil.getInstance().setSp(14.0);

  static var minText = TextStyle(
    color: Color(ColorsStyle.subLightTextColor),
    fontSize: minTextSize,
  );

  static var smallTextWhite = TextStyle(
    color: Color(ColorsStyle.textColorWhite),
    fontSize: smallTextSize,
  );

  static var smallText = TextStyle(
    color: Color(ColorsStyle.mainTextColor),
    fontSize: smallTextSize,
  );

  static var smallTextBold = TextStyle(
    color: Color(ColorsStyle.mainTextColor),
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static var smallSubLightText = TextStyle(
    color: Color(ColorsStyle.subLightTextColor),
    fontSize: smallTextSize,
  );

  static var smallActionLightText = TextStyle(
    color: Color(ColorsStyle.actionBlue),
    fontSize: smallTextSize,
  );

  static var smallMiLightText = TextStyle(
    color: Color(ColorsStyle.miWhite),
    fontSize: smallTextSize,
  );

  static var smallSubText = TextStyle(
    color: Color(ColorsStyle.subTextColor),
    fontSize: smallTextSize,
  );

  static var middleText = TextStyle(
    color: Color(ColorsStyle.mainTextColor),
    fontSize: middleTextWhiteSize,
  );

  static var middleTextWhite = TextStyle(
    color: Color(ColorsStyle.textColorWhite),
    fontSize: middleTextWhiteSize,
  );

  static var middleSubText = TextStyle(
    color: Color(ColorsStyle.subTextColor),
    fontSize: middleTextWhiteSize,
  );

  static var middleSubLightText = TextStyle(
    color: Color(ColorsStyle.subLightTextColor),
    fontSize: middleTextWhiteSize,
  );

  static var middleTextBold = TextStyle(
    color: Color(ColorsStyle.mainTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static var middleTextWhiteBold = TextStyle(
    color: Color(ColorsStyle.textColorWhite),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static var middleSubTextBold = TextStyle(
    color: Color(ColorsStyle.subTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static var normalText = TextStyle(
    color: Color(ColorsStyle.mainTextColor),
    fontSize: normalTextSize,
  );

  static var normalTextBold = TextStyle(
    color: Color(ColorsStyle.mainTextColor),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static var normalSubText = TextStyle(
    color: Color(ColorsStyle.subTextColor),
    fontSize: normalTextSize,
  );

  static var normalTextWhite = TextStyle(
    color: Color(ColorsStyle.textColorWhite),
    fontSize: normalTextSize,
  );

  static var normalTextMitWhiteBold = TextStyle(
    color: Color(ColorsStyle.miWhite),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static var normalTextActionWhiteBold = TextStyle(
    color: Color(ColorsStyle.actionBlue),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static var normalTextLight = TextStyle(
    color: Color(ColorsStyle.primaryLightValue),
    fontSize: normalTextSize,
  );

  static var largeText = TextStyle(
    color: Color(ColorsStyle.mainTextColor),
    fontSize: bigTextSize,
  );

  static var largeTextBold = TextStyle(
    color: Color(ColorsStyle.mainTextColor),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static var largeTextWhite = TextStyle(
    color: Color(ColorsStyle.textColorWhite),
    fontSize: bigTextSize,
  );

  static var largeTextWhiteBold = TextStyle(
    color: Color(ColorsStyle.textColorWhite),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static var largeLargeTextWhite = TextStyle(
    color: Color(ColorsStyle.textColorWhite),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static var largeLargeText = TextStyle(
    color: Color(ColorsStyle.primaryValue),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}
