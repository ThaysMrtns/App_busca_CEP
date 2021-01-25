import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  TextEditingController _textEditingController = TextEditingController();

  var cep = "";
  var complemento = "";
  var logradouro = "";
  var bairro = "";
  var localidade = "";
  var uf = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Digite o CEP", labelStyle: TextStyle(fontSize: 24)),
          enabled: true, //Habilita e desabilita o campo de texto
          style: TextStyle(color: Colors.black),
          onSubmitted: (String cep) {
            print("cep: $cep");
          },
          maxLength: 8,
          maxLengthEnforced: false,
          // O controller tem acesso ao que foi digitado no campo de texto
          controller: _textEditingController,
        ),
      ),
      RaisedButton(
        child: Text("Buscar"),
        color: Colors.lightBlue,
        onPressed: () {
          print("cep: ${_textEditingController.text}");
          req(_textEditingController.text);
        },
      ),
      Padding(
          padding: EdgeInsets.only(top:50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top:50, bottom: 50, left: 10, right: 10),
                    child: Column(children: [
                      Text("CEP: $cep", style: TextStyle(fontSize: 18),),
                      Text("Logradouro: $logradouro", style: TextStyle(fontSize: 18)),
                      Text("Complemento: $complemento", style: TextStyle(fontSize: 18)),
                      Text("Bairro: $bairro", style: TextStyle(fontSize: 18)),
                      Text("Localidade: $localidade", style: TextStyle(fontSize: 18)),
                      Text("Uf: $uf", style: TextStyle(fontSize: 18))
                    ]),
                  ),
                ])
              ),
            ],
          ))
    ]);
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

  void req(String cep) async {
    var url = "https://viacep.com.br/ws/$cep/json/";
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
      /*print("Dados: $cepCep, $cepLogradouro, $cepComplemento, $cepBairro, $cepLocalidade, $cepUf");*/

      muda(cepCep, cepLogradouro, cepComplemento, cepBairro, cepLocalidade,
          cepUf);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }
}
