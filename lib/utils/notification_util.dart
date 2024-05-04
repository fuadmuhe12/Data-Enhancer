import 'package:flutter/material.dart';

class LogData extends ChangeNotifier{
  List<Map>   _data = [];

  void addData(Map data){
    _data.add(data);
    notifyListeners();
  }

  void clearData(){
    _data.clear();
    notifyListeners();
  }

  List<Map> getData(){
    return _data;
  }
}

LogData logData = LogData();