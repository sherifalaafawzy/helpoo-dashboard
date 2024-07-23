import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

part 'tables_state.dart';

TablesCubit get tablesCubit => TablesCubit.get(navigatorKey.currentContext!);

class TablesCubit extends Cubit<TablesState> {
  TablesCubit() : super(TablesInitial());

  static TablesCubit get(context) => BlocProvider.of(context);

  // initial status

  String status = 'غير محددة';

  // status list

  // initial items per page

  String itemsPerPage = '5';

  // items per page list

  final List<String> itemsCountPerPage = [
    '5',
    '10',
    '20',
    '30',
    '40',
  ];

// change status function
  void changeStatus(String newStatus) {
    status = newStatus;
    updateTableItemsSubListBasedOnItemsStatus(tableItems);
    emit(ChangeTableStatus());
  }

// change items per page function

  void changeItemsPerPage(String newItemsPerPage) {
    itemsPerPage = newItemsPerPage;

    currentPage = 0;

    updateTableItemsSubList();
    emit(ChangeTableItemPerPage());
  }

// search controller

  final TextEditingController searchController = TextEditingController();

// search value change function to change the state of the table to update the search value
  void onSearchValueChange() {
    emit(ChangeTableSearchValue());
  }

  ///* table items search *///

  // void updateSearchValue() {
  //   // filter the table items list based on the search value
  //   tableItems = DummyData.tableItems
  //       .where((element) => element.itemEnglishName!
  //           .toLowerCase()
  //           .contains(searchController.text.toLowerCase()))
  //       .toList();

  //   // update the total items
  //   totalItems = tableItems.length;

  //   // update the table items sub list
  //   updateTableItemsSubList();
  // }

// clear search value function to clear the search value and change the state of the table to update the search value

  void clearSearchValue() {
    searchController.clear();
    emit(ClearSearchValueSuccess());
  }

  // check if table is empty or not

  bool get isTableEmpty => tableItemsSubList.isEmpty;

  ///* table items pagination *///

  // table items list
  List<dynamic> tableItems = [];

  // total items
  int totalItems = 0;

  // total pages
  int totalPages = 0;

  // current page
  int currentPage = 0;

  // pages numbers list
  List<int> pagesNumbers = [];

  // items sub list to show in the table based on items per page and current page
  // this list will be updated when the items per page or current page changes
  // or when the search value changes
  // or when the status changes
  // or when the table items list changes

  List<dynamic> tableItemsSubList = [];

  // update table items sub list function
  // this function will be called when the items per page or current page changes

  int startIndex = 0;

  int endIndex = 0;

  void updateTableItemsSubList({List<dynamic>? items}) {
    // calculate the total items

    tableItems = items ?? tableItems;

    totalItems = tableItems.length;

    debugPrint(
        'updateTableItemsSubList: ----->${(items ?? tableItems).length}');

    // calculate the total pages
    totalPages = (totalItems / int.parse(itemsPerPage)).ceil();

    // update the pages numbers list

    pagesNumbers = List.generate(totalPages, (index) => index + 1);

    // calculate the start index of the sub list
    startIndex = (currentPage) * int.parse(itemsPerPage);

    // calculate the end index of the sub list
    endIndex = startIndex + int.parse(itemsPerPage);

    // check if the end index is greater than the total items
    // if it is greater then set the end index to the total items
    if (endIndex > totalItems) {
      endIndex = totalItems;
    }
    //
    // debugPrint('startIndex: $startIndex');
    // debugPrint('endIndex: $endIndex');
    // debugPrint('tableItems: ${tableItems.length}');
    // debugPrint('tableItemsSubList: ${tableItemsSubList.length}');

    // update the table items sub list
    tableItemsSubList = tableItems.sublist(startIndex, endIndex);

    debugPrint('tableItemsSubList: ${tableItemsSubList.length}');

    // emit the change table items sub list state
    emit(ChangeTableItemsSubList());
  }

  void updateTableItemsSubListBasedOnItemsStatus(List<dynamic> items) {
    // filter the table items list based on the status
    if (status == 'غير محددة') {
      tableItems = items;
    } else {
      tableItems =
          items.where((element) => element.itemStatus == status).toList();
    }

    // update the total items
    totalItems = tableItems.length;

    // update the table items sub list
    updateTableItemsSubList();
  }

  // change current page function

  void changeCurrentPage(int newCurrentPage) {
    currentPage = newCurrentPage;
    updateTableItemsSubList();

    // emit the change current page state

    emit(ChangeTableCurrentPage());
  }

  // check if current page selected function

  bool isCurrentPageSelected(int pageIndex) {
    return currentPage == pageIndex;
  }

  // check if the next page is disabled function

  bool isNextPageDisabled() {
    return currentPage == totalPages - 1;
  }

  // check if the previous page is disabled function

  bool isPreviousPageDisabled() {
    return currentPage == 0;
  }

  // go to next page function

  void goToNextPage() {
    if (!isNextPageDisabled()) {
      currentPage++;
      updateTableItemsSubList();
      emit(ChangeTableCurrentPage());
    }
  }

  // go to previous page function

  void goToPreviousPage() {
    if (!isPreviousPageDisabled()) {
      currentPage--;
      updateTableItemsSubList();
      emit(ChangeTableCurrentPage());
    }
  }

  // go to page by index function

  void goToPageByIndex(int pageIndex) {
    currentPage = pageIndex;
    updateTableItemsSubList();
    emit(ChangeTableCurrentPage());
  }

  ///* filter items by date range *///

  // date range start date
  DateTime? startDate;

