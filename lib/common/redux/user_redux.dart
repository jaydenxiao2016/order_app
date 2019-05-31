import 'package:order_app/common/model/user.dart';
import 'package:order_app/common/redux/state_info.dart';
import 'package:redux/redux.dart';

/// redux 的 combineReducers, 通过 TypedReducer 将 UpdateUserAction 与 reducers 关联起来
// ignore: non_constant_identifier_names
final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateUser),
]);

/// 如果有 UpdateUserAction 发起一个请求时
/// 就会调用到 _updateUser
/// _updateUser 这里接受一个新的userInfo，并返回
User _updateUser(User user, action) {
  user = action.userInfo;
  return user;
}

///定一个 UpdateUserAction ，用于发起 userInfo 的的改变
///类名随你喜欢定义，只要通过上面TypedReducer绑定就好
class UpdateUserAction {
  final User userInfo;

  UpdateUserAction(this.userInfo);
}

class FetchUserAction {}

///中间件
class UserInfoMiddleware implements MiddlewareClass<StateInfo> {
  @override
  void call(Store<StateInfo> store, dynamic action, NextDispatcher next) {
    if (action is UpdateUserAction) {
      print("*********** UserInfoMiddleware *********** ");
    }
    // Make sure to forward actions to the next middleware in the chain!
    next(action);
  }
}
