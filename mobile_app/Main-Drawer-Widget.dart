import 'package:flutter/material.dart';

class MainDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Container(
              color: Colors.amber,
              child: Center(
                child: Text(
                  "Screens",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text("Insect Identifier"),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, "/Insect-Identification-Screen");
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("Pesticide Suggestion"),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, "/Pesticide-Suggestion-Screen");
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Project"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/About-Project-Screen");
            },
          )
        ],
      ),
    );
  }
}
