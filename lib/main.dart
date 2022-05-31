import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backend/provider.dart';
import 'screens/homePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider<MyProvider>(
      create: (_) => MyProvider(),
      child:MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}