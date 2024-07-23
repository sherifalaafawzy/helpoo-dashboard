import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/remote/api_endpoints.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/routes.dart';
import '../../../core/util/widgets/load_image.dart';
import 'side_menu_list_tile.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeMainWidget extends StatefulWidget {
  const HomeMainWidget({super.key});

  @override
  State<HomeMainWidget> createState() => _HomeMainWidgetState();
}

class _HomeMainWidgetState extends State<HomeMainWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is Logout) {
          context.pushNamedAndRemoveUntil(Routes.login);
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            Container(
              height: double.infinity,
              width: appBloc.sideMenuCollapsed ? 50 : 300,
              color: HexColor(mainColor2),
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            appBloc.toggleSideMenu();
                          },
                          icon: Icon(
                            appBloc.sideMenuCollapsed ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: HexColor(mainColor2),
                      child: LoadImage(
                        image: 'helpoo_logo',
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///******************** Dashboard ****************** [0]
                            Visibility(
                              visible: true,
                              child: SideMenuListTile(
                                onTap: () {
                                  // just testing notifications by clicking here
                                  // appBloc.sendNotification(
                                  //   fcmtoken: 'dOlcpobOT-azlMcwX0-E2x:APA91bHPXxbcH-_QCP-Yp57ZtKSnq3eUpavdV4NSu9JB4AZO0SRy28mZEk2vStv3r2a3g256Le6chbacYMUFJ-ap3aWyq5KEpcB_U09c1TyBGNqM5ay1yOrl3mOSw4bxnbv13MYyot20',
                                  //   title: 'helpoo',
                                  //   body: 'hiiiiiiiiiiiiiiiiiiiiiii',
                                  //   id: '1',
                                  //   // id: 'dOlcpobOT-azlMcwX0-E2x:APA91bHPXxbcH-_QCP-Yp57ZtKSnq3eUpavdV4NSu9JB4AZO0SRy28mZEk2vStv3r2a3g256Le6chbacYMUFJ-ap3aWyq5KEpcB_U09c1TyBGNqM5ay1yOrl3mOSw4bxnbv13MYyot20',
                                  //   type: 'service-request',
                                  // );

                                  appBloc.sideMenu = SideMenu.dashboard;
                                },
                                title: appTranslation(context).dashboard,
                                leadingIcon: Icons.home_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.dashboard,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///****************** serviceRequests ************** [1]
                            Visibility(
                              visible: userRoleName == Rules.Corporate.name ||
                                  userRoleName == Rules.Admin.name ||
                                  userRoleName == Rules.CallCenter.name ||
                                  userRoleName == Rules.Super.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.serviceRequests;
                                  if (appBloc.homeScreens[1].length > 1) {
                                    appBloc.changeStackNav(index: 1, isAdd: false);
                                  }
                                },
                                title: appTranslation(context).serviceRequests,
                                leadingIcon: Icons.notifications_active_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.serviceRequests,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///****************** accidentReports ************** [2]
                            Visibility(
                              visible: userRoleName == Rules.Insurance.name ||
                                  userRoleName == Rules.Admin.name ||
                                  userRoleName == Rules.Super.name ||
                                  userRoleName == Rules.Broker.name ||
                                  userRoleName == Rules.SuperVisor.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.accidentReports;
                                  if (appBloc.homeScreens[2].length > 1) {
                                    appBloc.changeStackNav(index: 2, isAdd: false);
                                  }
                                },
                                title: 'Client FNOL and requests',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                trailing: '${appBloc.accidentReportModel?.totalItems ?? 0}',
                                hideTrailing: false,
                                isSelected: appBloc.sideMenu == SideMenu.accidentReports,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///********************* fnol ********************* [3]
                            Visibility(
                              visible: userRoleName == Rules.Insurance.name ||
                                  userRoleName == Rules.Admin.name ||
                                  userRoleName == Rules.Super.name ||
                                  userRoleName == Rules.Broker.name ||
                                  userRoleName == Rules.SuperVisor.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.fnol;
                                  if (appBloc.homeScreens[3].length > 1) {
                                    appBloc.changeStackNav(index: 3, isAdd: false);
                                  }
                                },
                                title: '● FNOL',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                trailing: appBloc.fnolTotalUnread.toString(),
                                hideTrailing: false,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.fnol,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///****************** beforeRepair ***************** [4]
                            Visibility(
                              visible: userRoleName == Rules.Insurance.name ||
                                  userRoleName == Rules.Admin.name ||
                                  userRoleName == Rules.Super.name ||
                                  userRoleName == Rules.Broker.name ||
                                  userRoleName == Rules.SuperVisor.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.beforeRepair;
                                  if (appBloc.homeScreens[4].length > 1) {
                                    appBloc.changeStackNav(index: 4, isAdd: false);
                                  }
                                },
                                title: '● Before Repair requests',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                trailing: appBloc.bRepairTotalUnread.toString(),
                                hideTrailing: false,
                                isSelected: appBloc.sideMenu == SideMenu.beforeRepair,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///****************** afterRepair ****************** [5]
                            Visibility(
                              visible: userRoleName == Rules.Insurance.name ||
                                  userRoleName == Rules.Admin.name ||
                                  userRoleName == Rules.Super.name ||
                                  userRoleName == Rules.Broker.name ||
                                  userRoleName == Rules.SuperVisor.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.afterRepair;
                                  if (appBloc.homeScreens[5].length > 1) {
                                    appBloc.changeStackNav(index: 5, isAdd: false);
                                  }
                                },
                                title: '● After Repair requests',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                trailing: appBloc.aRepairTotalUnread.toString(),
                                hideTrailing: false,
                                isSelected: appBloc.sideMenu == SideMenu.afterRepair,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///****************** Collect Data ****************** [6]
                            Visibility(
                              visible: userRoleName == Rules.Insurance.name ||
                                  userRoleName == Rules.Admin.name ||
                                  userRoleName == Rules.Super.name ||
                                  userRoleName == Rules.Broker.name ||
                                  userRoleName == Rules.SuperVisor.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.collectData;
                                  if (appBloc.homeScreens[6].length > 1) {
                                    appBloc.changeStackNav(index: 6, isAdd: false);
                                  }
                                },
                                title: '● Collect Data requests',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                trailing: appBloc.billingTotalUnread.toString(),
                                hideTrailing: false,
                                isSelected: appBloc.sideMenu == SideMenu.collectData,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///**************** insurancePolicy **************** [7]
                            Visibility(
                              visible: userRoleName == Rules.Insurance.name,
                              // userRoleName == Rules.Admin.name ||
                              // // userRoleName == Rules.CallCenter.name ||
                              // userRoleName == Rules.Super.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.insurancePolicy;
                                },
                                title: 'Add Policy',
                                leadingIcon: Icons.assignment_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.insurancePolicy,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ************** Inspection Assessment *********** [8]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.inspectionAssessment;
                                  if (appBloc.homeScreens[8].length > 1) {
                                    appBloc.changeStackNav(index: 8, isAdd: false);
                                  }
                                },
                                title: 'Inspections Assessment',
                                leadingIcon: Icons.assignment_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.inspectionAssessment,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// **************** preInception ****************** [9]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.preInception;
                                  if (appBloc.homeScreens[9].length > 1) {
                                    appBloc.changeStackNav(index: 9, isAdd: false);
                                  }
                                },
                                title: '● Pre-Inception',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.preInception,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// **************** beforeRepair ****************** [10]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.beforeRepairInspection;
                                  if (appBloc.homeScreens[10].length > 1) {
                                    appBloc.changeStackNav(index: 10, isAdd: false);
                                  }
                                },
                                title: '● Before Repair',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.beforeRepairInspection,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ****************** Supplement ****************** [11]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.supplementInspection;
                                  if (appBloc.homeScreens[11].length > 1) {
                                    appBloc.changeStackNav(index: 11, isAdd: false);
                                  }
                                },
                                title: '● Supplement',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.supplementInspection,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ************** afterRepairInspection *********** [12]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.afterRepairInspection;
                                  if (appBloc.homeScreens[12].length > 1) {
                                    appBloc.changeStackNav(index: 12, isAdd: false);
                                  }
                                },
                                title: '● After Repair',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.afterRepairInspection,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ************** rightSaveInspection ************* [13]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.rightSaveInspection;
                                  if (appBloc.homeScreens[13].length > 1) {
                                    appBloc.changeStackNav(index: 13, isAdd: false);
                                  }
                                },
                                title: '● Right Save',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.rightSaveInspection,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ***************** Inspections ****************** [14]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.inspections;
                                  if (appBloc.homeScreens[14].length > 1) {
                                    appBloc.changeStackNav(index: 14, isAdd: false);
                                  }
                                },
                                title: 'Requests Status',
                                leadingIcon: Icons.assignment_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.inspections,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ********************* Pending ****************** [15]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.pendingInspections;
                                  if (appBloc.homeScreens[15].length > 1) {
                                    appBloc.changeStackNav(index: 15, isAdd: false);
                                  }
                                },
                                title: '● Pending',
                                trailing: appBloc.pendingTotalItems.toString(),
                                hideTrailing: false,
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.pendingInspections,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ********************** Done ******************** [16]
                            Visibility(
                              visible: (userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.finishedInspections;
                                  if (appBloc.homeScreens[16].length > 1) {
                                    appBloc.changeStackNav(index: 16, isAdd: false);
                                  }
                                },
                                title: '● Finished',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.finishedInspections,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///****************** inspectors ******************* [17]
                            Visibility(
                              visible: (userRoleName != Rules.Inspector.name &&
                                  userRoleName != Rules.Corporate.name &&
                                  userRoleName != Rules.CallCenter.name &&
                                  userRoleName != Rules.Super.name &&
                                  userRoleName != Rules.Broker.name),
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.inspectors;
                                },
                                title: 'Inspectors List',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.inspectors,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* reports ******************** [18]
                            Visibility(
                              visible: userRoleName != Rules.Broker.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.reports;
                                  if (appBloc.homeScreens[18].length > 1) {
                                    appBloc.changeStackNav(index: 18, isAdd: false);
                                  }
                                },
                                title: 'Reports',
                                leadingIcon: Icons.supervised_user_circle_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.reports,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* users ******************** [19]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.CallCenter.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.users;
                                  if (appBloc.homeScreens[19].length > 1) {
                                    appBloc.changeStackNav(index: 19, isAdd: false);
                                  }
                                },
                                title: 'Users',
                                leadingIcon: Icons.person,
                                isSelected: appBloc.sideMenu == SideMenu.users,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Clients ******************** [20]

                            Visibility(
                              visible: userRoleName == Rules.Super.name
                              // ||
                              // userRoleName == Rules.CallCenter.name
                              ,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.clients;
                                  if (appBloc.homeScreens[20].length > 1) {
                                    appBloc.changeStackNav(index: 20, isAdd: false);
                                  }
                                },
                                leadingIcon: Icons.person_outline,
                                title: '● Clients',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.clients,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Drivers ******************** [21]

                            Visibility(
                              visible: userRoleName == Rules.Super.name
                              // ||
                              // userRoleName == Rules.CallCenter.name
                              ,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.drivers;
                                  if (appBloc.homeScreens[21].length > 1) {
                                    appBloc.changeStackNav(index: 21, isAdd: false);
                                  }
                                },
                                leadingIcon: Icons.person_outline,
                                title: '● Drivers',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.drivers,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Inspectors ******************** [22]

                            Visibility(
                              visible: userRoleName == Rules.Super.name
                              // ||
                              // userRoleName == Rules.CallCenter.name
                              ,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.inspectorsUsers;
                                  if (appBloc.homeScreens[22].length > 1) {
                                    appBloc.changeStackNav(index: 22, isAdd: false);
                                  }
                                },
                                leadingIcon: Icons.person_outline,
                                title: '● Inspectors',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.inspectorsUsers,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Insurance ******************** [23]

                            Visibility(
                              visible: userRoleName == Rules.Super.name
                              // ||
                              // userRoleName == Rules.CallCenter.name
                              ,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.insuranceUsers;
                                  if (appBloc.homeScreens[23].length > 1) {
                                    appBloc.changeStackNav(index: 23, isAdd: false);
                                  }
                                },
                                leadingIcon: Icons.person_outline,
                                title: '● Insurance',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                isSelected: appBloc.sideMenu == SideMenu.insuranceUsers,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Vehicles ******************** [24]
                            Visibility(
                              visible: userRoleName == Rules.Super.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.vehicles;
                                  if (appBloc.homeScreens[24].length > 1) {
                                    appBloc.changeStackNav(index: 24, isAdd: false);
                                  }
                                },
                                title: 'Vehicles',
                                leadingIcon: Icons.car_rental_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.vehicles,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Drivers Map ******************** [25]
                            Visibility(
                              visible: userRoleName == Rules.Admin.name || userRoleName == Rules.CallCenter.name || userRoleName == Rules.Super.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.driversMap;
                                  if (appBloc.homeScreens[25].length > 1) {
                                    appBloc.changeStackNav(index: 25, isAdd: false);
                                  }
                                },
                                title: 'Drivers Map',
                                leadingIcon: Icons.map,
                                isSelected: appBloc.sideMenu == SideMenu.driversMap,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Settings ******************** [26]
                            Visibility(
                              visible: userRoleName == Rules.Super.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.settings;
                                  if (appBloc.homeScreens[26].length > 1) {
                                    appBloc.changeStackNav(index: 26, isAdd: false);
                                  }
                                },
                                title: 'Settings',
                                leadingIcon: Icons.settings,
                                isSelected: appBloc.sideMenu == SideMenu.settings,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///**************** admin cars **************** [27]
                            Visibility(
                              visible: userRoleName == Rules.Admin.name ||
                                  // userRoleName == Rules.CallCenter.name ||
                                  userRoleName == Rules.Super.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.adminCars;
                                  if (appBloc.homeScreens[27].length > 1) {
                                    appBloc.changeStackNav(index: 27, isAdd: false);
                                  }
                                },
                                title: "Cars",
                                leadingIcon: Icons.assignment_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.adminCars,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            ///**************** Corporates **************** [28]
                            Visibility(
                              visible: userRoleName == Rules.Admin.name || userRoleName == Rules.CallCenter.name || userRoleName == Rules.Super.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.corporates;
                                  if (appBloc.homeScreens[28].length > 1) {
                                    appBloc.changeStackNav(index: 28, isAdd: false);
                                  }
                                },
                                title: "Corporates",
                                leadingIcon: Icons.corporate_fare,
                                isSelected: appBloc.sideMenu == SideMenu.corporates,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* config ******************** [29]
                            Visibility(
                              visible: userRoleName == Rules.Super.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.config;
                                },
                                title: 'Config',
                                leadingIcon: Icons.settings,
                                isSelected: appBloc.sideMenu == SideMenu.config,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Packages For Company ******************** [30]
                            Visibility(
                              visible:
                                  userRoleName == Rules.Corporate.name || userRoleName == Rules.Insurance.name || userRoleName == Rules.Broker.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.corporatePackageUsers;
                                  if (appBloc.homeScreens[30].length > 1) {
                                    appBloc.changeStackNav(index: 30, isAdd: false);
                                  }
                                },
                                title: 'Package',
                                leadingIcon: Icons.category_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.corporatePackageUsers,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* promo codes ******************** [31]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.promoCodes;
                                  if (appBloc.homeScreens[31].length > 1) {
                                    appBloc.changeStackNav(index: 30, isAdd: false);
                                  }
                                },
                                title: 'Promo Codes',
                                leadingIcon: Icons.one_k_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.promoCodes,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* packages promo codes ******************** [32]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.packagesPromoCodes;
                                  if (appBloc.homeScreens[32].length > 1) {
                                    appBloc.changeStackNav(index: 30, isAdd: false);
                                  }
                                },
                                title: 'Packages Promo Codes',
                                leadingIcon: Icons.one_k_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.packagesPromoCodes,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* corporate Users ******************** [33]
                            // Visibility(
                            //   visible: userRoleName == Rules.Corporate.name,
                            //   child: SideMenuListTile(
                            //     onTap: () {
                            //       appBloc.sideMenu = SideMenu.corporateUsers;
                            //       if (appBloc.homeScreens[33].length > 1) {
                            //         appBloc.changeStackNav(
                            //             index: 30, isAdd: false);
                            //       }
                            //     },
                            //     title: 'Corporate Users',
                            //     leadingIcon: Icons.group_outlined,
                            //     isSelected:
                            //         appBloc.sideMenu == SideMenu.corporateUsers,
                            //     collapsed: appBloc.sideMenuCollapsed,
                            //   ),
                            // ),

                            /// ******************* Packages ******************** [34]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.packages;
                                },
                                title: 'Packages',
                                leadingIcon: Icons.home_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.packages,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* All Drivers ******************** [35]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.driversStatistics;
                                  if (appBloc.homeScreens[35].length > 1) {
                                    appBloc.changeStackNav(index: 35, isAdd: false);
                                  }
                                },
                                title: 'All Drivers Statistics',
                                leadingIcon: Icons.car_rental_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.driversStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Busy Drivers ******************** [36]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.busyDriversStatistics;
                                  if (appBloc.homeScreens[36].length > 1) {
                                    appBloc.changeStackNav(index: 36, isAdd: false);
                                  }
                                },
                                title: '● Busy Drivers',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                leadingIcon: Icons.car_rental_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.busyDriversStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* free Drivers ******************** [37]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.freeDriversStatistics;
                                  if (appBloc.homeScreens[37].length > 1) {
                                    appBloc.changeStackNav(index: 37, isAdd: false);
                                  }
                                },
                                title: '● Free Drivers',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                leadingIcon: Icons.car_rental_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.freeDriversStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Offline Drivers ******************** [38]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.offlineDriversStatistics;
                                  if (appBloc.homeScreens[38].length > 1) {
                                    appBloc.changeStackNav(index: 38, isAdd: false);
                                  }
                                },
                                title: '● Offline Drivers',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                leadingIcon: Icons.car_rental_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.offlineDriversStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Online Drivers ******************** [39]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.onlineDriversStatistics;
                                  if (appBloc.homeScreens[39].length > 1) {
                                    appBloc.changeStackNav(index: 39, isAdd: false);
                                  }
                                },
                                title: '● Online Drivers',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                leadingIcon: Icons.car_rental_outlined,
                                isSelected: appBloc.sideMenu == SideMenu.onlineDriversStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* All vehicles ******************** [40]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.vehiclesStatistics;
                                  if (appBloc.homeScreens[40].length > 1) {
                                    appBloc.changeStackNav(index: 40, isAdd: false);
                                  }
                                },
                                title: 'All Vehicles Statistics',
                                leadingIcon: Icons.car_repair,
                                isSelected: appBloc.sideMenu == SideMenu.vehiclesStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Busy Vehicles ******************** [41]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.busyVehiclesStatistics;
                                  if (appBloc.homeScreens[41].length > 1) {
                                    appBloc.changeStackNav(index: 41, isAdd: false);
                                  }
                                },
                                title: '● Busy Vehicles',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                leadingIcon: Icons.car_repair,
                                isSelected: appBloc.sideMenu == SideMenu.busyVehiclesStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* free vehicles ******************** [42]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.freeVehiclesStatistics;
                                  if (appBloc.homeScreens[42].length > 1) {
                                    appBloc.changeStackNav(index: 42, isAdd: false);
                                  }
                                },
                                title: '● Free Vehicles',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                leadingIcon: Icons.car_repair,
                                isSelected: appBloc.sideMenu == SideMenu.freeVehiclesStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Offline Drivers ******************** [43]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.offlineVehiclesStatistics;
                                  if (appBloc.homeScreens[43].length > 1) {
                                    appBloc.changeStackNav(index: 43, isAdd: false);
                                  }
                                },
                                title: '● Offline Vehicles',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                leadingIcon: Icons.car_repair,
                                isSelected: appBloc.sideMenu == SideMenu.offlineVehiclesStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),

                            /// ******************* Online Vehicles ******************** [44]
                            Visibility(
                              visible: userRoleName == Rules.Super.name || userRoleName == Rules.Admin.name,
                              child: SideMenuListTile(
                                onTap: () {
                                  appBloc.sideMenu = SideMenu.onlineVehiclesStatistics;
                                  if (appBloc.homeScreens[39].length > 1) {
                                    appBloc.changeStackNav(index: 39, isAdd: false);
                                  }
                                },
                                title: '● Online Vehicles',
                                hideIcon: !appBloc.sideMenuCollapsed,
                                leadingIcon: Icons.car_repair,
                                isSelected: appBloc.sideMenu == SideMenu.onlineVehiclesStatistics,
                                collapsed: appBloc.sideMenuCollapsed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!appBloc.sideMenuCollapsed) ...{
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'Helpoo',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 24,
                                  ),
                            ),
                            const Spacer(),
                            //
                            //
                            //
                            // if(appBloc.profileModel != null && appBloc.profileModel!.user.photo.isNotEmpty)
                            Text(
                              '$userRoleName - $userName  $vNum',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            space10Horizontal(),
                            const Image(
                              image: AssetImage(
                                'assets/images/man.png',
                              ),
                              width: 60,
                              height: 60,
                            ),
                            PopupMenuButton(
                              icon: const Icon(
                                Icons.arrow_drop_down_rounded,
                              ),
                              tooltip: 'show menu',
                              offset: const Offset(
                                0,
                                70,
                              ),
                              // iconSize: 20.0,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  enabled: false,
                                  child: Center(
                                    child: Text(
                                      appTranslation(context).welcome,
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  onTap: () {
                                    appBloc.logout();
                                  },
                                  child: Center(
                                    child: Text(
                                      appTranslation(context).logout,
                                      style: Theme.of(context).textTheme.displayLarge,
                                    ),
                                  ),
                                ),
                              ],
                              onSelected: (int selected) {},
                            ),
                          ],
                        ),
                      ),
                      const MyDivider(),
                    },

                    Expanded(
                      child: appBloc.homeScreens[appBloc.currentSideMenuIndex].last,
                    ),

                    if (appBloc.sideMenu == SideMenu.dashboard) space20Vertical(),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        '2023 © Helpoo',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // space20Vertical(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
