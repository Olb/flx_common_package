import 'package:flutter/material.dart';
import 'package:flx_common_package/common.dart';

class TrainingListPage extends StatelessWidget {
  final User user;
  final Api api;
  TrainingListPage(this.user, this.api);

  @override
  Widget build(BuildContext context) {
    final trainingBloc = TrainingBloc(user, api);

    return TrainingProvider(
      vizualProofBloc: trainingBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Training List'),
        ),
        body: StreamBuilder<TrainingList>(
          stream: trainingBloc.trainingList,
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
                      if (training.videoList.length == 0) {
                        Scaffold.of(itemBuilderCtx).showSnackBar(SnackBar(
                          content: Text('There is no video for this training'),
                          duration: Duration(milliseconds: 750),
                        ));
                        return;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  VideoPage(training.videoList.first.fileUrl)));
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
