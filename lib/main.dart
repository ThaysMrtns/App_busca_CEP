
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
  var cep="";
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
                  }),
                  Text(
                    "CEP: $cep"
                  )
                ],
              ),
        ),
      )
    );
    
  }
  void muda(data){
         //Mudando o estado dos variaveis
    setState(() {
      cep = data;
    });
  }
  
  void req() async{
    var url = "https://viacep.com.br/ws/01001000/json/";
    var response = await http.get(url); 
    if(response.statusCode == 200){
      /*
        Os dados devem ser convertidos para json afim de poderem ser acessados
      */
      var jsonResponse = convert.jsonDecode(response.body);
      
      // Com os dados já tratados podemos acessa-los corretamente
      var data = jsonResponse["cep"];
      var logradouro = jsonResponse["logradouro"];
      var complemento = jsonResponse["complemento"];
      var bairro = jsonResponse["bairro"];
      var localidade = jsonResponse["localidade"];
      var uf = jsonResponse["uf"];
      print("Dados: $data, $logradouro, $complemento, $bairro, $localidade, $uf");

      muda(data);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }
}

