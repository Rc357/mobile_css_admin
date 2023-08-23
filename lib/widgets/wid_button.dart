import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Function? onClick;
  CustomButton(
      {this.text, this.width, this.height, this.onClick, this.fontSize});
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue.shade700),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.blue)))),
          onPressed: () {
            widget.onClick!();
          },
          child: Text(
            '${widget.text}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'roboto'),
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatefulWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Function? onClick;
  CustomButton2(
      {this.text, this.width, this.height, this.onClick, this.fontSize});
  @override
  _CustomButtonState2 createState() => _CustomButtonState2();
}

class _CustomButtonState2 extends State<CustomButton2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black)))),
          onPressed: () {
            widget.onClick!();
          },
          child: Text(
            '${widget.text}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'roboto'),
          ),
        ),
      ),
    );
  }
}
