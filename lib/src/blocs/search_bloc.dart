import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';
import 'package:flx_common_package/common.dart';

class SearchBloc {
  User user;
  Api api;

  final _loading = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get loading => _loading.distinct();

  final _loadingController = StreamController<bool>();
  Sink<bool> get addLoading => _loadingController.sink;

  final _searchResult = BehaviorSubject<TrainingList>();
  Stream<TrainingList> get searchResult => _searchResult.distinct();

  final _searchController = StreamController<String>();
  Sink<String> get addSearchTerm => _searchController.sink;

  SearchBloc(Api api) {
    this.api = api;
    _loadingController.stream.listen(_handleLoading);
    _searchController.stream.listen(_handleSearch);
  }

  void _handleLoading(bool isLoading) {
    _loading.add(isLoading);
  }

  void _handleSearch(String searchTerm) async {
    addLoading.add(true);
    final products =
    await api.getProducts(user, searchTerm) as TrainingList;
    _searchResult.add(products);
    addLoading.add(false);
  }

  void dispose() {
    _loadingController.close();
    _searchController.close();
  }
}
