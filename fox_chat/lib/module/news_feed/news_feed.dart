import 'package:flutter/material.dart';
import 'package:fox_chat/style/icon_broken.dart';
import 'package:fox_chat/widgets/componant.dart';
import 'package:hexcolor/hexcolor.dart';

class NewsFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              child:
                  Stack(alignment: AlignmentDirectional.bottomEnd, children: [
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
                    "Mo Salah",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ]),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostCard(),
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(
              height: 8,
            ),
          )
        ],
      ),
    );
  }

  Widget buildPostCard() {
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
                    radius: 35.0,
                    backgroundImage: NetworkImage(
                        "https://emirateswoman.com/wp-content/uploads/2019/04/mo-salah.jpg"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Mo Salah",
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
                        "Jan 26 , 20 at 11:00 pm",
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
                height: 5,
              ),
              Container(
                child: Text(
                  "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  style: TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[200]),
                ),
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.indigo[900]),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: HexColor("2A6B90"),
                elevation: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 140,
                    image: NetworkImage(
                        "https://emirateswoman.com/wp-content/uploads/2019/04/mo-salah.jpg"),
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
                  "120",
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
                        "https://emirateswoman.com/wp-content/uploads/2019/04/mo-salah.jpg"),
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
                            onTap: () {},
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
