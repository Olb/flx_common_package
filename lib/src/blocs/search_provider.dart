import 'package:flutter/widgets.dart';
import 'search_bloc.dart';
import 'package:flx_common_package/common.dart';

class SearchProvider extends InheritedWidget {
  final SearchBloc searchBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SearchBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SearchProvider)
      as SearchProvider)
          .searchBloc;

  SearchProvider(
      {Key key, SearchBloc searchBloc, Api api, Widget child})
      : this.searchBloc =
      searchBloc ?? SearchBloc(api),
        super(child: child, key: key);
}
