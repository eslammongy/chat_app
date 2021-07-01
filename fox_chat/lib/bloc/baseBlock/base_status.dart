abstract class BaseUserSatatus {}

class BaseUserInitialStatus extends BaseUserSatatus {}

class BaseGetUserSuccessStatus extends BaseUserSatatus {}

class BaseGetUserLoadingStatus extends BaseUserSatatus {}

class BaseGetUserErrorsStatus extends BaseUserSatatus {
  final String error;
  BaseGetUserErrorsStatus({this.error});
}

class BaseChangeBottomBarPageStatus extends BaseUserSatatus {}

class BaseAddNewPostStatus extends BaseUserSatatus {}
