import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Crop {
  String name = '';
  int id = 0;
  String footNotes = '';
}

List<Crop> allCrops = [];

Future getAllCrops() async {
  http.Response response =
      await http.get(Uri.https("bryclay.000webhostapp.com", "getallcrops.php"));
  List<dynamic> data;
  print("Status code for get all crops request: ${response.statusCode}");
  print("Response for get all crops request: ${response.body}");
  data = jsonDecode(response.body);
  allCrops = data.map<Crop>((element) {
    Crop temp = Crop();
    temp.name = element["Crop name"];
    temp.id = int.parse(element["Crop id"]);
    temp.footNotes = element["Foot notes"];
    return temp;
  }).toList();
  return;
}
