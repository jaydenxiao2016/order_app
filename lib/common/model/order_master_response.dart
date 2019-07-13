import 'package:order_app/common/model/order_master_entity.dart';

///订单主表

class OrderMasterResponse {
  OrderMasterEntity data;

  OrderMasterResponse(
      {this.data,});

  OrderMasterResponse.fromJson(Map<String, dynamic> json) {
    data = json['orderType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;

    return data;
  }
}
