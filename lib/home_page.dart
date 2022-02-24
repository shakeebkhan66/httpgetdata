import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://github.com/shakeebkhan66";
  List? data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      //Encode the URL to save ourself from Spacing Type Issues
      Uri.parse(url),
      //Only Accept Json Response
      headers: {"Accept": "application/json"}
    );
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve Data via HTTP Get Request"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data!.length,
          itemBuilder: (BuildContext context, int index){
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(data![index]['name']),

                    ),
                  )
                ],
              ),
            ),
          );
          },
      ),
    );
  }
}
