import 'package:flutter/material.dart';
import 'package:fox_chat/style/icon_broken.dart';

class AddNewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconBroken.Arrow___Left_Circle),
        ),
        title: Text("Create New Post"),
        centerTitle: true,
      ),
    );
  }
}
