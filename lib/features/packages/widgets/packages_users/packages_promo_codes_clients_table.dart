import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/promo_code_users_model.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/back_button_widget.dart';
import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/primary_padding.dart';
import '../../../../core/util/widgets/tables/components/table_header.dart';
import '../../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../../core/util/widgets/tables/table_widget.dart';

class PackagesPromoCodesClientsTable extends StatefulWidget {
  const PackagesPromoCodesClientsTable({
    super.key,
  });

  @override
  State<PackagesPromoCodesClientsTable> createState() =>
      _PackagesPromoCodesClientsTableState();
}

class _PackagesPromoCodesClientsTableState
    extends State<PackagesPromoCodesClientsTable> {
  // pagination logic

  List<TableRow> packagesClientsTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(
        tableItem(
          client: element,
        ),
      );
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
        ],
        columnsTitles: [
          'ID',
          'Name',
          'Phone number',
          'Role',
          'Promo code',
          'Created at',
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
        if (appBloc.promoCodeUsersModel?.promoes?.isEmpty ?? true) {
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
                        const BackButtonWidget(),
                        space10Horizontal(),
                        Text(
                          'Package Promo Codes Users ${appBloc.selectedPromoName != null ? '(${appBloc.selectedPromoName})' : ''} ',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        SizedBox(
                            width: 150,
                            child: PrimaryButton(
                                text: 'Export',
                                onPressed: () {
                                  appBloc.exportNormalPromoCodeUsersSheet(
                                      isForNormalPromoCode: false);
                                })),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 9 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 9 * appBloc.widgetWidth),
                      2: FixedColumnWidth(2 / 9 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      4: FixedColumnWidth(2 / 9 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1.5 / 9 * appBloc.widgetWidth),
                    },
                    tableRows: packagesClientsTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.promoCodeUsersModel?.promoes ?? [],
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
    required Promoes client,
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
          text: client.id.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: client.user?.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: client.user?.phoneNumber ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: appBloc.getRoleNameBasedOnRoleId(client.user?.roleId ?? -1),
          isCentered: true,
        ),
        TableTextItem(
          text: client.packagePromoCode?.value ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: client.createdAt ?? '',
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
          const Spacer(),
          const BackButtonWidget(),
          space10Vertical(),
          Text(
            'There is no users yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
