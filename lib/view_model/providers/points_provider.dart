import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../model/models/points_model.dart';
import '../../model/services/http_service.dart';
import '../../model/utils/service_locator.dart';
import 'Repository/repository_pattern.dart';

class PointsProvider with ChangeNotifier {
  Repository? http = locator<HttpService>();
  PointsModel? _pointsModel;

  bool _pointsMainView = true;

  bool get getPointsMainView => _pointsMainView;

  setPointsMainView(bool value) {
    _pointsMainView = value;
    notifyListeners();
  }

  PointsModel get getPointsModel => _pointsModel!;

  setPointsModel(PointsModel value) {
    _pointsModel = value;
    notifyListeners();
  }

  Future<void> callPointsApi() async {
    try {
      EasyLoading.show(status: 'Please Wait...');
      final response = await http!.pointsApi();
      setPointsModel(response);
      print(_pointsModel);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
