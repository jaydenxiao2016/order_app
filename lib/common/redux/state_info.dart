import 'package:flutter/material.dart';
import 'package:order_app/common/model/ServiceSetting.dart';
import 'package:order_app/common/model/user.dart';
import 'package:order_app/common/redux/service_control_redux.dart';
import 'package:order_app/common/redux/theme_redux.dart';
import 'package:order_app/common/redux/user_redux.dart';
import 'package:redux/redux.dart';

import 'locale_redux.dart';

///全局Redux store 的对象，保存State数据
class StateInfo {
  ///用户信息
  User userInfo;

  ///主题数据
  ThemeData themeData;

  ///语言
  Locale locale;

  ///服务控制信息
  ServiceSetting serviceSetting;

  ///构造方法
  StateInfo({this.userInfo, this.themeData, this.locale,this.serviceSetting});
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
StateInfo appReducer(StateInfo state, action) {
  return StateInfo(
    ///通过 UserReducer 将 GSYState 内的 userInfo 和 action 关联在一起
    userInfo: UserReducer(state.userInfo, action),

    ///通过 ThemeDataReducer 将 GSYState 内的 themeData 和 action 关联在一起
    themeData: ThemeDataReducer(state.themeData, action),

    ///通过 LocaleReducer 将 GSYState 内的 locale 和 action 关联在一起
    locale: LocaleReducer(state.locale, action),

    ///通过 ServiceControlReducer
    serviceSetting: ServiceControlReducer(state.serviceSetting, action),
  );
}

///中间件
final List<Middleware<StateInfo>> middleware = [
  UserInfoMiddleware(),
];
