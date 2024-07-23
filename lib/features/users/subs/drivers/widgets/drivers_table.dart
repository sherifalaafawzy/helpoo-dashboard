import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/models/users/users_model.dart';
import '../../../../../core/util/constants.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/cubit/state.dart';
import '../../../../../core/util/widgets/primary_button.dart';
import '../../../../../core/util/widgets/primary_padding.dart';
import '../../../../../core/util/widgets/show_pop_up.dart';
import '../../../../../core/util/widgets/tables/components/table_header.dart';
import '../../../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../../../core/util/widgets/tables/table_widget.dart';
import '../../../widgets/create_new_user.dart';
import 'package:intl/intl.dart';

class DriversTable extends StatefulWidget {
  const DriversTable({super.key});

  @override
  State<DriversTable> createState() => _DriversTableState();
}

class _DriversTableState extends State<DriversTable> {
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
        ],
        columnsTitles: [
          'ID',
          'Name',
          'Phone Number',
          'User Name',
          'Type',
          'Blocked',
          'Created At',
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
    appBloc.itemsSubList = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (appBloc.driversUsersList.isEmpty) {
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
                          'Drivers',
                          style: Theme.of(context).textTheme.titleLarge,
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
                      1: FixedColumnWidth(2 / 8 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1.5 / 8 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1 / 8 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1 / 8 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 8 * appBloc.widgetWidth),
                      6: FixedColumnWidth(1 / 8 * appBloc.widgetWidth),
                    },
                    tableRows: usersTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.driversUsersList,
                      onCallAnotherPage: (int page) {},
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
              text: 'Creat New User',
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
