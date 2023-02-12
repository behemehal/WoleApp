import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wole_app/config.dart';

import '../classes/connection.dart';
import '../features.dart';

class SendPackageDialog extends StatefulWidget {
  const SendPackageDialog({Key? key}) : super(key: key);
  @override
  SendPackageDialogState createState() => SendPackageDialogState();
}

class SendPackageDialogState extends State<SendPackageDialog> {
  TextEditingController title = TextEditingController();
  TextEditingController ipController = TextEditingController();
  TextEditingController macController = TextEditingController();

  String? titleError;
  String? ipAddressError;
  String? macAddressError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Icon(
              Icons.send,
              color: Color.fromRGBO(0, 0, 255, 0.3),
              size: 35,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
            child: Text(
              getLangContext("4"),
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 22,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            controller: title,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: titleError,
                hintText: getLangContext("5")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            controller: ipController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              errorText: ipAddressError,
              hintText: getLangContext("6"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            controller: macController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              errorText: macAddressError,
              hintText: getLangContext("7"),
            ),
          ),
        ),
        //Button
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: InkWell(
            radius: 75,
            borderRadius: BorderRadius.circular(75),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                color: const Color.fromRGBO(0, 0, 255, 0.65),
              ),
              child: const Center(
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            onTap: () {
              if (title.text == "") {
                setState(() {
                  titleError = getLangContext("8");
                });
              } else if (ipController.text == "" ||
                  !ipAddressCorrect(ipController.text)) {
                setState(() {
                  titleError = null;
                  ipAddressError = getLangContext("9");
                });
              } else if (macController.text == "" ||
                  !macAddressCorrect(macController.text)) {
                setState(() {
                  titleError = null;
                  ipAddressError = null;
                  macAddressError = getLangContext("10");
                });
              } else {
                Future<RawDatagramSocket> com =
                    RawDatagramSocket.bind(InternetAddress("0.0.0.0"), 0);
                com.then((socket) {
                  List<int> target = [7, 40557, 47536, 44099, 38482, 46613];
                  List<int> package = generateWolPackage(macController.text
                      .replaceAll(":", "")
                      .replaceAll("-", ""));
                  for (int port in target) {
                    socket.send(
                        package, InternetAddress(ipController.text), port);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(getLangContext("11")),
                  ));
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(getLangContext("12")),
                  ));
                });
                addConnection(Connection(
                  ipController.text,
                  title.text,
                  macController.text,
                  false,
                ));
                Navigator.pop(context);
              }
            },
          ),
        ),
      ],
    );
  }
}
