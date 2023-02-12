import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wole_app/config.dart';
import 'classes/connection.dart';

late SharedPreferences appPrefences;

bool macAddressCorrect(String mac) {
  if (mac.length != 17) {
    return false;
  } else if (mac.split(":").length != 6 && mac.split("-").length != 6) {
    return false;
  } else {
    return true;
  }
}

bool ipAddressCorrect(String ip) {
  if (ip.split(".").length != 4) {
    return false;
  } else {
    return true;
  }
}

//Genereate wol magic package
List<int> generateWolPackage(String mac) {
  List<int> package = [];
  for (int e = 0; e < 17; e++) {
    for (int i = 0; i < 6; i++) {
      if (e == 0) {
        package.insert(e, 0xFF);
      } else {
        package.insert(
            i + e * 6, int.parse(mac.substring(i * 2, i * 2 + 2), radix: 16));
      }
    }
  }
  return package;
}

Future<bool> initPrefences() async {
  appPrefences = await SharedPreferences.getInstance();
  language = appPrefences.getInt("language") ?? (Platform.localeName == "tr_TR" ? 1 : 2);
  return true;
}

List<Connection> getConnections() {
  //Get connections from shared preferences
  if (appPrefences.getStringList("connections") == null) {
    return [];
  } else {
    List<String> connectionsJson = appPrefences.getStringList("connections")!;
    List<Connection> connections = [];
    for (String connectionJson in connectionsJson) {
      connections.add(Connection.fromJson(json.decode(connectionJson)));
    }
    return connections;
  }
}

void addConnection(Connection connection) {
  //Add connection to shared preferences
  List<String> connectionsJson =
      appPrefences.getStringList("connections") ?? [];
  connectionsJson.add(json.encode(connection));
  appPrefences.setStringList("connections", connectionsJson);
}

List<Connection> getFavorites() {
  //Get favorites from shared preferences
  List<Connection> connections = getConnections();
  List<Connection> favorites = [];
  for (Connection connection in connections) {
    if (connection.isFavorite) {
      favorites.add(connection);
    }
  }
  return favorites;
}

List<Connection> getHistory() {
  //Get history from shared preferences
  List<Connection> connections = getConnections();
  List<Connection> history = [];
  for (Connection connection in connections) {
    if (!connection.isFavorite) {
      history.add(connection);
    }
  }
  return history;
}

void removeConnection(int index) {
  //Remove connection from shared preferences
  List<String> connectionsJson =
      appPrefences.getStringList("connections") ?? [];
  connectionsJson.removeAt(index);
  appPrefences.setStringList("connections", connectionsJson);
}

void favoriteConnection(int index) {
  //Favorite connection from shared preferences
  List<String> connectionsJson =
      appPrefences.getStringList("connections") ?? [];
  List<Connection> connections = getConnections();
  connections[index].isFavorite = !connections[index].isFavorite;
  connectionsJson[index] = json.encode(connections[index]);
  appPrefences.setStringList("connections", connectionsJson);
}
