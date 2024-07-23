import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/primary_button.dart';
import 'report_column_item.dart';

class SaveColumnsPopupBody extends StatelessWidget {
  const SaveColumnsPopupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is SaveNewFixedColumnsSuccessState) {
          appBloc.getSavedFixedColumns();
          Navigator.pop(context);
          HelpooInAppNotification.showSuccessMessage(
              message: 'Columns Saved Successful');
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 350,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Fixed Columns',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    space10Vertical(),
                    // SizedBox(
                    //   height: 400,
                    //   child: ListView.separated(
                    //     itemCount: appBloc.getNotSavedColumns().length,
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) {
                    //       return ReportColumnItemWidget(
                    //         title: appBloc.getNotSavedColumns()[index],
                    //         isSelected: appBloc.isColumnExist(
                    //             appBloc.getNotSavedColumns()[index]),
                    //         onTap: () {
                    //           appBloc.addNewExcelColumn(
                    //               appBloc.getNotSavedColumns()[index]);
                    //         },
                    //       );
                    //     },
                    //     separatorBuilder: (context, index) => space10Vertical(),
                    //   ),
                    // ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...appBloc.reportExistingColumns.map((e) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReportColumnItemWidget(
                                title: e,
                                isSelected:
                                    appBloc.savedColumnsNames.contains(e),
                                onTap: () {
                                  appBloc.addNewFixedColumn(e);
                                },
                              ),
                              space10Vertical(),
                            ],
                          );
                        }),
                      ],
                    ),
                    space10Vertical(),
                    SizedBox(
                      width: 350,
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              text: 'Save',
                              onPressed: () {
                                appBloc.saveNewFixedColumnsToLocal();
                              },
                            ),
                          ),
                          space10Horizontal(),
                          Expanded(
                            child: PrimaryButton(
                              text: 'Cancel',
                              backgroundColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
