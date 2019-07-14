import 'package:order_app/common/model/order_detail.dart';

///服务订单
class OrderServiceDetailEntity {
	int orderId;
	List<OrderDetail> needServiceDetails;

	OrderServiceDetailEntity({this.orderId, this.needServiceDetails});

	OrderServiceDetailEntity.fromJson(Map<String, dynamic> json) {
		orderId = json['orderId'];
		if (json['needServiceDetails'] != null) {
			needServiceDetails = new List<OrderDetail>();(json['needServiceDetails'] as List).forEach((v) { needServiceDetails.add(new OrderDetail.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['orderId'] = this.orderId;
		if (this.needServiceDetails != null) {
      data['needServiceDetails'] =  this.needServiceDetails.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

