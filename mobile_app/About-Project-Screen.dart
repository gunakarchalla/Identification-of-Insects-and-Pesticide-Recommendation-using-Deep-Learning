import 'package:flutter/material.dart';
import '../Widgets/Main-Drawer-Widget.dart';

class AboutProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text("About Project")),
      ),
      drawer: MainDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text("Project Supervisor"),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 20,
                width: double.infinity,
                child: Text("Mrs. Maibam Mangalleibi Chanu"),
              ),
            ),
            SizedBox(height: 15),
            Text("Team Members"),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: Text(
                    "Gunakar Challa            17103032 \nKetavath Prabhakar     17103048"),
              ),
            ),
            SizedBox(height: 15),
            Text("Project Brief"),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 130,
                width: double.infinity,
                child: Text(
                  "We have built a YOLO V4 compatible dataset consisting of 4 insects(Ant, Beetle, Caterpillar & Moth) and have trained the model on this custom dataset. Then we have deployed the model onto UbiOps server, so as to detect insects via API. We have also built backend (both database and API) required for pesticide suggestion. Finally we have integrated these two systems into our Flutter App.",
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text("App Usage Instructions"),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 310,
                width: double.infinity,
                child: Text(
                    "1.Open the Insect Identification screen located in the app drawer.\n2.Select the image of the insect of which you want to detect the name.\n3.Click on send image for detection button and wait for 30 to 45 seconds. User can then note down the name of the insect.\n4.Open Pesticide suggestion screen located in app drawer and wait for 3 to 5 seconds to load in names.\n5.Select the name of insect(if you don't know then use Insect Identificatin Screen) and name of the crop.\n6.Then click search to see list of compatible pesticides.\n7.You can press cart button beside desired pesticide to visit e-commerce page where they can purchase it.",
                    textAlign: TextAlign.justify),
              ),
            )
          ],
        ),
      ),
    );
  }
}
