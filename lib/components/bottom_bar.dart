import 'package:flutter/material.dart';
import 'package:wole_app/config.dart';

import 'bottom_bar_element.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(this.activeTab, this.onPageChange, {super.key});

  final Function(int) onPageChange;
  final int activeTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: BottomBarElement(
            activeTab == 0,
            () {
              onPageChange(0);
            },
            Icons.favorite,
            getLangContext("13"),
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: BottomBarElement(
            activeTab == 1,
            () {
              onPageChange(1);
            },
            Icons.history,
            getLangContext("14"),
          ),
        ),
      ],
    );
  }
}
