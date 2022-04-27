import 'package:flutter/material.dart';
import 'package:flutter_breaking/helper/app_route.dart';

void main() {
  runApp(BreakingBadApp(
    appRoute: AppRoute(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  final AppRoute appRoute;

  const BreakingBadApp(
      {Key? key,
      required this.appRoute}); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.generateRoute,
    );
  }
}
