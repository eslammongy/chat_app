import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/helper/constants.dart';
import 'package:fox_chat/model/post_model.dart';
import 'package:fox_chat/model/user_model.dart';
import 'package:fox_chat/module/chat/chat.dart';
import 'package:fox_chat/module/news_feed/news_feed.dart';
import 'package:fox_chat/module/setting/settings.dart';
import 'package:fox_chat/module/users/users.dart';
import 'package:fox_chat/widgets/componant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class BaseUserCubit extends Cubit<BaseUserSatatus> {
  BaseUserCubit() : super(BaseUserInitialStatus());

  static BaseUserCubit get(context) => BlocProvider.of(context);

  UserModel userModel;
  void getUserDate() {
    emit(BaseGetUserLoadingStatus());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(BaseGetUserSuccessStatus());
    }).catchError((error) {
      print(error.toString());
      emit(BaseGetUserErrorsStatus(error: error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screenList = [
    NewsFeedScreen(),
    ChatScreen(),
    UserScreen(),
    SettingScreen()
  ];

  List<String> screenTitle = ["Home", "Chat", "Friends", "Setting"];

  void changeBottomNavScreen(int pageIndex) {
    // if (pageIndex == 2) {
    //   emit(BaseAddNewPostStatus());
    // } else {
    currentIndex = pageIndex;
    emit(BaseChangeBottomBarPageStatus());
    //}
  }

  File profileImage;
  final imagePicker = ImagePicker();

  Future<void> getProfileIamge() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ChangeUserProfileImageStatus());
    } else {
      print("No Image Selected ..");

      showToast(
          message: "No Image Selected ..", toastColor: ToastColor.WARNING);
      emit(ChangeUserProfileImageErrorStatus());
    }
  }

  File coverImage;

  Future<void> getCoverIamge() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(ChangeUserCoverImageStatus());
    } else {
      print("No Image Selected ..");

      showToast(
          message: "No Image Selected ..", toastColor: ToastColor.WARNING);
      emit(ChangeUserProfileImageErrorStatus());
    }
  }

  File postImage;

  Future<void> getPostIamge() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(ChangePostImageSuccessStatus());
    } else {
      print("No Image Selected ..");

      showToast(
          message: "No Image Selected ..", toastColor: ToastColor.WARNING);
      emit(ChangePostImageErrorStatus());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageSuccessStatus());
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) => value.ref.getDownloadURL().then((value) {
              // emit(UploadUserProfileImageSuccessStatus());
              print(value);
              updateUserData(
                  name: name, phone: phone, bio: bio, profileImage: value);
            }).catchError((onError) {
              emit(UploadUserProfileImageErrorStatus());
            }))
        .catchError((onError) {
      emit(UploadUserProfileImageErrorStatus());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) => value.ref.getDownloadURL().then((value) {
              // emit(UploadUserCoverImageSuccessStatus());
              print(value);
              updateUserData(
                  name: name, phone: phone, bio: bio, coverImage: value);
            }).catchError((onError) {
              emit(UploadUserCoverImageErrorStatus());
            }))
        .catchError((onError) {
      emit(UploadUserCoverImageErrorStatus());
    });
  }

  // void updateUserImages({
  //   @required String name,
  //   @required String phone,
  //   @required String bio,
  // }) {
  //   emit(UpdateUserDataLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else {}
  // }

  void updateUserData(
      {@required String name,
      @required String phone,
      @required String bio,
      String profileImage,
      String coverImage}) {
    UserModel user = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        uId: userModel.uId,
        email: userModel.email,
        image: profileImage ?? userModel.image,
        cover: coverImage ?? userModel.cover,
        password: userModel.password,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(user.toMap())
        .then((value) {
      getUserDate();
    }).catchError((onError) {});
  }

  void uploadNewPost({
    @required String text,
    @required String dateTime,
  }) {
    emit(UploadingUserPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) => value.ref.getDownloadURL().then((value) {
              // emit(UploadUserCoverImageSuccessStatus());
              createNewPost(text: text, postImage: value, dateTime: dateTime);
              print(value);
            }).catchError((onError) {
              emit(UploadingUserPostErrorState());
            }))
        .catchError((onError) {
      emit(UploadingUserPostErrorState());
    });
  }

  void createNewPost({
    @required String text,
    String postImage,
    @required String dateTime,
  }) {
    emit(UploadingUserPostLoadingState());

    PostModel postModel = PostModel(
        name: userModel.name,
        uId: userModel.uId,
        postText: text,
        dateTime: dateTime,
        image: userModel.image,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(UploadingUserPostSuccessState());
    }).catchError((onError) {
      emit(UploadingUserPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postID = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postID.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((onError) {});
      });
      emit(GetPostsSuccessState());
    }).catchError((onError) {
      emit(GetPostsErrorState(error: onError.toString()));
    });
  }

  void likedPosts(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true}).then((value) {
      emit(GetLikePostsSuccessState());
    }).catchError((onError) {
      emit(GetLikePostsErrorState(error: onError.toString()));
    });
  }
}
