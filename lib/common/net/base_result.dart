/**
 * 网络结果数据
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class BaseResult {
  var data;
  int code;
  String msg;

  BaseResult(this.data, this.msg, this.code);

  @override
  String toString() {
    return 'BaseResult{data: $data, code: $code, msg: $msg}';
  }
}
