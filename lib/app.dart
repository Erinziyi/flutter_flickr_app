import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'image_list.dart';
import 'image_model.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget>createState(){
    return AppState();
  }
}

class AppState extends State<App> {
List<ImageModel>images =[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flitter Image'),
        ),
        body: ImageList(),
      ),


    );
  }








}
