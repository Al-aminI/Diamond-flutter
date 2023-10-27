import 'package:flutter/foundation.dart';
import 'package:diamond/modules/diamond_data.dart';

class DiamondDataProvider with ChangeNotifier {
  DiamondData? _diamondData;

  DiamondData? get diamondData => _diamondData;

  void setDiamondData(DiamondData data) {
    _diamondData = data;
    notifyListeners();
  }

  void updateSingleDiamond(bool dia1) {
    if (_diamondData != null) {
      _diamondData!.dia1 = dia1;
      notifyListeners();
    }
  }
}
