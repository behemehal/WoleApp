import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wole_app/config.dart';

import '../features.dart';
import 'open_source_licenses.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getLangContext("20")),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Image(
                image: AssetImage('assets/Wole.png'),
                width: 150,
                height: 150,
              ),
            ),
            const Text(
              "Wole",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                getLangContext("21"),
                style: const TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OpenSourceLicenses(),
                  ),
                );
              },
              child: Text(getLangContext("22")),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: TextButton(
                onPressed: () {
                  launchUrlString(
                      "https://github.com/behemehal/WoleApp/blob/main/privacy_policy.md");
                },
                child: Text(getLangContext("23")),
              ),
            ),

            //langauge selection
            Text(
              getLangContext("26"),
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
            TextButton(
              onPressed: () {
                language = language == 1 ? 2 : 1;
                appPrefences.setInt("language", language);
                setState(() {});
              },
              child: Text(
                langs[language]!,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            const Spacer(),

            Text(getLangContext("24")),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    launchUrlString("https://github.com/behemehal/WoleApp");
                  },
                  child: const Image(
                    image: AssetImage('assets/git.png'),
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                const Text(
                  "Made by",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 10),
                const Image(
                  image: AssetImage("assets/behemehalLogo.png"),
                  width: 25,
                  height: 25,
                ),
                TextButton(
                  onPressed: () {
                    launchUrlString("https://behemehal.org");
                  },
                  child: const Text(
                    "Behemehal",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  getLangContext("25"),
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
