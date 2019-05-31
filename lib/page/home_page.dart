import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/sp_util.dart';
import 'package:redux/redux.dart';

///主页
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("主页"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("语言切换"),
                onPressed: () {
                  showLanguageDialog(context, store);
                },
              ),
              RaisedButton(
                child: Text("主题切换2"),
                onPressed: () {
                  showThemeDialog(context, store);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  showThemeDialog(BuildContext context, Store store) {
    List<String> list = [
      CommonUtils.getLocale(context).themeDefault,
      CommonUtils.getLocale(context).theme_1,
      CommonUtils.getLocale(context).theme_2,
      CommonUtils.getLocale(context).theme_3,
      CommonUtils.getLocale(context).theme_4,
      CommonUtils.getLocale(context).theme_5,
      CommonUtils.getLocale(context).theme_6,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.changeTheme(store, index);
      SpUtil.putInt(Config.THEME_COLOR, index);
    }, colorList: CommonUtils.getThemeListColor(), height: 360.0);
  }

  showLanguageDialog(BuildContext context, Store store) {
    List<String> list = [
      CommonUtils.getLocale(context).languageDefault,
      CommonUtils.getLocale(context).languageZh,
      CommonUtils.getLocale(context).languageDe,
      CommonUtils.getLocale(context).languageEn,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.changeLocale(store, context, index);
      SpUtil.putInt(Config.LOCALE, index);
    }, height: 210.0);
  }
}
