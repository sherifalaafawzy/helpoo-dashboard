import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpoo_insurance_dashboard/core/util/extensions/build_context_extension.dart';
import 'package:helpoo_insurance_dashboard/core/util/widgets/loading_progress_widget.dart';
import 'package:helpoo_insurance_dashboard/core/util/widgets/primary_divider.dart';
import 'package:helpoo_insurance_dashboard/features/users/widgets/user_detailes_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../core/models/users/users_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_divider_text.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_icon_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/primary_pop_up_menu.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_icon_item.dart';
import '../../../core/util/widgets/tables/components/table_more_widget.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import '../../service_requests/widgets/steps/car_selection_body.dart';
import 'create_new_user.dart';
import 'package:intl/intl.dart';

class UsersTable extends StatefulWidget {
  const UsersTable({super.key});

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  GlobalKey selectionInsuranceCompanyKey = GlobalKey();

  // pagination logic

  List<TableRow> usersTableRows() {
    List<TableRow> tableRows = [];
    for (var element in AppBloc.get(context).itemsSubList) {
      tableRows.add(tableItem(
        userModel: element,
      ));
    }

    tableRows.insert(
      0,
      TablesHeader.tableHeader(
        context: context,
        centeredIndexes: [
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
        ],
        columnsTitles: [
          'ID',
          'Name',
          'Phone Number',
          'User Name',
          'Type',
          'Blocked',
          'Created At',
          'Action',
        ],
      ),
    );

    return tableRows;
  }

  GlobalKey itemsPerPageKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appBloc.getAllInsuranceCompanies();
    appBloc.getManufacturers();
    appBloc.getCarsModels();

