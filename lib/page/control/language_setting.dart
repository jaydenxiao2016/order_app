import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/sp_util.dart';
///设置语言
class LanguageSetting extends StatefulWidget {
  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
          child: Row(
            children: <Widget>[
              //德文
              Expanded(
                child: RadioListTile<Locale>(
                  value: CommonUtils.getLanguageList(context)[1],
                  title: Text(CommonUtils.getLocale(context).languageDe),
                  groupValue: store.state.locale,
                  onChanged: (value) {
                    CommonUtils.changeLocale(store, context, 1);
                    SpUtil.putInt(Config.LOCALE, 1);
                  },
                ),
              ),
              //中文
              Expanded(
                child: RadioListTile<Locale>(
                  value: CommonUtils.getLanguageList(context)[2],
                  title: Text(CommonUtils.getLocale(context).languageZh),
                  groupValue: store.state.locale,
                  onChanged: (value) {
                    CommonUtils.changeLocale(store, context, 2);
                    SpUtil.putInt(Config.LOCALE, 2);
                  },
                ),
              ),
              //英文
              Expanded(
                child: RadioListTile<Locale>(
                  value: CommonUtils.getLanguageList(context)[3],
                  title: Text(CommonUtils.getLocale(context).languageEn),
                  groupValue: store.state.locale,
                  onChanged: (value) {
                    CommonUtils.changeLocale(store, context, 3);
                    SpUtil.putInt(Config.LOCALE, 3);
                  },
                ),
              ),
            ],
          ));
    });
  }
}