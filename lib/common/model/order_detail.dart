import 'package:order_app/common/model/product.dart';

///	订单明细
class OrderDetail {
	int productId;
	int orderId;
	int detailId;
	int pageSize;
	int updateTime;
	int productNumber;
	String searchKey;
	String categoryName;
	int pageNum;
	String productName;
	String detailType;
	int createTime;
	int roundId;
	int categoryId;
	double productPrice;
	Product product=new Product();

	OrderDetail({this.productId, this.orderId, this.detailId, this.pageSize, this.updateTime, this.productNumber, this.searchKey, this.categoryName, this.pageNum, this.productName, this.detailType, this.createTime, this.roundId, this.categoryId, this.productPrice,this.product});

	OrderDetail.fromJson(Map<String, dynamic> json) {
		productId = json['productId'];
		orderId = json['orderId'];
		detailId = json['detailId'];
		pageSize = json['pageSize'];
		updateTime = json['updateTime'];
		productNumber = json['productNumber'];
		searchKey = json['searchKey'];
		categoryName = json['categoryName'];
		pageNum = json['pageNum'];
		productName = json['productName'];
		detailType = json['detailType'];
		createTime = json['createTime'];
		roundId = json['roundId'];
		categoryId = json['categoryId'];
		productPrice = json['productPrice'];
		product = Product.fromJson(json['product']);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['productId'] = this.productId;
		data['orderId'] = this.orderId;
		data['detailId'] = this.detailId;
		data['pageSize'] = this.pageSize;
		data['updateTime'] = this.updateTime;
		data['productNumber'] = this.productNumber;
		data['searchKey'] = this.searchKey;
		data['categoryName'] = this.categoryName;
		data['pageNum'] = this.pageNum;
		data['productName'] = this.productName;
		data['detailType'] = this.detailType;
		data['createTime'] = this.createTime;
		data['roundId'] = this.roundId;
		data['categoryId'] = this.categoryId;
		data['productPrice'] = this.productPrice;
		data['product'] = this.product.toJson();
		return data;
	}
}
