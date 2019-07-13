import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/model/printer.dart';

class LoginResponseEntity {
  ///餐区信息
  List<LoginInfoArea> areas;
  ///系统设置
  LoginInfoSetting setting;
  ///本次订单主表
  OrderMasterEntity orderMasterEntity;

  LoginResponseEntity({this.areas, this.setting});

  LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    if (json['areas'] != null) {
      areas = new List<LoginInfoArea>();
      (json['areas'] as List).forEach((v) {
        areas.add(new LoginInfoArea.fromJson(v));
      });
    }
    setting = json['setting'] != null
        ? new LoginInfoSetting.fromJson(json['setting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.areas != null) {
      data['areas'] = this.areas.map((v) => v.toJson()).toList();
    }
    if (this.setting != null) {
      data['setting'] = this.setting.toJson();
    }
    return data;
  }
}
class LoginInfoArea {
  String name;
  int pageSize;
  int id;
  String pwd;
  int pageNum;

  LoginInfoArea({this.name, this.pageSize, this.id, this.pwd, this.pageNum});

  LoginInfoArea.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pageSize = json['pageSize'];
    id = json['id'];
    pwd = json['pwd'];
    pageNum = json['pageNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['pageSize'] = this.pageSize;
    data['id'] = this.id;
    data['pwd'] = this.pwd;
    data['pageNum'] = this.pageNum;
    return data;
  }
}

class LoginInfoSetting {
  double adultDinnerPrice;
  int servicePrinterId;
  double adultLunchPrice;
  double childLunchPrice;
  String appPwd;
  int dinnerNum;
  Printer servicePrinter;
  double childDinnerPrice;
  int id;
  int lunchNum;
  int waitTime;
  String ctlAppPwd;
  ///餐区
  int buyerId;
  ///成人数
  int adult;

  ///小孩数
  int children;

  ///桌号
  String tableNum;

  ///密码
  String password;
  ///午餐
  bool isLunch;
  ///晚餐
  bool isDiner;

  ///当前轮数
  int currentRound=1;

  ///当前时间
  String currentTime;

  LoginInfoSetting(
      {this.adultDinnerPrice,
      this.servicePrinterId,
      this.adultLunchPrice,
      this.childLunchPrice,
      this.appPwd,
      this.dinnerNum,
      this.servicePrinter,
      this.childDinnerPrice,
      this.id,
      this.lunchNum,
      this.waitTime,
      this.ctlAppPwd,
      this.buyerId,
      this.adult,
      this.children,
      this.tableNum,
      this.password,
      this.isLunch,
      this.isDiner,
      this.currentRound=1,
      this.currentTime,
      });

  LoginInfoSetting.fromJson(Map<String, dynamic> json) {
    adultDinnerPrice = json['adultDinnerPrice'];
    servicePrinterId = json['servicePrinterId'];
    adultLunchPrice = json['adultLunchPrice'];
    childLunchPrice = json['childLunchPrice'];
    appPwd = json['appPwd'];
    dinnerNum = json['dinnerNum'];
    servicePrinter = json['servicePrinter'] != null
        ? new Printer.fromJson(json['servicePrinter'])
        : null;
    childDinnerPrice = json['childDinnerPrice'];
    id = json['id'];
    lunchNum = json['lunchNum'];
    waitTime = json['waitTime'];
    ctlAppPwd = json['ctlAppPwd'];
    buyerId = json['buyerId'];
    adult = json['adult'];
    children = json['children'];
    tableNum = json['tableNum'];
    password = json['password'];
    isLunch = json['isLunch'];
    isDiner = json['isDiner'];
    currentRound = json['currentRound'];
    currentTime = json['currentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adultDinnerPrice'] = this.adultDinnerPrice;
    data['servicePrinterId'] = this.servicePrinterId;
    data['adultLunchPrice'] = this.adultLunchPrice;
    data['childLunchPrice'] = this.childLunchPrice;
    data['appPwd'] = this.appPwd;
    data['dinnerNum'] = this.dinnerNum;
    if (this.servicePrinter != null) {
      data['servicePrinter'] = this.servicePrinter.toJson();
    }
    data['childDinnerPrice'] = this.childDinnerPrice;
    data['id'] = this.id;
    data['lunchNum'] = this.lunchNum;
    data['waitTime'] = this.waitTime;
    data['ctlAppPwd'] = this.ctlAppPwd;
    data['buyerId'] = this.buyerId;
    data['adult'] = this.adult;
    data['children'] = this.children;
    data['tableNum'] = this.tableNum;
    data['password'] = this.password;
    data['isLunch'] = this.isLunch;
    data['isDiner'] = this.isDiner;
    data['currentRound'] = this.currentRound;
    data['currentTime'] = this.currentTime;
    return data;
  }
}

