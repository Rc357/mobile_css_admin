// import 'package:admin/module/dashboard/widgets/pie_chart.dart';
// import 'package:admin/module/dashboard/widgets/word_cloud.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class RespondentsWidgetMobile extends StatelessWidget {
//   const RespondentsWidgetMobile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * .05,
//       ),
//       child: Column(
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * .8,
//                 height: MediaQuery.of(context).size.height * .07,
//                 decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Total no. of Respondents",
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/icons/dashboard/people.svg',
//                           colorFilter:
//                               ColorFilter.mode(Colors.black, BlendMode.srcIn),
//                           height: 25,
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * .01,
//                         ),
//                         Text(
//                           "60",
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * .8,
//                 height: MediaQuery.of(context).size.height * .25,
//                 decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       buildLegend('Alumni', Colors.red, '60'),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * .01,
//                       ),
//                       buildLegend('Parents', Colors.orange, '30'),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * .01,
//                       ),
//                       buildLegend('Students', Colors.green, '10'),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * .01,
//                       ),
//                       buildLegend('Guests', Colors.blue, '20'),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width * .8,
//             height: MediaQuery.of(context).size.height * .3,
//             decoration: BoxDecoration(
//                 border: Border.all(),
//                 borderRadius: BorderRadius.all(Radius.circular(5))),
//             child: PieChartSample3(),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * .03,
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width * .8,
//             height: MediaQuery.of(context).size.height * .33,
//             decoration: BoxDecoration(
//                 border: Border.all(),
//                 borderRadius: BorderRadius.all(Radius.circular(5))),
//             child: Column(
//               children: [
//                 Text(
//                   "Remarks Word Cloud",
//                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//                 WordCloudExample(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildLegend(String label, Color color, String number) => Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: CircleAvatar(
//               backgroundColor: color,
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               number,
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ),
//         ],
//       );
// }
