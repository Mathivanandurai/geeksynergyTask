import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/routes/routes.dart';
import 'package:task/theme.dart';
import 'package:task/utils/shared_preference.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await MySharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Task',
      theme: themeData,
      initialRoute: RouteNames.cart,
      getPages: RoutesPages.routes,
    );
  }
}
