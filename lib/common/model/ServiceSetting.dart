///服务控制信息
class ServiceSetting {
  ///成人数
  int adult;

  ///小孩数
  int children;

  ///桌号
  String tableNum;

  ///密码
  String password;


  ///午餐能点的数量
  double lunchItem;

  ///晚餐能点的数量
  double dinnerItem;

  ///每轮等待时间
  double timer;

  ///午餐
  bool isLunch;
  ///晚餐
  bool isDiner;

  ///当前轮数
  int currentRound=1;

  ///当前时间
  String currentTime;

  ServiceSetting(
    this.adult,
    this.children,
    this.tableNum,
    this.password,
    this.lunchItem,
    this.dinnerItem,
    this.timer,
    this.isLunch,
    this.isDiner,
    this.currentRound,
    this.currentTime,
  );

  ServiceSetting.empty();
}
