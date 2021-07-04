import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/style/icon_broken.dart';
import 'package:hexcolor/hexcolor.dart';

class AddNewPostScreen extends StatelessWidget {
  var postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseUserCubit, BaseUserSatatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: HexColor("2A3B90"),
          appBar: AppBar(
            backgroundColor: HexColor("2A3B90"),
            actions: [
              TextButton(
                  onPressed: () {
                    var currentDateTime = DateTime.now();
                    if (BaseUserCubit.get(context).postImage == null) {
                      BaseUserCubit.get(context).createNewPost(
                          text: postTextController.text,
                          dateTime: currentDateTime.toString());
                    } else {
                      BaseUserCubit.get(context).uploadNewPost(
                          text: postTextController.text,
                          dateTime: currentDateTime.toString());
                    }
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_Circle),
            ),
            title: Text("Create Post"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is UploadingUserPostLoadingState)
                  LinearProgressIndicator(),
                if (state is UploadingUserPostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: NetworkImage(
                          "${BaseUserCubit.get(context).userModel.image}"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Text(
                          "${BaseUserCubit.get(context).userModel.name}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue[300],
                          size: 18.0,
                        ),
                      ],
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postTextController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "what is on your mind ..",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                if (BaseUserCubit.get(context).postImage != null)
                  Container(
                    height: 300,
                    child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            child: Container(
                              height: 300.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(
                                    BaseUserCubit.get(context).postImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                BaseUserCubit.get(context).removePostImage();
                              },
                              icon: Icon(
                                IconBroken.Close_Square,
                                color: Colors.red,
                                size: 35,
                              ))
                        ]),
                  ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            BaseUserCubit.get(context).getPostIamge();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "add photo",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "# add tag",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
