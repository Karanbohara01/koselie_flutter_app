import 'package:flutter/cupertino.dart';
import 'package:koselie/app/app.dart';
import 'package:koselie/app/di/di.dart';
import 'package:koselie/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialized the hive database
  await HiveService.init();
// Initialize the dependencies
  await initDependencies();
  runApp(
    const App(),
  );
}
