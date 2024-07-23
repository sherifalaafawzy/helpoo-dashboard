import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/state.dart';
import '../../primary_pop_up_menu.dart';

class TablePaginationBar extends StatefulWidget {
  final List<dynamic> items;
  final Function(int) onCallAnotherPage;
  final int pages;
  final bool isLoading;

  const TablePaginationBar({
    super.key,
    required this.items,
    required this.onCallAnotherPage,
    this.pages = 0,
    this.isLoading = false,
  });

  @override
  State<TablePaginationBar> createState() => _TablePaginationBarState();
}

class _TablePaginationBarState extends State<TablePaginationBar> {
  int currentPage = 1;

  int itemsPerPage = 10;

  int totalItems = 0;

  int totalPages = 0;

  int startItem = 0;

  int endItem = 0;

  List<int> pages = [];

  bool isLastPage = false;

  bool isFirstPage = false;

  List<int> handlePaginationBar() {
    List<int> pagesToShow = [];
    if (totalPages <= 5) {
      pagesToShow = pages;
    } else {
      if (currentPage <= 3) {
        pagesToShow = pages.sublist(0, 5);
        pagesToShow[4] = totalPages;
      } else if (currentPage >= totalPages - 2) {
        pagesToShow = pages.sublist(totalPages - 5, totalPages);
        pagesToShow[0] = 1;
      } else {
        pagesToShow = pages.sublist(currentPage - 3, currentPage + 2);
        pagesToShow[0] = 1;
        pagesToShow[4] = totalPages;
      }
    }
    return pagesToShow;
  }

  void paginate() {
    totalItems = widget.items.length;
    debugPrint('Pagination totalItems: $totalItems');
    if (widget.pages != 0) {
      totalPages = widget.pages;
    } else {
      totalPages = (totalItems / itemsPerPage).ceil();
    }

    startItem = (currentPage - 1) * itemsPerPage;
    endItem = startItem + itemsPerPage;

    pages = List.generate(totalPages, (index) => index + 1);
    if (endItem > totalItems) {
      endItem = totalItems;
    }
    if (startItem == 0) {
      isFirstPage = true;
    } else {
      isFirstPage = false;
    }

    if (endItem == totalItems) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }

    // pass the sub list to the table
    appBloc.getSubList(list: widget.pages == 0 ? widget.items.sublist(startItem, endItem) : widget.items);
    // itemsSubList = appBloc.policiesModel!.cars.sublist(startItem, endItem);
  }

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      widget.onCallAnotherPage(currentPage);
      paginate();
      setState(() {});
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      widget.onCallAnotherPage(currentPage);
      paginate();
      setState(() {});
    }
  }

  void goToPage(
    int page,
  ) {
    currentPage = page;
    paginate();
    setState(() {});

    if (isLastPage) {
      widget.onCallAnotherPage(currentPage);
    }
  }

  List<int> itemsPerPageList = [10, 15, 20];

  GlobalKey itemsPerPageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    paginate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is PoliciesSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(1);
          });
        }
        if (state is GetAllAdminCarsSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(currentPage);
          });
        }
        if (state is AccidentReportsSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(currentPage);
          });
        }
        if (state is GetAllAdminCarsSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(currentPage);
          });
        }
        if (state is AccidentReportsSecondSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            paginate();
            setState(() {});
          });
        }

        if (state is GetAllServiceRequestSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(currentPage);
          });
        }

        if (state is ServiceRequestsSecondSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            paginate();
            setState(() {});
          });
        }

        if (state is GetAllAdminCarsSuccessSecondState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            paginate();
            setState(() {});
          });
        }
        if (state is GetCorporateServiceRequestsSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(currentPage);
          });
        }
        if (state is AccidentReportsByStatusSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(state.isFirstTime ? 1 : currentPage);
          });
        }
        if (state is GetAllInspectorsSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(1);
          });
        }
        if (state is SearchServiceRequestSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(1);
            
          });
        }
        // if (state is GetAllServiceRequestSuccessState) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     // goToPage(currentPage);
        //   });
        // }
        if (state is SearchCorporatesState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            goToPage(currentPage);
          });
        }
      },
      builder: (context, state) {
        return Container(
          height: 50,
          decoration: const BoxDecoration(
            color: borderGrey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              if (widget.pages == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    key: itemsPerPageKey,
                    onTap: () {
                      debugPrint('show items per page');
                      showPrimaryMenu(
                        context: context,
                        key: itemsPerPageKey,
                        items: [
                          ...itemsPerPageList.map(
                            (e) => PopupMenuItem(
                              value: itemsPerPage,
                              child: Text(
                                e.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      fontSize: 16.0,
                                      color: secondaryGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              onTap: () {
                                setState(() {
                                  itemsPerPage = e;
                                  paginate();
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Items per page: $itemsPerPage',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Current Shown items ${startItem + 1} - ${widget.pages <= 1 ? endItem : startItem + 10}  of ${widget.pages == 0 ? totalItems : appBloc.totalTableItems}',
                  //widget.pages == 0 ? totalItems : appBloc.getAccidentRepoertsLength()
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              if (widget.isLoading) ...{
                const CupertinoActivityIndicator(
                  radius: 10,
                ),
                space10Horizontal(),
              },
              if (!widget.isLoading)
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        appBloc.requestCounter = 1;
                        previousPage();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: isFirstPage ? borderGrey : Colors.black,
                      ),
                      iconSize: 12.5,
                    ),
                    for (var page in handlePaginationBar())
                      InkWell(
                        onTap: () {
                          appBloc.requestCounter = 1;
                          goToPage(page);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: currentPage == page ? Colors.green : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              page.toString(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: currentPage == page ? whiteColor : Colors.grey, fontSize: 12.0),
                            ),
                          ),
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        appBloc.requestCounter = 1;
                        nextPage();
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: currentPage < totalPages ? Colors.black : borderGrey,
                      ),
                      iconSize: 12.5,
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
