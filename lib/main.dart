import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'listitems/listitems.dart';
import 'providers/addproviders.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child:  const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ListScreen(),
        );
      },
    );
  }
}


