import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:buscaCep/form.dart';

void main() {
  runApp(MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var cep = "";
  var complemento = "";
  var logradouro = "";
  var bairro = "";
  var localidade = "";
  var uf = "";

  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Busca CEP",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Formulario(),
                RaisedButton(onPressed: () {
                  req();
                }),
                Text("CEP: $cep"),
                Text("Logradouro: $logradouro"),
                Text("Complemento: $complemento"),
                Text("Bairro: $bairro"),
                Text("Localidade: $localidade"),
                Text("Uf: $uf")
              ],
            ),
          ),
        ));
  }

  void muda(
      cepCep, cepLogradouro, cepComplemento, cepBairro, cepLocalidade, cepUf) {
    //Mudando o estado dos variaveis
    setState(() {
      cep = cepCep;
      logradouro = cepLogradouro;
      complemento = cepComplemento;
      bairro = cepBairro;
      localidade = cepLocalidade;
      uf = cepUf;
    });
  }

  void req() async {
    var url = "https://viacep.com.br/ws/01001000/json/";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      /*
        Os dados devem ser convertidos para json afim de poderem ser acessados
      */
      var jsonResponse = convert.jsonDecode(response.body);

      // Com os dados já tratados podemos acessa-los corretamente
      var cepCep = jsonResponse["cep"];
      var cepLogradouro = jsonResponse["logradouro"];
      var cepComplemento = jsonResponse["complemento"];
      var cepBairro = jsonResponse["bairro"];
      var cepLocalidade = jsonResponse["localidade"];
      var cepUf = jsonResponse["uf"];
      print(
          "Dados: $cepCep, $cepLogradouro, $cepComplemento, $cepBairro, $cepLocalidade, $cepUf");

      muda(cepCep, cepLogradouro, cepComplemento, cepBairro, cepLocalidade,
          cepUf);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }
}
