import 'dart:ffi';
import '../Models/Pesticides.dart';
import '../Models/Insects.dart';
import '../Models/Crops.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Widgets/Main-Drawer-Widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PesticideSuggestionScreen extends StatefulWidget {
  @override
  _PesticideSuggestionScreenState createState() =>
      _PesticideSuggestionScreenState();
}

String selected_value_1;
String selected_value_2;

class _PesticideSuggestionScreenState extends State<PesticideSuggestionScreen> {
  @override
  void initState() {
    super.initState();
    loaddata();
  }

  Future loaddata() async {
    await getAllCrops();
    await getAllInsects();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerWidget(),
      appBar: AppBar(
        title: Text('Bryclay'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "NOTE for Users",
              textScaleFactor: 1.5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "Wait for 3 to 5 seconds to load the names of insects and crops.\n"),
            ),
            Text("Select Insect name"),
            DropdownButton<String>(
                hint: Text("Insect Names"),
                onChanged: (String op) {
                  setState(() {
                    selected_value_1 = op;
                  });
                },
                value: selected_value_1,
                items: allInsects.map<DropdownMenuItem<String>>((element) {
                  return DropdownMenuItem(
                    child: Text(element.name),
                    value: element.name,
                  );
                }).toList()),
            SizedBox(
              height: 10,
            ),
            Text("Select Crop name"),
            DropdownButton<String>(
                hint: Text("Crop Names"),
                onChanged: (String op) {
                  setState(() {
                    selected_value_2 = op;
                  });
                },
                value: selected_value_2,
                items: allCrops.map<DropdownMenuItem<String>>((element) {
                  return DropdownMenuItem(
                    child: Text(element.name),
                    value: element.name,
                  );
                }).toList()),
            ElevatedButton.icon(
              onPressed: () async {
                await getRequiredPesticides(selected_value_1, selected_value_2);
                setState(() {});
              },
              icon: Icon(Icons.search),
              label: Text("Search"),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: requiredPesticides.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(requiredPesticides[index].name),
                      subtitle: Text(
                          "Price:${requiredPesticides[index].cost} Quantity:${requiredPesticides[index].cost}"),
                      leading: CircleAvatar(
                        child: Text(
                            requiredPesticides[index].waitingPeriod.toString()),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await canLaunch(requiredPesticides[index].footNotes)
                                ? await launch(
                                    requiredPesticides[index].footNotes)
                                : throw 'Could not launch ${requiredPesticides[index].footNotes}';
                          },
                          icon: Icon(Icons.shopping_cart_rounded)),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
