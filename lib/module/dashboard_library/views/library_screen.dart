// import 'package:admin/responsive.dart';

import 'package:admin/module/dashboard_library/widgets/user_card.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
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
    );
  }

  Widget buildHeader(
    BuildContext context,
  ) =>
      Container(
        width: MediaQuery.of(context).size.width * .7,
        height: MediaQuery.of(context).size.height * .07,
        child: Row(children: [
          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .08),
                child: Text('Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
              )),
          Expanded(
              flex: 2,
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
          Expanded(flex: 2, child: Row()),
        ]),
      );
}
