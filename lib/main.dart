import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wole_app/pages/home.dart';
import 'features.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await initPrefences();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wole',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blueAccent,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      home: const Home(),
    );
  }
}
