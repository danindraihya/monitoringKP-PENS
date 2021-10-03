import 'package:flutter/material.dart';

class RowData extends StatelessWidget {
  final String atribut;
  final String isi;

  RowData({this.atribut, this.isi});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            atribut,
            style: TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          flex: 2,
            child: Text(
          isi,
          style: TextStyle(fontSize: 14),
        ))
      ],
    );
  }
}
