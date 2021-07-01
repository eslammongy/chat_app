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

class ChangeUserProfileImageStatus extends BaseUserSatatus {}

class ChangeUserProfileImageErrorStatus extends BaseUserSatatus {}

class ChangeUserCoverImageStatus extends BaseUserSatatus {}

class UploadUserProfileImageSuccessStatus extends BaseUserSatatus {}

class UploadUserProfileImageErrorStatus extends BaseUserSatatus {}

class UploadUserCoverImageSuccessStatus extends BaseUserSatatus {}

class UploadUserCoverImageErrorStatus extends BaseUserSatatus {}

class UpdateUserDataErrorState extends BaseUserSatatus {}

class UpdateUserDataLoadingState extends BaseUserSatatus {}
