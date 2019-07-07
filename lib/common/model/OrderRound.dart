///每轮订单表
class OrderRound{
  String createTime	;//string($date-time)
  //创建时间

  int id	;//integer($int32)
  //主键id

  int num	;//integer($int32)
  //第几轮

  List<OrderDetail> orderDetails;
  int orderId	;//integer($int32)
  //订单主表ID

  int pageNum	;//integer($int32)
  //第几页

  int pageSize	;//integer($int32)
  //每页显示数量

  int searchKey	;//string
  //模糊查询参数
}