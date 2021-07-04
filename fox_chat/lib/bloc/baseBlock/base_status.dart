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

class UploadingUserPostLoadingState extends BaseUserSatatus {}

class UploadingUserPostSuccessState extends BaseUserSatatus {}

class UploadingUserPostErrorState extends BaseUserSatatus {}

class ChangePostImageErrorStatus extends BaseUserSatatus {}

class ChangePostImageSuccessStatus extends BaseUserSatatus {}

class RemovePostImageSuccessStatus extends BaseUserSatatus {}

class GetPostsLoadingState extends BaseUserSatatus {}

class GetPostsSuccessState extends BaseUserSatatus {}

class GetPostsErrorState extends BaseUserSatatus {
  final String error;
  GetPostsErrorState({this.error});
}

class GetLikePostsSuccessState extends BaseUserSatatus {}

class GetLikePostsErrorState extends BaseUserSatatus {
  final String error;
  GetLikePostsErrorState({this.error});
}
