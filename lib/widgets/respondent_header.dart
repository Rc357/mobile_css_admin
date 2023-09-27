import 'package:flutter/material.dart';

class RespondentsHeader extends StatelessWidget {
  const RespondentsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * .07,
      child: Row(children: [
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 4,
            child: Text('Name',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ))),
        Expanded(
            flex: 3,
            child: Text('Visited Time',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ))),
        Expanded(
            flex: 2,
            child: Text('Identity',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ))),
        Expanded(
            flex: 1,
            child: Row(
              children: [
                Text('Status',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
              ],
            )),
      ]),
    );
  }
}
