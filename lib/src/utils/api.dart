import 'package:flx_common_package/common.dart';

abstract class Api {
  Future<dynamic> getTraining(User user);
}