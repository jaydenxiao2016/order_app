///订单服务信息
class OrderPrinterLog{

  String content	;//string
  //服务内容

  int id;//	integer($int32)
  //主键id

  int orderId	;//integer($int32)
  //订单主表ID

  int pageNum;//	integer($int32)
  //第几页

  int pageSize;//	integer($int32)
  //每页显示数量

  String pinterType	;//string
  //打印类型：1菜品打印 2酒水打印 3服务打印

  int printerId	;//integer($int32)
  //关联打印机ID

  String searchKey;//	string
  //模糊查询参数
}