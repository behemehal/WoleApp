import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wole_app/classes/connection.dart';
import 'package:wole_app/config.dart';
import '../features.dart';

/// Create statefull widget for connection card

class ConnectionCard extends StatefulWidget {
  const ConnectionCard(this.connection, {super.key});
  final Connection connection;
  @override
  State<StatefulWidget> createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const SizedBox(
              width: 50,
              height: 50,
              child: Icon(Icons.computer),
            ),
            title: Text(widget.connection.title),
            subtitle: Text(widget.connection.ip),
            trailing: IconButton(
              splashRadius: 20,
              onPressed: () {
                Future<RawDatagramSocket> com =
                    RawDatagramSocket.bind(InternetAddress("0.0.0.0"), 0);
                com.then((socket) {
                  socket.broadcastEnabled = true;
                  List<int> target = [7, 40557, 47536, 44099, 38482, 46613];
                  List<int> package = generateWolPackage(widget.connection.mac
                      .replaceAll(":", "")
                      .replaceAll("-", ""));
                  for (int port in target) {
                    socket.send(
                        package, InternetAddress(widget.connection.ip), port);
                    //\0
                    socket
                        .send([0], InternetAddress(widget.connection.ip), port);
                  }
                  socket.close();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(getLangContext("11")),
                  ));
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(getLangContext("12")),
                  ));
                });
              },
              icon: const Icon(Icons.power_settings_new),
            ),
          ),
        ],
      ),
    );
  }
}
