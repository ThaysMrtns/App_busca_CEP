import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  TextEditingController _textEditingController = TextEditingController();

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
          maxLength: 8,
          maxLengthEnforced: true,
          style: TextStyle(color: Colors.black),
          /*onChanged: (String cep) {
            print("cep: $cep");
          },*/
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
        },
      )
    ]);
  }
}
