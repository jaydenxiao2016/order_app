import 'package:order_app/common/model/order_detail.dart';

///订单主表
//int adult;//	integer($int32)
////成年人数
//
//int buyerId	;//integer($int32)
////餐区ID
//
//int child	;//integer($int32)
////小孩人数
//
//int dinnerNum	;//integer($int32)
////每轮晚餐能点的数量
//
//int lunchNum;//	integer($int32)
////每轮午餐能点的数量
//
//String openTime	;//string($date-time)
////开台时间
//
//int orderId	;//integer($int32)
////订单id
//
//List<OrderRound>orderRounds;
//
//String orderType	;//string
////订单类型 1午餐 2晚餐
//
//int pageNum	;//integer($int32)
////第几页
//
//int pageSize;//	integer($int32)
////每页显示数量
//
//String searchKey	;//string
////模糊查询参数
//
//String status;//	string
////订单状态 0未结账 1已结账 已取消
//
//String tableNum	;//string
////台号
//
//double totalAmount	;//number($double)
////订单总金额
//
//int waitTime;//	integer($int32)
////每轮需要等的时间

class OrderMasterEntity {
  String orderType;
  String orderNo;
  int orderId;
  List<OrderRound> orderRounds;
  int dinnerNum;
  int pageSize;
  String searchKey;
  int buyerId;
  int lunchNum;
  int pageNum;
  String drinksTotalAmount;
  String totalAmount;
  String tableNum;
  int adult;
  String openTime;
  int waitTime;
  int child;
  String status;

  OrderMasterEntity(
      {this.orderType,
      this.orderNo,
      this.orderId,
      this.orderRounds,
      this.dinnerNum,
      this.pageSize,
      this.searchKey,
      this.buyerId,
      this.lunchNum,
      this.pageNum,
      this.drinksTotalAmount,
      this.totalAmount,
      this.tableNum,
      this.adult,
      this.openTime,
      this.waitTime,
      this.child,
      this.status});

  OrderMasterEntity.fromJson(Map<String, dynamic> json) {
    orderType = json['orderType'];
    orderNo = json['orderNo'];
    orderId = json['orderId'];
    if (json['orderRounds'] != null) {
      orderRounds = new List<OrderRound>();
      (json['orderRounds'] as List).forEach((v) {
        orderRounds.add(new OrderRound.fromJson(v));
      });
    }
    dinnerNum = json['dinnerNum'];
    pageSize = json['pageSize'];
    searchKey = json['searchKey'];
    buyerId = json['buyerId'];
    lunchNum = json['lunchNum'];
    pageNum = json['pageNum'];
    drinksTotalAmount = json['drinksTotalAmount'].toString();
    totalAmount = json['totalAmount'].toString();
    tableNum = json['tableNum'];
    adult = json['adult'];
    openTime = json['openTime'];
    waitTime = json['waitTime'];
    child = json['child'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderType'] = this.orderType;
    data['orderNo'] = this.orderNo;
    data['orderId'] = this.orderId;
    if (this.orderRounds != null) {
      data['orderRounds'] = this.orderRounds.map((v) => v.toJson()).toList();
    }
    data['dinnerNum'] = this.dinnerNum;
    data['pageSize'] = this.pageSize;
    data['searchKey'] = this.searchKey;
    data['buyerId'] = this.buyerId;
    data['lunchNum'] = this.lunchNum;
    data['pageNum'] = this.pageNum;
    data['totalAmount'] = this.totalAmount;
    data['drinksTotalAmount'] = this.drinksTotalAmount;
    data['tableNum'] = this.tableNum;
    data['adult'] = this.adult;
    data['openTime'] = this.openTime;
    data['waitTime'] = this.waitTime;
    data['child'] = this.child;
    data['status'] = this.status;
    return data;
  }
}

class OrderRound {
  List<OrderDetail> orderDetails;
  String createTime;
  int orderId;
  int num;
  int pageSize;
  int id;
  String searchKey;
  int pageNum;

  OrderRound(
      {this.orderDetails,
      this.createTime,
      this.orderId,
      this.num,
      this.pageSize,
      this.id,
      this.searchKey,
      this.pageNum});

  OrderRound.fromJson(Map<String, dynamic> json) {
    if (json['orderDetails'] != null) {
      orderDetails = new List<OrderDetail>();
      (json['orderDetails'] as List).forEach((v) {
        orderDetails.add(new OrderDetail.fromJson(v));
      });
    }
    createTime = json['createTime'].toString();
    orderId = json['orderId'];
    num = json['num'];
    pageSize = json['pageSize'];
    id = json['id'];
    searchKey = json['searchKey'];
    pageNum = json['pageNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    data['createTime'] = this.createTime;
    data['orderId'] = this.orderId;
    data['num'] = this.num;
    data['pageSize'] = this.pageSize;
    data['id'] = this.id;
    data['searchKey'] = this.searchKey;
    data['pageNum'] = this.pageNum;
    return data;
  }
}

