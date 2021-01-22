import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                /*RaisedButton(onPressed: () {
                  req(cepUser);
                }),*/
              ],
            ),
          ),
        ));
  }
}
