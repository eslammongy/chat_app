import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/style/icon_broken.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseUserCubit, BaseUserSatatus>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = BaseUserCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 150.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${userModel.cover}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 68.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 65.0,
                          backgroundImage: NetworkImage("${userModel.image}"),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${userModel.name}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: "RobotoCondensed",
                    height: 1.3,
                    color: Colors.white),
              ),
              Text(
                "bio ....",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "Posts",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "RobotoCondensed",
                                  height: 1.3,
                                  color: Colors.white),
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "RobotoCondensed",
                                  height: 1.3,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "Following",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "RobotoCondensed",
                                  height: 1.3,
                                  color: Colors.white),
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "RobotoCondensed",
                                  height: 1.3,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "Followers",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "RobotoCondensed",
                                  height: 1.3,
                                  color: Colors.white),
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "RobotoCondensed",
                                  height: 1.3,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "About",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "RobotoCondensed",
                                  height: 1.3,
                                  color: Colors.white),
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "RobotoCondensed",
                                  height: 1.3,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: MaterialButton(
                          color: Colors.red,
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minWidth: 1.0,
                          height: 40,
                          onPressed: () {},
                          child: Text(
                            "Add Photo",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: "RobotoCondensed",
                                color: Colors.white),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {},
                      child: Icon(
                        IconBroken.Edit,
                        color: Colors.red,
                      ))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
