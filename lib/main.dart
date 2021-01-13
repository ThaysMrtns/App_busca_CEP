
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Busca CEP",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: 
      Padding(
        padding: EdgeInsets.all(20),
        child:
          Center(
            child: 
              Column(
                children: [
                  Text("Buscar CEP"),
                  RaisedButton(onPressed: (){
                    req();
                  })
                ],
              ),
        ),
      )
    );
    
  }
  void req() async{
    var url = "https://viacep.com.br/ws/01001000/json/";
    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      print("CEP: $jsonResponse");
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }
}

