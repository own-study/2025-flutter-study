import 'package:challenge/my_box.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyBox(color: Colors.red),
              MyBox(color: Colors.orange),
              MyBox(color: Colors.yellow),
              MyBox(color: Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyBox(color: Colors.orange)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyBox(color: Colors.red),
              MyBox(color: Colors.orange),
              MyBox(color: Colors.yellow),
              MyBox(color: Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyBox(color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}