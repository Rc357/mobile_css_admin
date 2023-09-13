// import 'package:admin/module/dashboard/controllers/bar_graph_controller.dart';
// import 'package:admin/module/dashboard/widgets/pie_chart.dart';
// import 'package:admin/module/dashboard/widgets/word_cloud.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class RespondentsWidget extends GetView<BarGraphController> {
//   const RespondentsWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * .05,
//       ),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * .2,
//                 height: MediaQuery.of(context).size.height * .07,
//                 decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Total no. of Respondents",
//                       style: TextStyle(
//                           fontSize: MediaQuery.of(context).size.width * .01),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/icons/dashboard/people.svg',
//                           colorFilter:
//                               ColorFilter.mode(Colors.black, BlendMode.srcIn),
//                           height: MediaQuery.of(context).size.width * .01,
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * .01,
//                         ),
//                         Obx(
//                           () => Text(
//                             '${controller.users.length}',
//                             style: TextStyle(
//                                 fontSize:
//                                     MediaQuery.of(context).size.width * .01),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * .2,
//                 height: MediaQuery.of(context).size.height * .26,
//                 decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Obx(
//                     () => Column(
//                       children: [
//                         if (controller.totalAlumni.value != 0)
//                           buildLegend('Alumni', Colors.red,
//                               '${controller.totalAlumni.value}'),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .01,
//                         ),
//                         if (controller.totalParent.value != 0)
//                           buildLegend('Parents', Colors.orange,
//                               '${controller.totalParent.value}'),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .01,
//                         ),
//                         if (controller.totalStudent.value != 0)
//                           buildLegend('Students', Colors.green,
//                               '${controller.totalStudent.value}'),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .01,
//                         ),
//                         if (controller.totalGuest.value != 0)
//                           buildLegend('Guests', Colors.blue,
//                               '${controller.totalGuest.value}'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width * .2,
//             height: MediaQuery.of(context).size.height * .33,
//             decoration: BoxDecoration(
//                 border: Border.all(),
//                 borderRadius: BorderRadius.all(Radius.circular(5))),
//             child: PieChartSample3(),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * .03,
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width * .25,
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
