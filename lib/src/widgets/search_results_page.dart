import 'package:flutter/material.dart';
import 'package:flx_common_package/common.dart';

class SearchResultsPage extends StatelessWidget {
  final User user;
  final Api api;
  final String searchTerm;
  SearchResultsPage(this.user, this.api, this.searchTerm);


  @override
  Widget build(BuildContext context) {

    final trainingBloc = TrainingBloc(user, api);
    trainingBloc.getProducts(searchTerm);

    return TrainingProvider(
      vizualProofBloc: trainingBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Results'),
        ),
        body: StreamBuilder<TrainingList>(
          stream: trainingBloc.products,
          initialData: null,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              print('Training count: ${snapshot.data.trainingList}');
              if (snapshot.data.trainingList.length == 0) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No training available at this time',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                );
              }
              return new ListView.builder(
                itemCount: snapshot.data == null
                    ? 0
                    : snapshot.data.trainingList.length,
                itemBuilder: (itemBuilderCtx, index) {
                  return new ListTile(
                    title: new Text(snapshot.data.trainingList[index].name),
                    subtitle:
                    new Text(snapshot.data.trainingList[index].description),
                    onTap: () {
                      Training training = snapshot.data.trainingList[index];
                      if (training.instructionVideos.isEmpty && training.productVideos.isEmpty) {
                        Scaffold.of(itemBuilderCtx).showSnackBar(SnackBar(
                          content: Text('There are no videos for this item'),
                          duration: Duration(milliseconds: 750),
                        ));
                        return;
                      }
                      // Go straight to video if there is only one for the training
                      // either product or instruction
                      if (training.productVideos.isEmpty && training.instructionVideos.length == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    VideoPage(training.instructionVideos.first
                                        .fileUrl)));
                      } else if (training.instructionVideos.isEmpty && training.productVideos.length== 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    VideoPage(training.productVideos.first.fileUrl)));
                      } else {
                        // multiple videos
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    TrainingPage(training)));
                      }
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return Center(child: new CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
