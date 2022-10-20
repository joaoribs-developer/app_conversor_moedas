import 'package:app_conversor_moedas/HttpFactory/httpConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
    return Text(
          "$text...",
          style:const  TextStyle(
            color: Colors.amber,
            fontSize: 25,
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
    return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.amber, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: Colors.amber,
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
                  futureBluider(dropdownValue),
                  SizedBox()

            ]),
          ),
        );
  }
}
Widget textView(String value, String text){
  return Text("$text $value", style: TextStyle(
    fontSize: 25.0,
    color: Colors.black
  ),);
}

Widget futureBluider([String names = "USD"]){
  return  FutureBuilder<Map>(
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
              String name = snapshot.data!["results"]["currencies"]["$names"]["name"].toString();
              String buy = snapshot.data!["results"]["currencies"]["$names"]["buy"].toString();
              String sell = snapshot.data!["results"]["currencies"]["$names"]["sell"].toString();
              String variation = snapshot.data!["results"]["currencies"]["$names"]["variation"].toString();
              return Card(
                color: Colors.blue[200],
                elevation: 16,
                child: SizedBox(
                  height: 250,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textView(name, "Nome:"),
                        textView(buy, "Valor de compra R\$:"),
                        textView(sell, "Valor de vendaR\$:"),
                        textView(variation, "Variação:")
                      ],
                    ),
                  ),
                ),
              );
              // Carregando(text: data,);

            }

        }
      });
}

