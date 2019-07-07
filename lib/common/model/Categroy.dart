
///菜品分类
class Category{
  int id;//	integer($int32)
  //主键ID

  String name	;//string
  int pageNum	;//integer($int32)第几页

  int pageSize	;//integer($int32)
  //每页显示数量

  int parentId	;//integer($int32)
  //父级ID

  String printIp	;//string
  //关联打印机IP地址

  String printerName	;//string
  //关联打印机名称

  int printid	;//integer($int32)
  //关联打印机ID

  String searchKey;//	string
  //模糊查询参数
}