import 'package:app_conversor_moedas/HttpFactory/httpConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Conversor de moedas",
            textAlign: TextAlign.center,
          ),
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Dados Carregando...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if(snapshot.hasError){

                }

            }
          },
        ));
  }
}
