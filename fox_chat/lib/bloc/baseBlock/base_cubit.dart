import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/helper/constants.dart';
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

  String profileImageUrl = '';
  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) => value.ref.getDownloadURL().then((value) {
              profileImageUrl = value;
              emit(UploadUserProfileImageSuccessStatus());
              print(value);
            }).catchError((onError) {
              emit(UploadUserProfileImageErrorStatus());
            }))
        .catchError((onError) {
      emit(UploadUserProfileImageErrorStatus());
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) => value.ref.getDownloadURL().then((value) {
              coverImageUrl = value;
              emit(UploadUserCoverImageSuccessStatus());
              print(value);
            }).catchError((onError) {
              emit(UploadUserCoverImageErrorStatus());
            }))
        .catchError((onError) {
      emit(UploadUserCoverImageErrorStatus());
    });
  }

  void updateUserImages({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(UpdateUserDataLoadingState());
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else {}
  }

  void updateUserData({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    UserModel user = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        uId: userModel.uId,
        email: userModel.email,
        image: userModel.image,
        cover: userModel.cover,
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
}
