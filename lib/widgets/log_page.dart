//let us create a low  of the test wtih time stamp

import 'package:data_enhencer/utils/notification_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LogPage extends StatelessWidget {
   LogPage({super.key});
  var data = logData.getData();

  @override
  Widget build(BuildContext context) {
    var logdataProvire = Provider.of<LogData>(context);
    return ChangeNotifierProvider(
      create: (context) => LogData(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text('${Provider.of<LogData>(context).getData().length} logs'),
        ),
        body: Column(
          children: [
            
           
          ],
        ),
      ),
    );
  }
}
