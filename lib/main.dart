import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:order_app/common/config/route_path.dart';
import 'package:order_app/common/localization/my_localizations_delegate.dart';
import 'package:order_app/common/model/user.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:order_app/common/utils/sp_util.dart';
import 'package:order_app/page/console/console_page.dart';
import 'package:order_app/page/control/service_control_page.dart';
import 'package:order_app/page/customMenu/custom_menu_page.dart';
import 'package:order_app/page/home_page.dart';
import 'package:order_app/page/login_page.dart';
import 'package:order_app/page/splash_page.dart';
import 'package:redux/redux.dart';

import 'common/config/config.dart';

///程序入口
void main() {
  ///强制横屏
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runZoned(() {
      runApp(FlutterReduxApp());
      PaintingBinding.instance.imageCache.maximumSize = 100;
    }, onError: (Object obj, StackTrace stack) {
      print(obj);
      print(stack);
    });
  });
}

///集成redux的app组件
class FlutterReduxApp extends StatefulWidget {
  FlutterReduxApp({Key key}) : super(key: key) {
    _initAsync();
  }

  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();

  ///初始化SharedPreferences
  void _initAsync() async {
    await SpUtil.init();
  }
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {
  /// initialState 初始化 State
  final store = new Store<StateInfo>(
    appReducer,
    middleware: middleware,
    initialState: new StateInfo(
        userInfo: User.empty(),
        themeData:
            CommonUtils.getThemeDataByIndex(SpUtil.getInt(Config.THEME_COLOR)),
        locale: Locale('zh', 'CH')),
  );

  @override
  Widget build(BuildContext context) {
    /// 通过 StoreProvider 应用 store
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<StateInfo>(builder: (context, store) {
        return new MaterialApp(

            ///多语言实现代理
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              MyLocalizationsDelegate.delegate,
            ],
            locale: store.state.locale,
            supportedLocales: [
              const Locale('de', 'LA'),
              const Locale('zh', 'CH'),
              const Locale('en', 'US')
            ],
            theme: store.state.themeData,
            routes: {
              ///启动页
              RoutePath.SPLASH_PATH: (context) {
                ///设置语言为上次次设置的
                CommonUtils.changeLocale(
                    store, context, SpUtil.getInt(Config.LOCALE));
                CommonUtils.changeTheme(
                    store, SpUtil.getInt(Config.THEME_COLOR));
                return SplashPage();
              },

              ///登录页
              RoutePath.LOGIN_PATH: (context) {
                return LoginPage();
              },

              ///主页
              RoutePath.HOME_PATH: (context) {
                return new MyLocalizations(
                  child: new HomePage(),
                );
              },

              ///服务台
              RoutePath.SERVICE_CONTROL_PATH: (context) {
                return new MyLocalizations(
                  child: new ServiceControlPage(1),
                );
              },
              ///控制台
              RoutePath.CONSOLE_PATH: (context) {
                return new MyLocalizations(
                  child: new ConsolePage(),
                );
              },
              ///客户工作台
              RoutePath.CUSTOM_MENU_PATH: (context) {
                return new MyLocalizations(
                  child: new CustomMenuPage(),
                );
              },
            });
      }),
    );
  }
}

///绑定语言切换的组件
class MyLocalizations extends StatefulWidget {
  final Widget child;

  MyLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<MyLocalizations> createState() {
    return new _MyLocalizations();
  }
}

class _MyLocalizations extends State<MyLocalizations> {
  StreamSubscription stream;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<StateInfo>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return new Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }
}
