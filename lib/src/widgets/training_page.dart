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
                    TextIconButton(title: "Product Video",
                    onPressed: () {
                      // TODO Refactor the heck out of this
                      print(training.productVideos.first);

                      print("Video URL ${training.productVideos.first.fileUrl}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VideoPage(training.productVideos.first.fileUrl)));

                    },),
                    TextIconButton(
                      title: "Instructional Video",
                      onPressed: () {
                        print("Video URL ${training.instructionVideos.first.fileUrl}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VideoPage(training.instructionVideos.first.fileUrl)));
                      },
                    ),
                    TextIconButton(
                      title: 'Documents',
                      onPressed: () {
                        print('Documents: ${training.documents.first}');
                      },
                    ),
                    TextIconButton(
                      title: 'Coupons',
                      onPressed: () {
                        print('Coupons: ${training.coupons.first}');
                      },
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
