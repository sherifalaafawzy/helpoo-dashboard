import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/state.dart';

class TablesHeader {
  static TableRow tableHeader({
    required BuildContext context,
    required List<int> centeredIndexes,
    required List<String> columnsTitles,
    List<bool>? isWithSort,
    List<VoidCallback>? onSort,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        color: borderGrey,
      ),
      children: [
        for (var i = 0; i < columnsTitles.length; i++)
          TableRowTitle(
            title: columnsTitles[i],
            isWithSort: isWithSort?[i] ?? false,
            onSort: onSort?[i] ?? () {},
            isCentered: centeredIndexes.isEmpty ? true : centeredIndexes.contains(i),
          ),
      ],
    );
  }
}

class TableRowTitle extends StatelessWidget {
  final String title;

  final bool isCentered;
  final bool isWithSort;
  final VoidCallback onSort;

  const TableRowTitle({
    super.key,
    required this.title,
    this.isCentered = true,
    this.isWithSort = false,
    required this.onSort,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: isCentered ? TextAlign.center : TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (isWithSort) ...{
                  // space5Horizontal(),

                  //add in end of this row

                  BlocBuilder<AppBloc, AppState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: onSort,
                        child: Icon(
                          (appBloc.isDESCSotring && title == appBloc.sortingByMap[appBloc.selectedSortingBy])
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: ((appBloc.isSortByDate || appBloc.isSortById || appBloc.isSortByFees) &&
                                  title == appBloc.sortingByMap[appBloc.selectedSortingBy])
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          size: 20,
                        ),
                      );
                    },
                  ),
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}
