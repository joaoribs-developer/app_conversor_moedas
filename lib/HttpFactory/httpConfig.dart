import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final request = Uri.parse("https://api.hgbrasil.com/finance");

Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}