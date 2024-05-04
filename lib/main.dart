import 'package:data_enhencer/logger.dart';
import 'package:data_enhencer/services/fore_ground_service.dart';
import 'package:data_enhencer/settings_screen.dart';
/* import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart'; */
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var status = await Permission.notification.isDenied;
  if (status) {
    await Permission.notification.request();
    customLogger.debug('permission requested');
  }

  await initializeService();
  customLogger.debug('starting the app...');
  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Enhencer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Data Enhencer'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Monitoring is ${appState.isMonitoring ? 'on' : 'off'}',
            ),
            Text(
              'Monitoring interval is ${appState.monitoringInterval} seconds',
            ),
            Text(
              'Minimum data threshold is ${appState.minmumDataThreshold} MB',
            ),
            ElevatedButton(
              onPressed: () {
                appState.toggleMonitoring();
              },
              child: Text(appState.isMonitoring
                  ? 'Stop Monitoring'
                  : 'Start Monitoring'),
            ),
            Slider(
              value: appState.monitoringInterval.toDouble(),
              min: 5,
              max: 60,
              divisions: 10,
              label: appState.monitoringInterval.toString(),
              onChanged: (double value) {
                appState.setMonitoringInterval(value.toInt());
              },
            ),
            Slider(
              value: appState.minmumDataThreshold,
              min: 1,
              max: 10,
              divisions: 9,
              label: appState.minmumDataThreshold.toString(),
              onChanged: (double value) {
                appState.setMinmumDataThreshold(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
