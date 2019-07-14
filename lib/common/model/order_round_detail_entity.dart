import 'package:order_app/common/model/order_detail.dart';
///每轮订单明细
class OrderRoundDetailEntity {
	List<OrderDetail> orderDetails;
	String createTime;
	int orderId;
	int num;
	int pageSize;
	int id;
	String searchKey;
	int pageNum;

	OrderRoundDetailEntity({this.orderDetails, this.createTime, this.orderId, this.num, this.pageSize, this.id, this.searchKey, this.pageNum});

	OrderRoundDetailEntity.fromJson(Map<String, dynamic> json) {
		if (json['orderDetails'] != null) {
			orderDetails = new List<OrderDetail>();(json['orderDetails'] as List).forEach((v) { orderDetails.add(new OrderDetail.fromJson(v)); });
		}
		createTime = json['createTime'];
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
      data['orderDetails'] =  this.orderDetails.map((v) => v.toJson()).toList();
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
