// check weather the phone data is on or off

import 'package:data_enhencer/logger.dart';
import 'package:data_enhencer/settings_screen.dart';
import 'package:data_enhencer/utils/notification_util.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> checkMobileData() async {
  var status = await dataConnection.checkConnection();
  return status;
}

Future<bool> checkInternetConnection() async {
  var status = await InternetConnectionChecker().hasConnection;
  return status;
}

//check if call is on going or not

Future<bool> finalCheck() async {
  Map forLog = {};
  forLog['time'] = DateTime.now().toString();
  customLogger.info("starting the Mobile Data check process ");
  var mobileData = await checkMobileData();
  forLog['mobileDataStatus'] = mobileData;
  customLogger.info("Mobile Data check process completed as $mobileData ");
  customLogger.info("starting the Internet Connection check process ");
  var internetConnection = await checkInternetConnection();
  forLog['internetConnectionStatus'] = internetConnection;
  customLogger.info(
      "Internet Connection check process completed as $internetConnection");

  logData.addData(forLog);
  if (mobileData && internetConnection) {
    return true;
  } else {
    return false;
  }
}
