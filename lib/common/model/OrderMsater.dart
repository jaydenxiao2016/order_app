import  'package:order_app/common/model/OrderRound.dart';
///订单主表
class OrderMsater{
  int adult;//	integer($int32)
  //成年人数

  int buyerId	;//integer($int32)
  //餐区ID

  int child	;//integer($int32)
  //小孩人数

  int dinnerNum	;//integer($int32)
  //每轮晚餐能点的数量

  int lunchNum;//	integer($int32)
  //每轮午餐能点的数量

  String openTime	;//string($date-time)
  //开台时间

  int orderId	;//integer($int32)
  //订单id

  List<OrderRound>orderRounds;

  String orderType	;//string
  //订单类型 1午餐 2晚餐

  int pageNum	;//integer($int32)
  //第几页

  int pageSize;//	integer($int32)
  //每页显示数量

  String searchKey	;//string
  //模糊查询参数

  String status;//	string
  //订单状态 0未结账 1已结账 已取消

  String tableNum	;//string
  //台号

  double totalAmount	;//number($double)
  //订单总金额

  int waitTime;//	integer($int32)
  //每轮需要等的时间
}