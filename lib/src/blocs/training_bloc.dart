import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';
import 'package:flx_common_package/common.dart';

class TrainingBloc {
  
  User user;
  Api api;

  final _trainingList = BehaviorSubject<TrainingList>();
  Stream<TrainingList> get trainingList => _trainingList.distinct();

  final _trainingListController = StreamController<TrainingList>();
  Sink<TrainingList> get addTraining => _trainingListController.sink;

  TrainingBloc(User user, Api api) {
    this.user = user;
    this.api = api;
    _trainingListController.stream.listen(_handleTraining);
    _getTraining();
  }

  void _handleTraining(TrainingList trainingList) {
    _trainingList.add(trainingList);
  }

  void _getTraining() async {

    final training =  await api.getTraining(user);
    if (training != null && training.runtimeType == TrainingList) {
      addTraining.add(training);
    }
  }

  // Call dispose on pop or move to main bloc everything and add call for pulling training
  void dispose() {
    _trainingListController.close();
  }
}