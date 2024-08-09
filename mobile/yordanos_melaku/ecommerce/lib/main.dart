import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task_6/add_page.dart';
import 'package:flutter_task_6/details_page.dart';
import 'package:flutter_task_6/home_page.dart';
import 'package:flutter_task_6/search_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {'/':(context)=>HomePage(),
      '/details':(context) => DetailsPage(),
      '/search':(context)=> SearchPage(),
      '/add':(context)=> AddPage()
      }
    );
  }
}
