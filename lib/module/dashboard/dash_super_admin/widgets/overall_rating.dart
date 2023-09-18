import 'package:flutter/material.dart';

class OverAllRating extends StatelessWidget {
  const OverAllRating({
    super.key,
    required this.averageRating,
    required this.officeWithHighestRate,
  });

  final double averageRating;
  final String officeWithHighestRate;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Color(0xffDDDDDD),
              blurRadius: 3.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 0.0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overall Rating',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Average Rating of All Offices: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(averageRating.toStringAsFixed(2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Office With Highest Rating: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(officeWithHighestRate),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
