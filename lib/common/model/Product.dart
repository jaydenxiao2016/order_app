import  'package:order_app/common/model/Categroy.dart';
///菜品新鲜
class Product{
  Category	category;
int cid	;//integer($int32)
//菜品类型ID

int id	;//integer($int32)
//主键ID

int inventory	;//integer($int32)
//库存

String name;//	string
//菜品名称

int pageNum	;//integer($int32)
//第几页

int pageSize;//	integer($int32)
//每页显示数量

String pic;//	string
//菜品图片

double price;//	number($double)
//单价

String searchKey;//	string
//模糊查询参数

int status	;//integer($int32)
//状态 1上架 0下架
}

