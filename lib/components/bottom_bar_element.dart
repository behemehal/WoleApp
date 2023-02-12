import 'package:flutter/material.dart';

class BottomBarElement extends StatelessWidget {
  const BottomBarElement(this.isActive, this.onTap, this.icon, this.title,
      {super.key});
  final bool isActive;
  final Function() onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 45,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(75),
              color: isActive
                  ? const Color.fromARGB(73, 206, 206, 206)
                  : Colors.transparent,
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
