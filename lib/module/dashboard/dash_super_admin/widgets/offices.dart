import 'package:admin/enums/admin_enum.dart';
import 'package:admin/models/offices_args_model.dart';
import 'package:admin/module/dashboard/dash_admin_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_cashier/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_library/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_registrar/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_security_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/offices_cards.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/overall_rating.dart';
import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:admin/widgets/loading_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficesListCard extends GetView<MainScreenController> {
  OfficesListCard({super.key});

  final adminOfficeBarGraphController = AdminOfficeBarGraphController.instance;
  final cashierBarGraphController = CashierBarGraphController.instance;
  final libraryBarGraphController = LibraryBarGraphController.instance;
  final registrarBarGraphController = RegistrarBarGraphController.instance;
  final securityOfficeBarGraphController =
      SecurityOfficeBarGraphController.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => adminOfficeBarGraphController.isLoading ||
                cashierBarGraphController.isLoading ||
                libraryBarGraphController.isLoading ||
                registrarBarGraphController.isLoading ||
                securityOfficeBarGraphController.isLoading
            ? Center(
                child: LoadingIndicator(color: Colors.blue),
              )
            : OverAllRating(
                averageRating: (adminOfficeBarGraphController
                            .totalAverageFivePoints.value +
                        adminOfficeBarGraphController
                            .totalAverageTwoPoints.value +
                        cashierBarGraphController.totalAverageFivePoints.value +
                        cashierBarGraphController.totalAverageTwoPoints.value +
                        libraryBarGraphController.totalAverageFivePoints.value +
                        libraryBarGraphController.totalAverageTwoPoints.value +
                        registrarBarGraphController
                            .totalAverageFivePoints.value +
                        registrarBarGraphController
                            .totalAverageTwoPoints.value +
                        securityOfficeBarGraphController
                            .totalAverageFivePoints.value +
                        securityOfficeBarGraphController
                            .totalAverageTwoPoints.value) /
                    5,
                officeWithHighestRate: adminOfficeBarGraphController.totalAverageFivePoints.value + adminOfficeBarGraphController.totalAverageTwoPoints.value > cashierBarGraphController.totalAverageFivePoints.value + cashierBarGraphController.totalAverageTwoPoints.value &&
                        adminOfficeBarGraphController.totalAverageFivePoints.value + adminOfficeBarGraphController.totalAverageTwoPoints.value >
                            libraryBarGraphController.totalAverageFivePoints.value +
                                libraryBarGraphController
                                    .totalAverageTwoPoints.value &&
                        adminOfficeBarGraphController.totalAverageFivePoints.value + adminOfficeBarGraphController.totalAverageTwoPoints.value >
                            registrarBarGraphController.totalAverageFivePoints.value +
                                registrarBarGraphController
                                    .totalAverageTwoPoints.value &&
                        adminOfficeBarGraphController.totalAverageFivePoints.value +
                                adminOfficeBarGraphController
                                    .totalAverageTwoPoints.value >
                            securityOfficeBarGraphController.totalAverageFivePoints.value +
                                securityOfficeBarGraphController
                                    .totalAverageTwoPoints.value
                    ? 'Admin Office'
                    : cashierBarGraphController.totalAverageFivePoints.value + cashierBarGraphController.totalAverageTwoPoints.value >
                                adminOfficeBarGraphController.totalAverageFivePoints.value +
                                    adminOfficeBarGraphController
                                        .totalAverageTwoPoints.value &&
                            cashierBarGraphController.totalAverageFivePoints.value + cashierBarGraphController.totalAverageTwoPoints.value >
                                libraryBarGraphController.totalAverageFivePoints.value + libraryBarGraphController.totalAverageTwoPoints.value &&
                            cashierBarGraphController.totalAverageFivePoints.value + cashierBarGraphController.totalAverageTwoPoints.value > registrarBarGraphController.totalAverageFivePoints.value + registrarBarGraphController.totalAverageTwoPoints.value &&
                            cashierBarGraphController.totalAverageFivePoints.value + cashierBarGraphController.totalAverageTwoPoints.value > securityOfficeBarGraphController.totalAverageFivePoints.value + securityOfficeBarGraphController.totalAverageTwoPoints.value
                        ? "Cashier Office"
                        : libraryBarGraphController.totalAverageFivePoints.value + libraryBarGraphController.totalAverageTwoPoints.value > adminOfficeBarGraphController.totalAverageFivePoints.value + adminOfficeBarGraphController.totalAverageTwoPoints.value && libraryBarGraphController.totalAverageFivePoints.value + libraryBarGraphController.totalAverageTwoPoints.value > cashierBarGraphController.totalAverageFivePoints.value + cashierBarGraphController.totalAverageTwoPoints.value && libraryBarGraphController.totalAverageFivePoints.value + libraryBarGraphController.totalAverageTwoPoints.value > registrarBarGraphController.totalAverageFivePoints.value + registrarBarGraphController.totalAverageTwoPoints.value && libraryBarGraphController.totalAverageFivePoints.value + libraryBarGraphController.totalAverageTwoPoints.value > securityOfficeBarGraphController.totalAverageFivePoints.value + securityOfficeBarGraphController.totalAverageTwoPoints.value
                            ? 'Library Office'
                            : registrarBarGraphController.totalAverageFivePoints.value + registrarBarGraphController.totalAverageTwoPoints.value > adminOfficeBarGraphController.totalAverageFivePoints.value + adminOfficeBarGraphController.totalAverageTwoPoints.value && registrarBarGraphController.totalAverageFivePoints.value + registrarBarGraphController.totalAverageTwoPoints.value > cashierBarGraphController.totalAverageFivePoints.value + cashierBarGraphController.totalAverageTwoPoints.value && registrarBarGraphController.totalAverageFivePoints.value + registrarBarGraphController.totalAverageTwoPoints.value > libraryBarGraphController.totalAverageFivePoints.value + libraryBarGraphController.totalAverageTwoPoints.value && registrarBarGraphController.totalAverageFivePoints.value + registrarBarGraphController.totalAverageTwoPoints.value > securityOfficeBarGraphController.totalAverageFivePoints.value + securityOfficeBarGraphController.totalAverageTwoPoints.value
                                ? 'Registrar Office'
                                : securityOfficeBarGraphController.totalAverageFivePoints.value + securityOfficeBarGraphController.totalAverageTwoPoints.value > adminOfficeBarGraphController.totalAverageFivePoints.value + adminOfficeBarGraphController.totalAverageTwoPoints.value && securityOfficeBarGraphController.totalAverageFivePoints.value + securityOfficeBarGraphController.totalAverageTwoPoints.value > cashierBarGraphController.totalAverageFivePoints.value + cashierBarGraphController.totalAverageTwoPoints.value && securityOfficeBarGraphController.totalAverageFivePoints.value + securityOfficeBarGraphController.totalAverageTwoPoints.value > libraryBarGraphController.totalAverageFivePoints.value + libraryBarGraphController.totalAverageTwoPoints.value && securityOfficeBarGraphController.totalAverageFivePoints.value + securityOfficeBarGraphController.totalAverageTwoPoints.value > registrarBarGraphController.totalAverageFivePoints.value + registrarBarGraphController.totalAverageTwoPoints.value
                                    ? 'Security Office'
                                    : '',
              )),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 100 / 50,
            scrollDirection: Axis.vertical,
            children: [
              Obx(
                () => adminOfficeBarGraphController.isLoading
                    ? Center(
                        child: LoadingIndicator(color: Colors.blue),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.setAdminView(AdminTypeEnum.Admin);
                        },
                        child: OfficesCard(
                          officesArgsData: OfficesArgsData(
                            availableVersion: adminOfficeBarGraphController
                                .questionLatestVersion.value!.version
                                .toString(),
                            average: adminOfficeBarGraphController
                                        .totalAverageFivePoints.value !=
                                    0
                                ? adminOfficeBarGraphController
                                    .totalAverageFivePoints.value
                                : adminOfficeBarGraphController
                                    .totalAverageTwoPoints.value,
                            mostVisitedUser: adminOfficeBarGraphController
                                .highestVisitor.value,
                            officeName: "Admin Office",
                            questionnaireType: adminOfficeBarGraphController.typeOfQuestionnaire.value,
                          ),
                        ),
                      ),
              ),
              Obx(
                () => cashierBarGraphController.isLoading
                    ? Center(
                        child: LoadingIndicator(color: Colors.blue),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.setAdminView(AdminTypeEnum.CashierAdmin);
                        },
                        child: OfficesCard(
                          officesArgsData: OfficesArgsData(
                            availableVersion: cashierBarGraphController
                                .questionLatestVersion.value!.version
                                .toString(),
                            average: cashierBarGraphController
                                        .totalAverageFivePoints.value !=
                                    0
                                ? cashierBarGraphController
                                    .totalAverageFivePoints.value
                                : cashierBarGraphController
                                    .totalAverageTwoPoints.value,
                            mostVisitedUser:
                                cashierBarGraphController.highestVisitor.value,
                            officeName: "Cashier Office",
                            questionnaireType: cashierBarGraphController.typeOfQuestionnaire.value,
                          ),
                        ),
                      ),
              ),
              Obx(
                () => libraryBarGraphController.isLoading
                    ? Center(
                        child: LoadingIndicator(color: Colors.blue),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.setAdminView(AdminTypeEnum.LibraryAdmin);
                        },
                        child: OfficesCard(
                          officesArgsData: OfficesArgsData(
                            availableVersion: libraryBarGraphController
                                .questionLatestVersion.value!.version
                                .toString(),
                            average: libraryBarGraphController
                                        .totalAverageFivePoints.value !=
                                    0
                                ? libraryBarGraphController
                                    .totalAverageFivePoints.value
                                : libraryBarGraphController
                                    .totalAverageTwoPoints.value,
                            mostVisitedUser:
                                libraryBarGraphController.highestVisitor.value,
                            officeName: "Library Office",
                            questionnaireType: libraryBarGraphController.typeOfQuestionnaire.value,
                          ),
                        ),
                      ),
              ),
              Obx(
                () => registrarBarGraphController.isLoading
                    ? Center(
                        child: LoadingIndicator(color: Colors.blue),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.setAdminView(AdminTypeEnum.RegistrarAdmin);
                        },
                        child: OfficesCard(
                          officesArgsData: OfficesArgsData(
                            availableVersion: registrarBarGraphController
                                .questionLatestVersion.value!.version
                                .toString(),
                            average: registrarBarGraphController
                                        .totalAverageFivePoints.value !=
                                    0
                                ? registrarBarGraphController
                                    .totalAverageFivePoints.value
                                : registrarBarGraphController
                                    .totalAverageTwoPoints.value,
                            mostVisitedUser: registrarBarGraphController
                                .highestVisitor.value,
                            officeName: "Registrar Office",
                            questionnaireType: registrarBarGraphController.typeOfQuestionnaire.value,
                          ),
                        ),
                      ),
              ),
              Obx(
                () => securityOfficeBarGraphController.isLoading
                    ? Center(
                        child: LoadingIndicator(color: Colors.blue),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.setAdminView(AdminTypeEnum.SecurityAdmin);
                        },
                        child: OfficesCard(
                          officesArgsData: OfficesArgsData(
                            availableVersion: securityOfficeBarGraphController
                                .questionLatestVersion.value!.version
                                .toString(),
                            average: securityOfficeBarGraphController
                                        .totalAverageFivePoints.value !=
                                    0.0
                                ? securityOfficeBarGraphController
                                    .totalAverageFivePoints.value
                                : securityOfficeBarGraphController
                                    .totalAverageTwoPoints.value,
                            mostVisitedUser: securityOfficeBarGraphController
                                .highestVisitor.value,
                            officeName: "Security Office",
                            questionnaireType: securityOfficeBarGraphController.typeOfQuestionnaire.value,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}