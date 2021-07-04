import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/model/post_model.dart';
import 'package:fox_chat/style/icon_broken.dart';
import 'package:fox_chat/widgets/componant.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';

class NewsFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseUserCubit, BaseUserSatatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: BaseUserCubit.get(context).posts.length > 0 &&
                BaseUserCubit.get(context).userModel != null,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(6),
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: HexColor("2A3B90"),
                      elevation: 10,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image: NetworkImage(
                                    "https://emirateswoman.com/wp-content/uploads/2019/04/mo-salah.jpg"),
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Make Your NetWork",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostCard(
                        BaseUserCubit.get(context).posts[index],
                        context,
                        index),
                    itemCount: BaseUserCubit.get(context).posts.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                  )
                ],
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget buildPostCard(PostModel postModel, BuildContext context, index) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: HexColor("2A6B90"),
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage("${postModel.image}"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${postModel.name}",
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
                      ),
                      Text(
                        "${postModel.dateTime}",
                        style: TextStyle(
                            fontSize: 10,
                            height: 1.3,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300]),
                      ),
                    ],
                  )),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "${postModel.postText}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[200]),
                ),
                //alignment: AlignmentGeometry.lerp(a, b, t),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 5),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5),
                        child: Container(
                          child: MaterialButton(
                              padding: EdgeInsets.zero,
                              minWidth: 1.0,
                              height: 20,
                              onPressed: () {},
                              child: Text(
                                "#software",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.indigo[900]),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (postModel.postImage != '')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 140,
                      image: NetworkImage("${postModel.postImage}"),
                    ),
                  ),
                ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    child: Icon(
                      IconBroken.Heart,
                      color: Colors.amber,
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${BaseUserCubit.get(context).likes[index]}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    child: Icon(
                      IconBroken.Chat,
                      color: Colors.amber,
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "120",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ]),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                        "${BaseUserCubit.get(context).userModel.image}"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "write a comment ...",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            child: Icon(
                              IconBroken.Heart,
                              color: Colors.amber,
                            ),
                            onTap: () {
                              BaseUserCubit.get(context).likedPosts(
                                  BaseUserCubit.get(context).postID[index]);
                            },
                          ),
                        ),
                        Text(
                          "like",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}
