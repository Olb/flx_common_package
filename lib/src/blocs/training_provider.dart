import 'package:flutter/widgets.dart';
import 'package:flx_common_package/common.dart';

class TrainingProvider extends InheritedWidget {
  final TrainingBloc vizualProofBloc;
  final Api api;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TrainingBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(TrainingProvider)
              as TrainingProvider)
          .vizualProofBloc;

  TrainingProvider(
      {Key key, TrainingBloc vizualProofBloc, Api api, Widget child})
      : this.vizualProofBloc =
            vizualProofBloc ?? TrainingBloc(User.loggedOut(), api),
        this.api = api,
        super(child: child, key: key);
}
