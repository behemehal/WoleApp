import 'package:flutter/material.dart';
import 'package:wole_app/config.dart';

class NoItem extends StatelessWidget {
  const NoItem(this.activeTab, {super.key});
  final int activeTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 65),
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(75),
              color: const Color.fromRGBO(0, 0, 255, 0.3),
            ),
            child: Center(
              child: Icon(
                activeTab == 0 ? Icons.favorite : Icons.history,
                color: Colors.white,
                size: 55,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: Text(
              getLangContext((activeTab + 1).toString()),
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
