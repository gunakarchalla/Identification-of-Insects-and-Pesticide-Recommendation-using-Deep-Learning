import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Pesticide {
  String name = '';
  int waitingPeriod = 0;
  int cost = 0;
  double quantity = 0;
  String footNotes = '';
}

List<Pesticide> allPesticides = [];
List<Pesticide> requiredPesticides = [];

Future getRequiredPesticides(String i_op, String c_op) async {
  http.Response response = await http.post(
    Uri.https("bryclay.000webhostapp.com", "getrequiredpesticides.php"),
    body: {"insect": i_op, "crop": c_op},
  );
  List<dynamic> data;
  print(
      "Status code for get required pesticides request: ${response.statusCode}");
  print("Response for get required pesticides request: ${response.body}");
  data = jsonDecode(response.body);
  requiredPesticides = data.map<Pesticide>((element) {
    Pesticide temp = Pesticide();
    temp.name = element["Pesticide name"];
    temp.cost = int.parse(element["Cost"]);
    temp.quantity = double.parse(element["Volume"]);
    temp.waitingPeriod = int.parse(element["Waiting period"]);
    temp.footNotes = element["Foot notes"];
    return temp;
  }).toList();
  return;
}

Future getAllPesticides() async {
  // var url = 'https://bryclay.000webhostapp.com/allpesticides.php';
  http.Response response = await http
      .get(Uri.https("bryclay.000webhostapp.com", "getallpesticides.php"));
  List<dynamic> data;
  print("Status code for get all pesticides request: ${response.statusCode}");
  print("Response for get all pesticides request: ${response.body}");
  data = jsonDecode(response.body);
  allPesticides = data.map<Pesticide>((element) {
    Pesticide temp = Pesticide();
    temp.name = element["Pesticide name"];
    temp.cost = int.parse(element["Cost"]);
    temp.quantity = double.parse(element["Volume"]);
    temp.waitingPeriod = int.parse(element["Waiting period"]);
    temp.footNotes = element["Foot notes"];
    return temp;
  }).toList();
  return;
}
