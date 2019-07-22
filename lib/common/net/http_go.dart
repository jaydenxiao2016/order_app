import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/common/config/config.dart';
import 'package:order_app/common/net/base_result.dart';

///dio网络请求工具
class HttpGo {
  static final String GET = "get";
  static final String POST = "post";
  static final String DATA = "data";
  static final String CODE = "errorCode";

  String _codeKey = "code";
  String _msgKey = "msg";
  String _dataKey = "extend";

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
      baseUrl: Config.BASE_URL,
      headers: {'platform': 'android', 'version': 11.0},
      connectTimeout: 5000,
      receiveTimeout: 100000,
    ));
  }

  //get请求
  Future<BaseResult> get(String url,
      {params, Map<String, dynamic> header,CancelToken cancelToken}) async {
    Options options = new Options(method: "GET");
    return netFetch(url, params, header, options);
  }

  //post请求
  Future<BaseResult> post(String url,
      {params, Map<String, dynamic> header, loading = true,CancelToken cancelToken}) async {
    Options options = new Options(method: "POST");
    return netFetch(url, params, header, options, loading: loading,cancelToken: cancelToken);
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  Future<BaseResult> netFetch(
      url, params, Map<String, dynamic> header, Options option,
      {loading = true,CancelToken cancelToken}) async {
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
    int _code;
    String _msg;
    var _data;
    print("api参数：");
    print(params.toString());
    Response response;
    try {
      response = await dio.request(url, data: params, options: option,cancelToken: cancelToken);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('Request canceled! '+ e.message);
      }else{
        print("api请求报错：");
        print(e);
        return new Future.error("api请求失败");
      }
    }
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        ///api返回
        print("api返回：---------------------begin");
        print(response);
        print("api返回：-----------------------end");
        if (response.data is Map) {
          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }

        ///接口数据成功
        if (_code == 100) {
          return new BaseResult(_data, _msg, _code);
        }
        ///接口数据失败
        else {
          return new Future.error(_code==101?_code:_msg);
        }
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "data parsing exception...");
        return new Future.error(_msg);
      }
    }
    return new Future.error("statusCode: $response.statusCode, service error");
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}
