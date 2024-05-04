// implement the provider

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isMonitoring = true;
  int _monitoringInterval = 15;
  double _minmumDataThreshold = 1;

  bool get isMonitoring => _isMonitoring;
  int get monitoringInterval => _monitoringInterval;
  double get minmumDataThreshold => _minmumDataThreshold;
  void toggleMonitoring() {
    _isMonitoring = !_isMonitoring;
    notifyListeners();
  }

  void setMonitoringInterval(int value) {
    _monitoringInterval = value;
    notifyListeners();
  }

  void setMinmumDataThreshold(double value) {
    _minmumDataThreshold = value;
    notifyListeners();
  }
}

// data weather mobile data is on or off

class DataConnection {
  bool _isDataOn = false;

  bool get isDataOn => _isDataOn;

  void setDataOn(bool value) {
    _isDataOn = value;
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }
}

var dataConnection = DataConnection();
