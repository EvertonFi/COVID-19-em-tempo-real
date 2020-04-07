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
              height: 500,
              width: MediaQuery.of(context).size.width - 100,
              child: Center(
                  child: PageView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Total de Casos: ",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              (totalCasos.toInt()).toString(),
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Total de Mortes: ",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              (totalMortes.toInt()).toString(),
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Total de Curados: ",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              (totalCurados.toInt()).toString(),
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
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
