import 'package:order_app/common/model/category.dart';

class Product {
  double price;
  String name;
  String remark;
  int pageSize;
  int id;
  String no;
  String pic;
  int inventory;
  Category category;
  int pageNum;
  String status;
  int cid;

  Product({this.price, this.name,this.remark, this.pageSize, this.no,this.id, this.pic, this.inventory, this.category, this.pageNum, this.status, this.cid});

  Product.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    name = json['name'];
    remark = json['remark'];
    pageSize = json['pageSize'];
    id = json['id'];
    no = json['no'];
    pic = json['pic'];
    inventory = json['inventory'];
    category = json['category'] != null ? new Category.fromJson(json['category']) : null;
    pageNum = json['pageNum'];
    status = json['status'];
    cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['pageSize'] = this.pageSize;
    data['id'] = this.id;
    data['no'] = this.no;
    data['pic'] = this.pic;
    data['inventory'] = this.inventory;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['pageNum'] = this.pageNum;
    data['status'] = this.status;
    data['cid'] = this.cid;
    return data;
  }
}