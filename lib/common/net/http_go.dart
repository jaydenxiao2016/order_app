import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:order_app/common/net/code.dart';
import 'package:order_app/common/net/result_data.dart';

///dio网络请求工具
class HttpGo {
  static final String BASE_URL = "http://192.168.5.6:8085";
  static final String GET = "get";
  static final String POST = "post";
  static final String DATA = "data";
  static final String CODE = "errorCode";

  static Dio dio;
  static HttpGo _instance;

  static HttpGo getInstance() {
    if (_instance == null) {
      _instance = HttpGo();
    }
    return _instance;
  }

  HttpGo() {
    dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: {'platform': 'android', 'version': 11.0},
      connectTimeout: 5000,
      receiveTimeout: 100000,
    ));
  }

  //get请求
  Future<ResultData> get(String url,
      {params, Map<String, dynamic> header}) async {
    Options options = new Options(method: "GET");
    return netFetch(url, params, header, options);
  }

  //post请求
  Future<ResultData> post(String url,
      {params, Map<String, dynamic> header}) async {
    Options options = new Options(method: "POST");
    return netFetch(url, params, header, options);
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  Future<ResultData> netFetch(
      url, params, Map<String, dynamic> header, Options option,
      {noTip = false}) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "GET");
      option.headers = headers;
    }
    resultError(DioError e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return ResultData(response.data, true, response.statusCode);
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}
