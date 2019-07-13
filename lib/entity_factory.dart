import 'package:order_app/common/model/category_response_entity.dart';
import 'package:order_app/common/model/login_response_entity.dart';
import 'package:order_app/common/model/order_master_entity.dart';
import 'package:order_app/common/model/product_response_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "CategoryResponseEntity") {
      return CategoryResponseEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginResponseEntity") {
      return LoginResponseEntity.fromJson(json) as T;
    } else if (T.toString() == "OrderDetailEntity") {
      return OrderDetail.fromJson(json) as T;
    } else if (T.toString() == "OrderMasterEntity") {
      return OrderMasterEntity.fromJson(json) as T;
    } else if (T.toString() == "ProductResponseEntity") {
      return ProductResponseEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
