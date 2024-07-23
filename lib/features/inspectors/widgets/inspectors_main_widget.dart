import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import 'company_inspectios_table.dart';
import 'create_new_inspector_widget.dart';
import 'inspectors_table.dart';
import 'package:hexcolor/hexcolor.dart';

class InspectorsMainWidget extends StatelessWidget {
  const InspectorsMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.getAllInspectorsLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }

        return PrimaryPadding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              space25Vertical(),
              SizedBox(
                width: 1122,
                child: Row(
                  children: [
                    Text(
                      appTranslation(context).inspectors,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 200,
                      child: PrimaryButton(
                        text: appTranslation(context).createNew,
                        onPressed: () {
                          showPrimaryPopUp(
                            context: context,
                            width: 1122,
                            isDismissible: false,
                            title: appTranslation(context).createNew,
                            popUpBody: const CreateNewInspector(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (userRoleName == Rules.Insurance.name) ...{
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        space25Vertical(),
                        TabBar(
                          isScrollable: true,
                          indicatorColor: HexColor(mainColor),
                          indicatorWeight: 3,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 200),
                          unselectedLabelColor: Colors.grey,
                          labelColor: HexColor(mainColor),
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: HexColor(mainColor),
                              ),
                              insets:
                                  const EdgeInsets.symmetric(horizontal: 30.0)),
                          tabs: [
                            Tab(
                                child: Text(
                              "Individual",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 26),
                            )),
                            Tab(
                              child: Text(
                                "Companies",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 26),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 1122,
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TabBarView(
                              children: [
                                InspectorsTable(),
                                CompanyInspectionsTable(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              } else ...{
                const InspectorsTable(),
              }
            ],
          ),
        );
      },
    );
  }
}
