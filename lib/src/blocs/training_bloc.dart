import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';
import 'package:flx_common_package/common.dart';

class TrainingBloc {
  
  User user;
  Api api;

  final _training = BehaviorSubject<SimpleTrainingList>();
  Stream<SimpleTrainingList> get training => _training.distinct();

  final _trainingController = StreamController<SimpleTrainingList>();
  Sink<SimpleTrainingList> get addTraining => _trainingController.sink;

  final _products = BehaviorSubject<TrainingList>();
  Stream<TrainingList> get products => products.distinct();

  final _productsController = StreamController<TrainingList>();
  Sink<TrainingList> get addProducts => _productsController.sink;

  TrainingBloc(User user, Api api) {
    this.user = user;
    this.api = api;
    _trainingController.stream.listen(_handleTraining);
    _productsController.stream.listen(_handleProducts);
    // Grab the training for 'SimpleTrainingList' given no search term
    _getTraining();
  }

  /// Gets a list of training with only a single video
  void _handleTraining(SimpleTrainingList trainingList) {
    _training.add(trainingList);
  }


  void _handleProducts(TrainingList trainingList) {
    _products.add(trainingList);
  }

  /// Returns a list of simple training(one video)
  void _getTraining() async {
    final training =  await api.getTraining(user);
    if (training != null && training.runtimeType == SimpleTrainingList) {
      addTraining.add(training);
    }
  }

  /// Returns a list of products or training given a search term
  ///
  /// `searchTerm` String
  void getProducts(String searchTerm) async {
    final products =  await api.getProducts(user, searchTerm);
    if (products != null && products.runtimeType == TrainingList) {
      addProducts.add(products);
    }
  }

  void dispose() {
    _trainingController.close();
    _productsController.close();
  }
}