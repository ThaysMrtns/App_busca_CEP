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
        padding: EdgeInsets.all(20),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Digite o CEP", labelStyle: TextStyle(fontSize: 24)),
          enabled: true, //Habilita e desabilita o campo de texto
          /*maxLength: 8,
          maxLengthEnforced: true,*/
          style: TextStyle(color: Colors.black),
          onSubmitted: (String cep) {
            print("cep: $cep");
          },
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
      Text("CEP: $cep"),
      Text("Logradouro: $logradouro"),
      Text("Complemento: $complemento"),
      Text("Bairro: $bairro"),
      Text("Localidade: $localidade"),
      Text("Uf: $uf")
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
      print(
          "Dados: $cepCep, $cepLogradouro, $cepComplemento, $cepBairro, $cepLocalidade, $cepUf");

      muda(cepCep, cepLogradouro, cepComplemento, cepBairro, cepLocalidade,
          cepUf);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }
}
