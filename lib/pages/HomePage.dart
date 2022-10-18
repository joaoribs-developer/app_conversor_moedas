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
  Widget build (BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Conversor de moedas",
          ),
        ),
        body: DropDown()
    );
  }

}
class Carregando extends StatelessWidget {
  const Carregando({Key? key, required this.text}) : super(key: key);
final String text;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Text(
          "$text...",
          style:const  TextStyle(
            color: Colors.amber,
            fontSize: 25,
          ),
        ),
      );
  }
}

class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
}

class DropDownWidget extends State {
  String dropdownValue = "USD";

  List <String> spinnerItems = [
    "USD",
    "EUR",
    "GBP",
    "ARS",
    "CAD",
    "AUD",
    "JPY",
    "CNY",
    "BTC"
  ] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        height: 400.0,
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.red, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? a) {
                setState(() {
                   dropdownValue = a!;
                });
              },
              items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Divider(),
            FutureBuilder<Map>(
                future: getData(),
                builder: (context, snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Carregando(text:"Dados Carregando");
                    default:
                      if(snapshot.hasError){
                        return const Carregando(text: "Erro na obtenção dos dados");
                      }else{
                        String data = snapshot.data!["results"]["currencies"]["$dropdownValue"].toString();
                        return  Container(
                          height: 200,
                          child: Text('Selected Item = ' + '$data',
                              style: TextStyle
                                (fontSize: 22,
                                  color: Colors.black)),
                        );
                        // Carregando(text: data,);

                      }

                  }
                })
          ]),
        ),
      ),
    );
  }
}