  // date range end date

  DateTime? endDate;

  // update date range function

  // void updateDateRange({DateTime? newStartDate, DateTime? newEndDate}) {
  //   startDate = newStartDate;
  //   endDate = newEndDate;

  //   // filter the table items list based on the date range
  //   tableItems = DummyData.tableItems
  //       .where((element) =>
  //           element.itemDate!.isAfter(startDate!) &&
  //           element.itemDate!.isBefore(endDate!))
  //       .toList();

  //   // update the total items
  //   totalItems = tableItems.length;

  //   // update the table items sub list
  //   updateTableItemsSubList();
  //   // emit the change date range state
  //   emit(ChangeTableDateRange());
  // }

  ///* clear filter items by date range *///

  // clear date range function

  void clearDateRange() {
    startDate = null;
    endDate = null;

    // emit the change date range state
    emit(ChangeTableDateRange());
  }

  ///* Change Item status *///

  void changeItemStatus(
      {required String itemNumber, required String newStatus}) {
    tableItems
        .where((element) => element.itemNumber == itemNumber)
        .first
        .itemStatus = newStatus;
    updateTableItemsSubListBasedOnItemsStatus(tableItems);
    emit(ChangeTableItemStatus());
  }

  ///* table items sort *///

  // sort by item Status function

  bool isSortByStatusDescending = false;

  void sortByItemStatus() {
    debugPrint('is sort by status descending: $isSortByStatusDescending');
    if (isSortByStatusDescending) {
      sortByItemStatusAscending();
    } else {
      sortByItemStatusAscending();
    }

    emit(ChangeTableSort());
  }

  // sort by item Status ascending function

  void sortByItemStatusAscending() {
    // sort the table items list based on the item Status
    tableItems.sort((a, b) => a.itemStatus!.compareTo(b.itemStatus!));

    // update the table items sub list
    updateTableItemsSubList();
    debugPrint('sort by status ascending');
    isSortByStatusDescending = true;
    emit(ChangeTableSort());
  }

  // sort by item Status descending function

  void sortByItemStatusDescending() {
    // sort the table items list based on the item Status
    tableItems.sort((a, b) => b.itemStatus!.compareTo(a.itemStatus!));

    // update the table items sub list
    updateTableItemsSubList();
    debugPrint('sort by status descending');
    isSortByStatusDescending = false;
    emit(ChangeTableSort());
  }

  // add selection on selection popup function

  dynamic _selectedTableItem;

  dynamic get getSelectedTableItem => _selectedTableItem;

  void setSelectedTableItem<T>({required T tableItem}) {
    _selectedTableItem = tableItem;

    // debugPrintFullText((_selectedTableItem as ProductModel).toJson().toString());

    if (!isSingleItemSelected) {
      isSingleItemSelected = true;
    }

    debugPrint('isSingleItemSelected: $isSingleItemSelected');

    emit(ChangeTableSelectedItem());
  }

  List selectedTableItems = [];

  void clearSelectedTableItems() {
    selectedTableItems.clear();
    emit(ChangeTableSelectedItem());
  }

  void multiSelectItems<T>({
    required T tableItem,
  }) {
    if (selectedTableItems.contains(tableItem)) {
      selectedTableItems.remove(tableItem);
    } else {
      selectedTableItems.add(tableItem);
    }

    debugPrint('selected items: ${selectedTableItems.length}');

    emit(ChangeTableSelectedItem());
  }

  //check if single item is selected function

  bool _isSingleItemSelected = false;

  bool get isSingleItemSelected => _isSingleItemSelected;

  set isSingleItemSelected(bool value) {
    _isSingleItemSelected = value;
    emit(IsSingleItemSelectedState());
  }

  // void isSingleItemSelectedFunction() {
  //   if (_selectedTableItem == null) {
  //     isSingleItemSelected = false;
  //   } else {
  //     if (tableItemsSubList.contains(getSelectedTableItem)) {
  //       isSingleItemSelected = true;
  //     } else {
  //       isSingleItemSelected = false;
  //     }
  //   }
  //   emit(IsSingleItemSelectedState());
  // }

  TextEditingController arabicNameController = TextEditingController();

  TextEditingController englishNameController = TextEditingController();

  ///* categories and properties pop-ups logic *///
  ///***************************************************************************///

  void printCategoriesAndPropertiesEnteredValues() {
    debugPrint(
        'entered values is :${arabicNameController.text} ${englishNameController.text}');
  }

  ///* sales pop-ups logic *///
  ///***************************************************************************///

  TextEditingController discountCodeController = TextEditingController();

  TextEditingController discountPercentageController = TextEditingController();

  TextEditingController selectedDateController = TextEditingController();

  String _usage = '';

  set setUsage(String newUsage) {
    _usage = newUsage;
    emit(ChangeUsageState());
  }

  void printSalesEnteredValues() {
    selectedDateController.text = '$startDate - $endDate';

    debugPrint('entered arabicName is :${arabicNameController.text}');

    debugPrint('entered englishName is :${englishNameController.text}');

    debugPrint('entered discountCode is :${discountCodeController.text}');
    debugPrint(
        'entered discountPercentage is :${discountPercentageController.text} %');

    debugPrint('entered usage is :$_usage');

    debugPrint('entered date is :${selectedDateController.text}');

    debugPrint('entered isPopupItemActive is :$isPopupItemActive');
  }

  bool isPopupItemActive = false;

  void changePopupItemActiveState() {
    isPopupItemActive = !isPopupItemActive;
    emit(ChangePopupItemActiveState());
  }
}
