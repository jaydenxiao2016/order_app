import 'package:order_app/common/model/ServiceSetting.dart';
import 'package:redux/redux.dart';

// ignore: non_constant_identifier_names
final ServiceControlReducer = combineReducers<ServiceSetting>([
  TypedReducer<ServiceSetting, RefreshServiceControlAction>(_refresh),
]);

ServiceSetting _refresh(
    ServiceSetting serviceSetting, RefreshServiceControlAction action) {
  serviceSetting = action.serviceSetting;
  return serviceSetting;
}

class RefreshServiceControlAction {
  final ServiceSetting serviceSetting;

  RefreshServiceControlAction(this.serviceSetting);
}
