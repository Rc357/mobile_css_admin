import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NoInternetAccess extends StatefulWidget {
  final bool isFromLogin;
  const NoInternetAccess({Key? key, required this.isFromLogin})
      : super(key: key);

  @override
  _NoInternetAccessState createState() => _NoInternetAccessState();
}

class _NoInternetAccessState extends State<NoInternetAccess> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: 1 * height,
        width: 1 * width,
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: .1 * height,
            ),
            Semantics(
              label: 'No internet connection icon',
              child: Image.asset(
                "assets/no_internet.jpg",
                height: .45 * height,
                width: 1 * width,
                semanticLabel: 'Ready Agent logo',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Something went wrong!",
              style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Please check your internet connection and try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            Spacer(),
            Semantics(
              label: 'Try Again',
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  foregroundColor: Colors.pink.shade900,
                  // onPrimary: Colors.white,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontStyle: FontStyle.italic),
                ),
                // minWidth: double.infinity,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                // color: Colors.pink.shade900,
                // textColor: Colors.white,
                // padding: const EdgeInsets.all(15.0),
                onPressed: () async {
                  if (widget.isFromLogin) {
                    checkInternet();
                  }
                },
                child: Text(
                  "TRY AGAIN",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future checkInternet() async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    // print("INTERNET HERE ");
    // print(isConnected);
    if (isConnected) {
      Navigator.pushNamed(context, '/signin');
    }
  }
}
