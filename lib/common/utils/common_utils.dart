import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbar/flutter_statusbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/localization/default_localizations.dart';
import 'package:order_app/common/redux/locale_redux.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/redux/theme_redux.dart';
import 'package:order_app/common/style/colors_style.dart';
import 'package:order_app/common/style/string_base.dart';
import 'package:order_app/common/style/text_style.dart';
import 'package:order_app/widget/flex_button.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

///通用逻辑
class CommonUtils {
  static final double MILLIS_LIMIT = 1000.0;

  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static double sStaticBarHeight = 0.0;

  static final EventBus eventBus = new EventBus();

  static void initStatusBarHeight(context) async {
    sStaticBarHeight =
        await FlutterStatusbar.height / MediaQuery.of(context).devicePixelRatio;
  }

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  ///日期格式转换
  static String getNewsTimeStr(DateTime date) {
    int subTime =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (subTime < MILLIS_LIMIT) {
      return "刚刚";
    } else if (subTime < SECONDS_LIMIT) {
      return (subTime / MILLIS_LIMIT).round().toString() + " 秒前";
    } else if (subTime < MINUTES_LIMIT) {
      return (subTime / SECONDS_LIMIT).round().toString() + " 分钟前";
    } else if (subTime < HOURS_LIMIT) {
      return (subTime / MINUTES_LIMIT).round().toString() + " 小时前";
    } else if (subTime < DAYS_LIMIT) {
      return (subTime / HOURS_LIMIT).round().toString() + " 天前";
    } else {
      return getDateStr(date);
    }
  }

  static splitFileNameByPath(String path) {
    return path.substring(path.lastIndexOf("/"));
  }

  ///切换主题
  static changeTheme(Store store, int index) {
    ThemeData themeData;
    List<Color> colors = getThemeListColor();
    themeData = getThemeData(colors[index]);
    store.dispatch(new RefreshThemeDataAction(themeData));
  }

  ///获取主题颜色
  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }

  ///获取主题颜色
  static getThemeDataByIndex(int index) {
    return ThemeData(
        primarySwatch: getThemeListColor()[index],
        platform: TargetPlatform.android);
  }

  ///切换语言
  static changeLocale(Store<StateInfo> store, BuildContext context, int index) {
    store.dispatch(RefreshLocaleAction(getLanguageList(context)[index]));
  }

  ///切换语言
  static changeLocale2(
      Store<StateInfo> store, BuildContext context, Locale locale) {
    store.dispatch(RefreshLocaleAction(locale));
  }

  ///获取当前语言
  static StringBase getLocale(BuildContext context) {
    return MyLocalizations.of(context).currentLocalized;
  }

  ///获取语言列表
  static List<Locale> getLanguageList(BuildContext context) {
    return [
      Localizations.localeOf(context),
      Locale('de', 'LA'),
      Locale('zh', 'CH'),
      Locale('en', 'US')
    ];
  }

  ///获取主题列表
  static List<Color> getThemeListColor() {
    return [
      ColorsStyle.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  static const IMAGE_END = [".png", ".jpg", ".jpeg", ".gif", ".svg"];

  ///是否是图片文件
  static isImageEnd(path) {
    bool image = false;
    for (String item in IMAGE_END) {
      if (path.indexOf(item) + item.length == path.length) {
        image = true;
      }
    }
    return image;
  }

  ///复制到剪贴板
  static copy(String data, BuildContext context) {
    Clipboard.setData(new ClipboardData(text: data));
    Fluttertoast.showToast(
        msg: CommonUtils.getLocale(context).optionShareCopySuccess);
  }

  ///intent跳转
  static launchOutURL(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).optionWebLauncherError +
              ": " +
              url);
    }
  }

  ///loading
  static Future<Null> showLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(child: CircularProgressIndicator()),
                        new Container(height: 10.0),
                        new Container(
                            child: new Text(
                                CommonUtils.getLocale(context).loadingText,
                                style: MyTextStyle.normalTextWhite)),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  ///选择弹出框
  static Future<Null> showCommitOptionDialog(
    BuildContext context,
    List<String> commitMaps,
    ValueChanged<int> onTap, {
    width = 300.0,
    height = 400.0,
    List<Color> colorList,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new Container(
              width: width,
              height: height,
              padding: new EdgeInsets.all(10.0),
              margin: new EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: Color(ColorsStyle.white),
                //用一个BoxDecoration装饰器提供背景图片
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: new ListView.builder(
                  itemCount: commitMaps.length,
                  itemBuilder: (context, index) {
                    return FlexButton(
                      maxLines: 2,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14.0,
                      color: colorList != null
                          ? colorList[index]
                          : Theme.of(context).primaryColor,
                      text: commitMaps[index],
                      textColor: Color(ColorsStyle.white),
                      onPress: () {
                        Navigator.pop(context);
                        onTap(index);
                      },
                    );
                  }),
            ),
          );
        });
  }

  ///获取store
  static Store<StateInfo> getStore(BuildContext context) {
    if (context == null) {
      return null;
    }
    return StoreProvider.of(context);
  }

  ///显示图片
  static Widget displayImageWidget(String url,{double height=60,double width=60}) {
    return CachedNetworkImage(
      height:height,
      width:width,
      imageUrl: url,
      placeholder: (context, url) => new CircularProgressIndicator(),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }
}
