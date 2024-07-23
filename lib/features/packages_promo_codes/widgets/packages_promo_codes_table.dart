import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/packages_promo_codes_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/loading_popup.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../../core/util/widgets/tables/components/package_table_more_widget.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import '../../packages/widgets/packages_users/packages_promo_codes_clients_table.dart';
import 'packages_promo_codes_details_screen.dart';

class PackagesPromoCodesTable extends StatefulWidget {
  const PackagesPromoCodesTable({super.key});

  @override
  State<PackagesPromoCodesTable> createState() =>
      _PackagesPromoCodesTableState();
}

class _PackagesPromoCodesTableState extends State<PackagesPromoCodesTable> {
  // pagination logic

  List<TableRow> promoCodesTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(
        tableItem(
          promoCode: element,
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
          6,
          7,
          8,
        ],
        columnsTitles: [
          'ID',
          'Name',
          'Value',
          'Start Date',
          'Expiry Date',
          'Percentage',
          'Created At',
          'Corporate Company',
          'Actions',
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
      listener: (context, state) {
        if (state is GetPromoCodeUsersSuccessState) {
          context.pop;
          appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: const PackagesPromoCodesClientsTable());
        }

        if (state is GetPromoCodeUsersLoadingState) {
          showPrimaryPopUp(
            context: context,
            isDismissible: false,
            title: 'Show Loading',
            popUpBody: const LoadingPopup(),
          );
        }

        if (state is GetPromoCodeUsersErrorState) {
          context.pop;
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }
      },
      builder: (context, state) {
        if (appBloc.allPackagesPromoCodes?.promoes?.isEmpty ?? true) {
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
                          'Packages Promo Codes',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 13 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 13 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1 / 13 * appBloc.widgetWidth),
                      3: FixedColumnWidth(2 / 13 * appBloc.widgetWidth),
                      4: FixedColumnWidth(2 / 13 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 13 * appBloc.widgetWidth),
                      6: FixedColumnWidth(2 / 13 * appBloc.widgetWidth),
                      7: FixedColumnWidth(1.5 / 13 * appBloc.widgetWidth),
                      8: FixedColumnWidth(1 / 13 * appBloc.widgetWidth),
                    },
                    tableRows: promoCodesTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.allPackagesPromoCodes?.promoes ?? [],
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
    required Promoes promoCode,
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
          text: promoCode.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: promoCode.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: promoCode.value?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: promoCode.startDate ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: promoCode.expiryDate ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: '${promoCode.percentage} %',
          isCentered: true,
        ),
        TableTextItem(
          text: promoCode.createdAt ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: promoCode.corporateCompany?.enName ?? '',
          isCentered: true,
        ),
        PackageTableMoreWidget(
          onViewTap: () {
            appBloc.changeStackNav(
                index: appBloc.currentSideMenuIndex,
                isAdd: true,
                widget: PackagesPromoCodesDetailsScreen(
                  promoCode: promoCode,
                ));
          },
          onUsersTap: () {
            appBloc.selectedPromoCodeId = promoCode.id!;
            appBloc.selectedPromoName = promoCode.name!;
            appBloc.getPromoCodeUsers(isFromPackagePage: false);
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
          const Spacer(),
          Text(
            'There is no promo codes yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
