import 'package:order_app/common/model/order_master_entity.dart';

class AreaEntity {
	String name;
	int pageSize;
	List<OrderMasterEntity> orders;
	int id;
	int pageNum;

	AreaEntity({this.name, this.pageSize, this.orders, this.id, this.pageNum});

	AreaEntity.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		pageSize = json['pageSize'];
		if (json['orders'] != null) {
			orders = new List<OrderMasterEntity>();(json['orders'] as List).forEach((v) { orders.add(new OrderMasterEntity.fromJson(v)); });
		}
		id = json['id'];
		pageNum = json['pageNum'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['pageSize'] = this.pageSize;
		if (this.orders != null) {
      data['orders'] =  this.orders.map((v) => v.toJson()).toList();
    }
		data['id'] = this.id;
		data['pageNum'] = this.pageNum;
		return data;
	}
}

