import 'package:order_app/common/model/product.dart';

class ProductResponseEntity {
	ProductInfoData data;
	String imgPath;

	ProductResponseEntity({this.data, this.imgPath});

	ProductResponseEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new ProductInfoData.fromJson(json['data']) : null;
		imgPath = json['imgPath'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['imgPath'] = this.imgPath;
		return data;
	}
}

class ProductInfoData {
	int startRow;
	List<int> navigatepageNums;
	int prePage;
	bool hasNextPage;
	int nextPage;
	int pageSize;
	int endRow;
	List<Product> list;
	int pageNum;
	int navigatePages;
	int total;
	int navigateFirstPage;
	int pages;
	int size;
	bool isLastPage;
	bool hasPreviousPage;
	int navigateLastPage;
	bool isFirstPage;

	ProductInfoData({this.startRow, this.navigatepageNums, this.prePage, this.hasNextPage, this.nextPage, this.pageSize, this.endRow, this.list, this.pageNum, this.navigatePages, this.total, this.navigateFirstPage, this.pages, this.size, this.isLastPage, this.hasPreviousPage, this.navigateLastPage, this.isFirstPage});

	ProductInfoData.fromJson(Map<String, dynamic> json) {
		startRow = json['startRow'];
		navigatepageNums = json['navigatepageNums']?.cast<int>();
		prePage = json['prePage'];
		hasNextPage = json['hasNextPage'];
		nextPage = json['nextPage'];
		pageSize = json['pageSize'];
		endRow = json['endRow'];
		if (json['list'] != null) {
			list = new List<Product>();(json['list'] as List).forEach((v) { list.add(new Product.fromJson(v)); });
		}
		pageNum = json['pageNum'];
		navigatePages = json['navigatePages'];
		total = json['total'];
		navigateFirstPage = json['navigateFirstPage'];
		pages = json['pages'];
		size = json['size'];
		isLastPage = json['isLastPage'];
		hasPreviousPage = json['hasPreviousPage'];
		navigateLastPage = json['navigateLastPage'];
		isFirstPage = json['isFirstPage'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['startRow'] = this.startRow;
		data['navigatepageNums'] = this.navigatepageNums;
		data['prePage'] = this.prePage;
		data['hasNextPage'] = this.hasNextPage;
		data['nextPage'] = this.nextPage;
		data['pageSize'] = this.pageSize;
		data['endRow'] = this.endRow;
		if (this.list != null) {
      data['list'] =  this.list.map((v) => v.toJson()).toList();
    }
		data['pageNum'] = this.pageNum;
		data['navigatePages'] = this.navigatePages;
		data['total'] = this.total;
		data['navigateFirstPage'] = this.navigateFirstPage;
		data['pages'] = this.pages;
		data['size'] = this.size;
		data['isLastPage'] = this.isLastPage;
		data['hasPreviousPage'] = this.hasPreviousPage;
		data['navigateLastPage'] = this.navigateLastPage;
		data['isFirstPage'] = this.isFirstPage;
		return data;
	}
}
