import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/style/icon_broken.dart';
import 'package:fox_chat/widgets/componant.dart';
import 'package:fox_chat/widgets/text_input_field.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class EditUserProfile extends StatelessWidget {
  var editNameController = TextEditingController();
  var editBioController = TextEditingController();
  var editPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseUserCubit, BaseUserSatatus>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = BaseUserCubit.get(context).userModel;
          var profileImage = BaseUserCubit.get(context).profileImage;
          var coverImage = BaseUserCubit.get(context).coverImage;

          editNameController.text = userModel.name;
          editBioController.text = userModel.bio;
          editPhoneController.text = userModel.phone;
          return Scaffold(
              backgroundColor: HexColor("2A3B90"),
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_Circle),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      BaseUserCubit.get(context).updateUserData(
                          name: editNameController.text,
                          phone: editPhoneController.text,
                          bio: editBioController.text);
                    },
                    icon: Icon(Icons.done_all),
                  ),
                ],
                title: Text(
                  "Profile Editing",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                backgroundColor: HexColor("2A3B90"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    if (state is UpdateUserDataLoadingState)
                      LinearProgressIndicator(),
                    if (state is UpdateUserDataLoadingState)
                      SizedBox(
                        height: 5,
                      ),
                    Container(
                      height: 190,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(
                                      height: 150.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: coverImage == null
                                              ? NetworkImage(
                                                  '${userModel.cover}',
                                                )
                                              : FileImage(coverImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        BaseUserCubit.get(context)
                                            .getCoverIamge();
                                      },
                                      icon: CircleAvatar(
                                          backgroundColor: HexColor("2A7B90"),
                                          radius: 30,
                                          child: Icon(
                                            IconBroken.Camera,
                                            size: 20,
                                          )),
                                    ),
                                  ]),
                              alignment: AlignmentDirectional.topCenter,
                            ),
                            Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 68.0,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                        radius: 65.0,
                                        backgroundImage: profileImage == null
                                            ? NetworkImage("${userModel.image}")
                                            : FileImage(profileImage)),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BaseUserCubit.get(context)
                                          .getProfileIamge();
                                    },
                                    icon: CircleAvatar(
                                        backgroundColor: HexColor("2A7B90"),
                                        radius: 30,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 20,
                                        )),
                                  ),
                                ]),
                          ]),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        if (BaseUserCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: TextButton(
                                      onPressed: () {
                                        BaseUserCubit.get(context)
                                            .uploadProfileImage(
                                                name: editNameController.text,
                                                phone: editPhoneController.text,
                                                bio: editBioController.text);
                                      },
                                      child: Text(
                                        "Update Profile Image",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if (state is UpdateUserDataLoadingState)
                                  LinearProgressIndicator()
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (BaseUserCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: TextButton(
                                      onPressed: () {
                                        BaseUserCubit.get(context)
                                            .uploadCoverImage(
                                                name: editNameController.text,
                                                phone: editPhoneController.text,
                                                bio: editBioController.text);
                                      },
                                      child: Text(
                                        "Update Cover Image",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if (state is UpdateUserDataLoadingState)
                                  LinearProgressIndicator()
                              ],
                            ),
                          )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    textInputField(
                        controller: editNameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Name Must Not Be Empty";
                          }
                        },
                        label: 'Name',
                        prefix: IconBroken.User),
                    SizedBox(
                      height: 15,
                    ),
                    textInputField(
                        controller: editPhoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Phone Must Not Be Empty";
                          }
                        },
                        label: 'Phone',
                        prefix: IconBroken.Call),
                    SizedBox(
                      height: 15,
                    ),
                    textInputField(
                        size: 150.0,
                        controller: editBioController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Bio Must Not Be Empty";
                          }
                        },
                        label: 'Bio',
                        prefix: IconBroken.Info_Circle)
                  ]),
                ),
              ));
        });
  }
}
