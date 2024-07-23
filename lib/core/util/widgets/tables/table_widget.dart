import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_scroll_behavior.dart';
import '../../constants.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import 'package:measured_size/measured_size.dart';

class PrimaryTableWidget extends StatefulWidget {
  final Map<int, TableColumnWidth> columnWidths;
  final List<TableRow> tableRows;
  // final TableRow tableHeaderRow;
  final Widget paginationWidget;

  const PrimaryTableWidget({
    super.key,
    required this.columnWidths,
    required this.tableRows,
    // required this.tableHeaderRow,
    required this.paginationWidget,
  });

  @override
  State<PrimaryTableWidget> createState() => _PrimaryTableWidgetState();
}

class _PrimaryTableWidgetState extends State<PrimaryTableWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MeasuredSize(
          onChange: (Size size) {
            debugPrint('Measured size: ${size.width}');
            appBloc.setWidgetWidth(size.width);
          },
          child: Container(
            width: appBloc.getWidgetWidth(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //   color: borderGrey,
              // ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScrollConfiguration(
                  behavior: AppScrollBehavior(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: widget.columnWidths,
                      children: widget.tableRows,
                    ),
                  ),
                ),
                widget.paginationWidget,
              ],
            ),
          ),
        );
      },
    );
  }
}
