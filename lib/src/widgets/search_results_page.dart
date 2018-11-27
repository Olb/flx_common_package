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
          return _listItem(trainingList[index]);
        },
      ),
    );
  }

  Widget _listItem(Training training) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.network(
            training.featuredImage,
            fit: BoxFit.contain,
            height: 55.0,
            width: 55.0,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  training.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    training.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(height: 4,color: Colors.black,),
      ],
    );
  }
}
