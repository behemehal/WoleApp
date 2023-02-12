import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wole_app/components/bottom_bar.dart';
import 'package:wole_app/components/connection_card.dart';
import 'package:wole_app/config.dart';
import 'package:wole_app/pages/about_page.dart';
import '../components/dismissible_background.dart';
import '../components/no_item.dart';
import '../features.dart';
import '../views/send_package_dialog.dart';

var activeTab = 0;

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var connections = getConnections();
    List<ConnectionCard> favs = connections
        .where((connection) => connection.isFavorite)
        .toList()
        .map((connection) => ConnectionCard(connection))
        .toList();

    List<ConnectionCard> history = connections
        .where((connection) => !connection.isFavorite)
        .toList()
        .map((connection) => ConnectionCard(connection))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wole'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutPage(),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: (activeTab == 0 ? favs.isEmpty : history.isEmpty)
          ? NoItem(activeTab)
          : ListView.builder(
              itemCount: activeTab == 0 ? favs.length : history.length,
              itemBuilder: (context, index) {
                ConnectionCard element =
                    activeTab == 0 ? favs[index] : history[index];
                return Dismissible(
                  key: ValueKey(element),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      var old = appPrefences.getStringList("connections")!;
                      var newList = old
                          .where((connection) =>
                              connection !=
                              json.encode(element.connection.toJson()))
                          .toList();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            getLangContext("27"),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                      appPrefences.setStringList("connections", newList);
                      setState(() {});
                    } else {
                      var old = appPrefences.getStringList("connections")!;
                      var newList = old.map((e) {
                        if (json.encode(element.connection.toJson()) == e) {
                          element.connection.isFavorite =
                              !element.connection.isFavorite;
                          return json.encode(element.connection.toJson());
                        } else {
                          return e;
                        }
                      }).toList();
                      appPrefences.setStringList("connections", newList);
                      if (!connections[index].isFavorite) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              getLangContext("29"),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              getLangContext("28"),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                      setState(() {
                        connections[index].isFavorite =
                            !connections[index].isFavorite;
                      });
                    }
                  },
                  background: DismissibleBackground(activeTab),
                  child: element,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: getLangContext("3"),
        backgroundColor: Theme.of(context).primaryColor,
        //Floating action button on Scaffold
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
              ),
              builder: (BuildContext context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: const SendPackageDialog(),
                );
              }).then((value) {
            setState(() {});
          });
          setState(() {});
        },
        child: const Icon(
          Icons.add,
        ), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        //bottom navigation bar on scaffold
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        child: BottomBar(
          activeTab,
          (tab) => {
            setState(() {
              activeTab = tab;
            })
          },
        ),
      ),
    );
  }
}
