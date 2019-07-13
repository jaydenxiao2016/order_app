import 'package:order_app/common/model/login_response_entity.dart';
import 'package:redux/redux.dart';

// ignore: non_constant_identifier_names
final LoginInfoEntityReducer = combineReducers<LoginResponseEntity>([
  TypedReducer<LoginResponseEntity, RefreshLoginInfoAction>(_refresh),
]);

LoginResponseEntity _refresh(
    LoginResponseEntity loginInfoEntity, RefreshLoginInfoAction action) {
  loginInfoEntity = action.loginInfoEntity;
  return loginInfoEntity;
}

class RefreshLoginInfoAction {
  final LoginResponseEntity loginInfoEntity;

  RefreshLoginInfoAction(this.loginInfoEntity);
}