    appBloc.itemsSubList = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is SearchCarByVinNumberSuccessState) {
          if (appBloc.searchCarByVinNumberResponseModel?.cars == null) {
            HelpooInAppNotification.showErrorMessage(message: 'No cars found with this vin number.');
          } else if (appBloc.searchCarByVinNumberResponseModel?.cars?.firstOrNull?.client?.user == null) {
            HelpooInAppNotification.showMessage(message: 'This is a New User. Create a profile for him to continue.');
          } else if (appBloc.searchCarByVinNumberResponseModel?.cars?.firstOrNull?.client?.user?.phoneNumber == null) {
            HelpooInAppNotification.showMessage(message: 'This user has no phone number. Please update his data.');
          } else {
            Navigator.pop(context);
            HelpooInAppNotification.showSuccessMessage(message: 'This car is already activated. We\'re getting client info.');
            appBloc.searchUserByPhoneController.text = appBloc.searchCarByVinNumberResponseModel?.cars?.firstOrNull?.client?.user?.phoneNumber.toString() ?? '';
            appBloc.searchUserByPhone();
          }
        }
      },
      builder: (context, state) {
        if (appBloc.usersModel?.users?.isEmpty ?? true) {
          return emptyCase();
        }
        return PrimaryPadding(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  space20Vertical(),
                  SizedBox(
                    width: appBloc.getWidgetWidth(),
                    child: Row(
                      children: [
                        Text(
                          'Users',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),

                        // Expanded(
                        //   child: PrimaryFormField(
                        //     validationError: '',
                        //     label: 'Phone number',
                        //     controller: appBloc.searchUserByPhoneController,
                        //     suffixIcon: PrimaryIconButton(icon: Icons.search, backgroundColor: mainColorHex, onPressed: () => appBloc.searchUserByPhone()),
                        //   ),
                        // ),

                        Expanded(
                          child: PrimaryFormField(
                            validationError: '',
                            label: 'Phone number',
                            controller: appBloc.searchUserByPhoneController,
                            suffixIcon: PrimaryIconButton(
                              icon: Icons.search,
                              backgroundColor: mainColorHex,
                              onPressed: () => appBloc.searchUserByPhone(),
                            ),
                          ),
                        ),
                        space10Horizontal(),

                        Expanded(
                          child: PrimaryFormField(
                            validationError: '',
                            label: 'Car vin number',
                            controller: appBloc.searchCarVinNumberController,
                            suffixIcon: PrimaryIconButton(
                              icon: Icons.search,
                              backgroundColor: mainColorHex,
                              onPressed: () => showPrimaryPopUp(
                                horizontalPadding: 30.w,
                                context: context,
                                isDismissible: false,
                                // title: 'Select User\'s Insurance Company',
                                label: 'Select User\'s Insurance Company',
                                popUpBody: BlocConsumer<AppBloc, AppState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Select User\'s Insurance Company',
                                              style: TextStyle(fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                  fontSize: 20),),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () => context.pop(),
                                              icon: const Icon(Icons.clear),
                                            ),
                                          ],
                                        ),
                                        space20Vertical(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: PrimaryFormField(
                                                validationError: '',
                                                label: 'Car vin number',
                                                controller: appBloc.searchCarVinNumberController,
                                              ),
                                            ),
                                            space20Horizontal(),
                                            Expanded(
                                              child: InkWell(
                                                // key: selectionInsuranceCompanyKey,
                                                onTap: () {
                                                  if (appBloc.insuranceCompanies.isEmpty &&
                                                      !appBloc.isGetAllInsuranceCompanies) {
                                                    appBloc.getAllInsuranceCompanies();
                                                    return;
                                                  }
                                                  showPrimaryMenu(
                                                    context: context,
                                                    key: selectionInsuranceCompanyKey,
                                                    items: [
                                                      ...appBloc.insuranceCompanies.map(
                                                            (e) =>
                                                            PopupMenuItem(
                                                              value: 1,
                                                              child: Text(
                                                                e.arName!,
                                                                style: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .displaySmall!
                                                                    .copyWith(
                                                                  fontSize: 16.0,
                                                                  color: secondaryGrey,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                appBloc.selectedInsuranceComp = e;
                                                                appBloc.selectedInsuranceCompController
                                                                    .text = e.arName!;
                                                              },
                                                            ),
                                                      ),
                                                    ],
                                                  );
                                                  // }
                                                },
                                                child: PrimaryFormField(
                                                  key: selectionInsuranceCompanyKey,
                                                  enabled: false,
                                                  controller: appBloc.selectedInsuranceCompController,
                                                  validationError: 'Select insurance company',
                                                  label: 'Insurance Company*',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        space20Vertical(),
                                        PrimaryButton(
                                          text: 'Search Car',
                                          isDisabled: appBloc.isSearchCarByVinNumberLoading,
                                          isLoading: appBloc.isSearchCarByVinNumberLoading,
                                          onPressed: () => appBloc.searchCarByVinNumber(),
                                        ),
                                        space20Vertical(),

                                        const PrimaryDividerText(text: 'cars'),
                                        space20Vertical(),

                                        if (appBloc.searchCarByVinNumberResponseModel?.cars != null &&
                                            appBloc.searchCarByVinNumberResponseModel!.cars!
                                                .isNotEmpty) CarSelectionBodyPopup(
                                          carsDataList: appBloc.searchCarByVinNumberResponseModel!.cars!,
                                          onConfirmSelection: () {
                                            if (appBloc.selectedUserCar != null) {
                                              HelpooInAppNotification.showSuccessMessage(
                                                  message: 'Car selected successfully');
                                              showPrimaryPopUp(
                                                context: context,
                                                isDismissible: false,
                                                title: 'Create New User',
                                                popUpBody: CreateNewUserBodyPopup(
                                                  onClickCreate: () {
                                                    appBloc.createUser();
                                                  },
                                                ),
                                              );
                                            } else {
                                              HelpooInAppNotification.showErrorMessage(message: 'Please select a car');
                                            }
                                          },
                                        )
                                        else
                                          if (appBloc.isSearchCarByVinNumberLoading) const Center(
                                            child: CupertinoActivityIndicator(),)
                                          else
                                            const Center(child: Text('No cars yet')),

                                        space20Vertical(),

                                      ],
                                    );
                                  }
                                ),
                              ),
                            ),
                          ),
                        ),
                        space10Horizontal(),

                        SizedBox(
                          width: 100,
                          child: PrimaryButton(
                            text: 'Refresh',
                            onPressed: () {
                              appBloc.getAllUsers();
                            },
                          ),
                        ),
                        space10Horizontal(),

                        if (userRoleName == Rules.Super.name)
                          SizedBox(
                            width: 300,
                            child: PrimaryButton(
                              text: 'Create New User',
                              onPressed: () {
                                showPrimaryPopUp(
                                  context: context,
                                  isDismissible: false,
                                  title: 'Create New User',
                                  popUpBody: CreateNewUserBodyPopup(
                      onClickCreate: () {
                        appBloc.createUser();
                      },
                    ),

                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    // tableHeaderRow: TablesHeader.tableHeader(
                    //   context: context,
                    //   centeredIndexes: [
                    //     0,
                    //     1,
                    //     2,
                    //     3,
                    //     4,
                    //     5,
                    //     6,
                    //   ],
                    //   columnsTitles: [
                    //     'ID',
                    //     'Name',
                    //     'Phone Number',
                    //     'User Name',
                    //     'Type',
                    //     'Blocked',
                    //     'Created At',
                    //   ],
                    // ),
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 8 * appBloc.widgetWidth),
                      1: FixedColumnWidth(1.5 / 8 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1.5 / 8 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1 / 8 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1 / 8 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 8 * appBloc.widgetWidth),
                      6: FixedColumnWidth(1 / 8 * appBloc.widgetWidth),
                      7: FixedColumnWidth(0.5 / 8 * appBloc.widgetWidth),
                    },
                    tableRows: usersTableRows(),
                    paginationWidget: TablePaginationBar(
                      onCallAnotherPage: (int page) {},
                      items: appBloc.isSearchingUserByPhone
                          ? [appBloc.searchUsersByPhoneResponseModel?.user]
                          : appBloc.usersModel?.users ?? [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TableRow tableItem({
    required Users userModel,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: borderGrey,
        ),
      )),
      children: [
        TableTextItem(
          text: userModel.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: userModel.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: userModel.phoneNumber ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: userModel.username ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: userModel.role?.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: userModel.blocked?.toString() ?? 'false',
          isCentered: true,
        ),
        TableTextItem(
          text: DateFormat('dd MMM yyyy hh:mm a')
              .format(DateTime.parse(userModel.createdAt ?? '')),
          isCentered: true,
        ),
        TableIconItem(
          icon: Icons.remove_red_eye,
          onTap: () {
            appBloc.setSelectedServiceRequestId(
              id: userModel.id,
              isForActiveService: false,
            );
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: Center(
                child: appBloc.isSearchingUserByPhone
                  ? UserDetailsWidget(userModel: userModel, isFromSearch: true, searchedUserModel: appBloc.searchUsersByPhoneResponseModel)
                  : UserDetailsWidget(userModel: userModel),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget emptyCase() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          space40Vertical(),
          Text(
            'There Is No Users Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          space40Vertical(),
          SizedBox(
            width: 300,
            child: PrimaryButton(
              text: 'Create New User',
              onPressed: () {
                showPrimaryPopUp(
                  context: context,
                  isDismissible: false,
                  title: 'Create New User',
                  popUpBody: CreateNewUserBodyPopup(
                    onClickCreate: () {
                      appBloc.createUser();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
