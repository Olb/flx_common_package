import 'package:flutter/material.dart';
import 'package:flx_common_package/common.dart';

class TrainingPage extends StatelessWidget {
  TrainingPage(this.training);
  final Training training;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text('Training'),
      ),
      body:  Center(
        child:  Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child:  ListView(
            children: <Widget>[
              Container(
                child:  Image.network(
                  training.featuredImage,
                  fit: BoxFit.contain,
                  height: 225.0,
                ),
                margin:  EdgeInsets.only(bottom: 35.0),
              ),
              Center(
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextIconButton(title: "Product Video"),
                    TextIconButton(
                      title: "Instructional Video",
                      onPressed: () {
                        List<dynamic> videos = training.videoList;
                        print(training.videoList);
                        Map<String, dynamic> map = videos.first;
                        Video video =  Video.fromJson(map);
                        print("Video URL ${video.fileUrl}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VideoPage(video.fileUrl)));
                      },
                    ),
                    TextIconButton(
                      title: 'Documents',
                    ),
                    TextIconButton(
                      title: 'Quiz',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
