import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Insect {
  String name = '';
  int id = 0;
  String footNotes = '';
}

List<Insect> allInsects = [];

Future getAllInsects() async {
  http.Response response = await http
      .get(Uri.https("bryclay.000webhostapp.com", "getallinsects.php"));
  List<dynamic> data;
  print("Status code for get all insects request: ${response.statusCode}");
  print("Response for get all insects request: ${response.body}");
  data = jsonDecode(response.body);
  allInsects = data.map<Insect>((element) {
    Insect temp = Insect();
    temp.name = element["Insect name"];
    temp.id = int.parse(element["Insect id"]);
    temp.footNotes = element["Foot notes"];
    return temp;
  }).toList();
  return;
}
