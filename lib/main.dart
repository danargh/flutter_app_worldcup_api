import 'package:flutter/material.dart';
import 'package:responsi/matches_screen.dart';

// *Nama   : Danar Ghulamsyah
// *NIM    : 124200020

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Piala Dunia 2022'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String? title;
  const MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
        centerTitle: true,
      ),
      body: const MatchesScreen(),
    );
  }
}
