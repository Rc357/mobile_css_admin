import 'package:admin/module/dashboard_library/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(closeOverlays: true),
                    child: Text(
                      "Version List",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded),
                  Text(
                    "Respondents",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Text(
                "Library Respondents".toUpperCase(),
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              buildHeader(context),
              UserCardWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(
    BuildContext context,
  ) =>
      Container(
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .07,
        child: Row(children: [
          Expanded(
            flex: 4,
            child: Text('Name',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
          ),
          Expanded(
            flex: 2,
            child: Text('Visited Time',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
          ),
          Expanded(
            flex: 2,
            child: Text('Identity',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
          ),
          Expanded(flex: 2, child: Row()),
        ]),
      );
}
