import 'dart:html';

abstract class BaseUserSatatus {}

class BaseUserInitialStatus extends BaseUserSatatus {}

class BaseGetUserSuccessStatus extends BaseUserSatatus {}

class BaseGetUserErrorsStatus extends BaseUserSatatus {
  final String error;
  BaseGetUserErrorsStatus({this.error});
}
