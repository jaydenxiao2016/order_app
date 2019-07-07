///订单明细
class OrderDetail{
  int ategoryId	;//integer($int32)
  //菜品分类ID

  String categoryName;//	string
  //菜品分类名称

  String createTime	;//string($date-time)
  //创建时间

  int detailId;//	integer($int32)
  //订单详情表id

  int orderId;//	integer($int32)
  //订单主表id

  int pageNum	;//integer($int32)
  //第几页

  int pageSize	;//integer($int32)
  //每页显示数量

  int productId	;//integer($int32)
  //菜品ID

  String productName;//	string
  //菜品名称

  int productNumber	;//integer($int32)
  //菜品数量

 double productPrice	;//number($double)
  //菜品单价

  int roundId	;//integer($int32)
  //点餐轮数id

  String searchKey;//	string
  //模糊查询参数

 String updateTime;//	string($date-time)
 // 修改时间


}