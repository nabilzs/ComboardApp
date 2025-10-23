import 'package:flutter/material.dart';
import 'package:belajar_flutter/services/comboard_service.dart';

class ComboardController extends ChangeNotifier {
  final ComboardService _service = ComboardService();

  List<dynamic> comboardData = [];
  bool isLoading = false;
  int _displayLimit = 10;

  int get displayLimit => _displayLimit;

  List<dynamic> get limitedData {
    if (_displayLimit == 0 || _displayLimit >= comboardData.length) {
      return comboardData;
    }
    return comboardData.sublist(0, _displayLimit);
  }

  void setDisplayLimit(int limit) {
    _displayLimit = limit;
    notifyListeners();
  }

  Future<void> loadAllComboard() async {
    isLoading = true;
    notifyListeners();

    int skip = 0;
    bool hasMore = true;
    List<dynamic> allData = [];

    while (hasMore) {
      final data = await _service.fetchComboard(skip: skip);
      if (data.isEmpty) {
        hasMore = false;
      } else {
        allData.addAll(data);
        skip += data.length;
      }
    }

    comboardData = allData;
    isLoading = false;
    notifyListeners();
  }
}
