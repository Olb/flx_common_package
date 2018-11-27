import 'package:flutter/material.dart';
import 'package:flx_common_package/common.dart';

class SearchResultsPage extends StatelessWidget {
  final User user;
  final Api api;
  final List<Training> trainingList;
  SearchResultsPage(this.user, this.api, this.trainingList);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: ListView.builder(
        itemCount: trainingList.length,
        itemBuilder: (itemBuilderCtx, index) {
          return new ListTile(
            leading: Image.network(trainingList[index].featuredImage),
            title: new Text(trainingList[index].name),
            subtitle:
            new Text(trainingList[index].description),
            onTap: () {
              Training training = trainingList[index];
              // Go straight to video if there is only one for the training
              // either product or instruction
              // TODO Figure out how to check for only one of everything
              // TODO without using a massive if/else hell
              // Use MVVM/MVP and generify the list of stuff going to
              // product page, then use list.length to check for one
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          TrainingPage(training)));
            },
          );
        },
      ),
    );
  }
}
