import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco ="0";
  String _dolar_real="0";

  void _recuperar_preco() async {
    String url = "https://blockchain.info/ticker";

    String url2 = "https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL,BTC-BRL";

    http.Response dados = await http.get(url2);

    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    Map<String, dynamic> retorno2 = json.decode(dados.body);
    //
    // print("Resultado "+ retorno2["USDBRL"]["bid"].toString() );

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();

      _dolar_real = retorno2["USDBRL"]["bid"].toString();
    });

    //print("Resultado "+ retorno["BRL"]["buy"].toString() );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("img/Real.jpg", height: 150,),

            Padding(padding: EdgeInsets.only(top: 15, bottom: 0),
              child: Text(
                "Preço do bitcoin: ",
                style: TextStyle(
                  fontSize: 30,

                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 0, bottom: 30),
            child: Text(
              "R\$  "+_preco,
              style: TextStyle(
                fontSize: 30,

              ),
            ),
            ),
            Padding(padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Text(
                "Preço do Dolar:",
                style: TextStyle(
                  fontSize: 30,

                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 0, bottom: 30),
              child: Text(
                "R\$  "+_dolar_real,
                style: TextStyle(
                  fontSize: 30,

                ),
              ),
            ),
            RaisedButton(
              onPressed:_recuperar_preco
              ,
              child: Text(
                "Atualizar",
                style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),

            ),
            color: Colors.orange,
            padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
            )
          ],
        ),
      ),
      ),

    );
  }
}
