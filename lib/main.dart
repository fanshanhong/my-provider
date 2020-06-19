import 'package:flutter/material.dart';
import 'package:my_provider/menu_page.dart';
import 'package:my_provider/provider/CountModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Provider.value(
    value: 48,
    child: ChangeNotifierProvider.value(
      value: CountModel(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuPage(),
    );
  }
}

