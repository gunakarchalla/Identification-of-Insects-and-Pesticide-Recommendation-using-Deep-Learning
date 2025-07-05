import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../Widgets/Main-Drawer-Widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class InsectIdentificationScreen extends StatefulWidget {
  @override
  _InsectIdentificationScreenState createState() =>
      _InsectIdentificationScreenState();
}

class _InsectIdentificationScreenState
    extends State<InsectIdentificationScreen> {
  File _image;
  final picker = ImagePicker();
  String output_id = "";
  int detection = 0;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getId() async {
    setState(() {
      detection = 1;
    });
    Map<String, dynamic> data;
    Map<String, dynamic> data2;
    var data3;
    String input_id;

    Future(() async {
      var stream =
          new http.ByteStream(DelegatingStream.typed(_image.openRead()));
      var length = await _image.length();

      var uri = Uri.parse('https://api.ubiops.com/v2.1/projects/bryclay/blobs');

      var request = new http.MultipartRequest("POST", uri);
      request.headers["Authorization"] =
          'Token 47a7e590eb2202ec61cdb972061a0971e1917b51';
      request.headers["blob-ttl"] = "900";
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: "phone_input.jpg");

      request.files.add(multipartFile);
      var response = await request.send();
      print('Status code of uploading blob request: ${response.statusCode}');
      response.stream.transform(utf8.decoder).listen((value) {
        print("Response for uploading blob request: $value");
        data = jsonDecode(value);
        input_id = data["id"];
      });
      return input_id;
    }).then((value) async {
      // print("Input blob id: $input_id");

      // http.Response response2 = await http.post(
      //     Uri.https("api.ubiops.com",
      //         "v2.1/projects/bryclay/deployments/yolov4/request"),
      //     headers: {
      //       "Authorization": "Token 47a7e590eb2202ec61cdb972061a0971e1917b51",
      //       "content-type": "application/json"
      //     },
      //     body: jsonEncode({"image_input": value}));

      HttpClient httpClient = new HttpClient();
      HttpClientRequest request2 = await httpClient.postUrl(Uri.parse(
          "https://api.ubiops.com/v2.1/projects/bryclay/deployments/newyolov4/request"));
      request2.headers.set('content-type', 'application/json');
      request2.headers.set(
          "Authorization", "Token 47a7e590eb2202ec61cdb972061a0971e1917b51");
      request2.add(utf8.encode(json.encode({"image_input": input_id})));
      HttpClientResponse response2 = await request2.close();
      String reply = await response2.transform(utf8.decoder).join();
      httpClient.close();
      print("Status code of deployment request: ${response2.statusCode}");
      print('Response for deployment request: $reply');
      data2 = jsonDecode(reply);
      // print('output blob id: ${data2["result"]["image_output"]}');

      setState(() {
        output_id = data2["result"]["image_output"];
      });

      return reply;
    });
    setState(() {
      detection = 0;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerWidget(),
      appBar: AppBar(
        title: Text('Insect Identification'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Column(
                children: [
                  (output_id != "")
                      ? FadeInImage(
                          placeholder:
                              AssetImage("lib/Assets/Downloading-Image.png"),
                          image: NetworkImage(
                              "https://api.ubiops.com/v2.1/projects/bryclay/blobs/$output_id",
                              headers: {
                                "Authorization":
                                    "Token 47a7e590eb2202ec61cdb972061a0971e1917b51"
                              }),
                        )
                      : Image.file(_image),
                  ElevatedButton.icon(
                      onPressed:
                          (_image == null || detection == 1) ? null : getId,
                      icon: Icon(Icons.search),
                      label: Text("Send for Identification")),
                  Text("\nNOTE For Users", textScaleFactor: 1.5),
                  Container(
                    child: Text(
                      " 1. Download the GOOD resolution image of either Ant, Beetle, Caterpillar or Moth from google images.\n 2. Select the same image from library.\n 3. Click send for identification and WAIT for 30 to 45 seconds depending upon picture size.\n 4. DO NOT PRESS ANY BUTTON(even send for identification) until recognised imaged is displayed.",
                      textAlign: TextAlign.justify,
                    ),
                    padding: EdgeInsets.all(10),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (detection == 1) ? null : getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
