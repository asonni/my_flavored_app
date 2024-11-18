import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final String flavor;

  const MyApp({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$flavor App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('$flavor App'),
        ),
        body: Center(
          child: Text('Running $flavor flavor'),
        ),
      ),
    );
  }
}
