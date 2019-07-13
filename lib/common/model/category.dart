import 'package:order_app/common/model/printer.dart';

class Category {
  int printid;
  Printer printer;
  String name;
  int pageSize;
  String state;
  int id;
  String pic;
  int pageNum;
  int parentId;

  Category({this.printid, this.printer, this.name, this.pageSize, this.state, this.id, this.pic, this.pageNum, this.parentId});

  Category.fromJson(Map<String, dynamic> json) {
    printid = json['printid'];
    printer = json['printer'] != null ? new Printer.fromJson(json['printer']) : null;
    name = json['name'];
    pageSize = json['pageSize'];
    state = json['state'];
    id = json['id'];
    pic = json['pic'];
    pageNum = json['pageNum'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['printid'] = this.printid;
    if (this.printer != null) {
      data['printer'] = this.printer.toJson();
    }
    data['name'] = this.name;
    data['pageSize'] = this.pageSize;
    data['state'] = this.state;
    data['id'] = this.id;
    data['pic'] = this.pic;
    data['pageNum'] = this.pageNum;
    data['parentId'] = this.parentId;
    return data;
  }
}