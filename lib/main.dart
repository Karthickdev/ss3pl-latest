import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/locator/locator.dart';
import 'package:southshore3pl/router/app_router.dart';
import 'package:southshore3pl/router/route_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(Phoenix(child: ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return MaterialApp(
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'southshore',
      
    );
  }
}
