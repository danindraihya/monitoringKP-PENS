
import 'package:flutter/material.dart';

class InputData extends StatelessWidget {
  final String atribut;
  final TextEditingController controller;
  final double height;
  final int maxLines;

  InputData({this.atribut, this.controller, this.height, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Text(atribut)),
          Expanded(
            flex: 2,
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.black,
              ),
              child: Container(
                height: height,
                child: TextField(
                  maxLines: maxLines,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  controller: controller,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


