import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double totalCasos;
  double totalMortes;
  double totalCurados;
  bool carregado = false;

  getInfoVirus() async {
    String url = "http://coronavirusdata.herokuapp.com/";
    http.Response response;
    response = await http.get(url);
    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
      return (decodeJson['paises']['Brazil']);
    }
  }

  @override
  void initState() {
    super.initState();
    getInfoVirus().then((map) {
      setState(() {
        totalCasos = map['totalCasos'];
        totalMortes = map['totalMortes'];
        totalCurados = map['totalCurados'];
        carregado = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: carregado
          ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Total de Casos: " + totalCasos.toString(),
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "Total de Mortes: " + totalMortes.toString(),
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "Total de Curados: " + totalCurados.toString(),
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              child: Text(
                "Carregando...",
                style: TextStyle(fontSize: 50),
              ),
            ),
    ));
  }
}
