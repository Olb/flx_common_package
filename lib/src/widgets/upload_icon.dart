import 'package:flutter/material.dart';

class UploadIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadIconState();
  }
}

class UploadIconWidget extends AnimatedWidget {
  UploadIconWidget({Key key, Animation<int> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<int> animation = listenable;
    return IconButton(
      icon: Opacity(
        opacity: animation.value / 255.0,
        child: Icon(
          Icons.cloud_upload,
          color: Colors.green,
        ),
      ),
      onPressed: () {
        Scaffold
            .of(context)
            .showSnackBar(SnackBar(content: Text('Upload in progress...')));
      },
    );
  }
}

class _UploadIconState extends State<UploadIcon>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<int> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1600), vsync: this);
    animation = IntTween(begin: 0, end: 255).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return UploadIconWidget(animation: animation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
