import 'package:order_app/common/model/category.dart';

///菜品分类
//description:
//菜品分类
//
//id	integer($int32)
//主键ID
//
//name	string
//分类名称
//
//pageNum	integer($int32)
//第几页
//
//pageSize	integer($int32)
//每页显示数量
//
//parentId	integer($int32)
//父级ID
//
//pic	string
//图片
//
//searchKey	string
//模糊查询参数
class CategoryResponseEntity {
	List<Category> data;
	String imgPath;

	CategoryResponseEntity({this.data, this.imgPath});

	CategoryResponseEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = new List<Category>();(json['data'] as List).forEach((v) { data.add(new Category.fromJson(v)); });
		}
		imgPath = json['imgPath'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['imgPath'] = this.imgPath;
		return data;
	}
}

