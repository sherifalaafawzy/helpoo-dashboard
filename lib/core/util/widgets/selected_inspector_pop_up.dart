import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../enums.dart';
import '../extensions/build_context_extension.dart';
import 'inspector_item_card.dart';
import 'primary_button.dart';
import 'primary_form_field.dart';

class SelectInspectorPopUp extends StatefulWidget {
  const SelectInspectorPopUp({super.key});

  @override
  State<SelectInspectorPopUp> createState() => _SelectInspectorPopUpState();
}

class _SelectInspectorPopUpState extends State<SelectInspectorPopUp> {
  List<String> listSelectedItems = [];

  @override
  void initState() {
    appBloc.assignSearchList();
    appBloc.searchController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              space10Vertical(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose the Inspector',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              space10Vertical(),
              Text(
                'Search by name',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.grey.shade400),
              ),
              space10Vertical(),
              PrimaryFormField(
                validationError: '',
                label: 'Search',
                controller: appBloc.searchController,
                onChange: (value) {
                  appBloc.searchInspector();
                },
              ),
              space15Vertical(),
              Expanded(
                child: ListView.separated(
                  itemCount:
                      appBloc.selectedInspectorType == InspectorTypes.values[0]
                          ? appBloc.searchedInspectionsCompanyList.length
                          : appBloc.searchedInspectors.length,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => space10Vertical(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        appBloc.assignDate = DateTime.now().toString();
                        debugPrint('---------- assign date ${appBloc.assignDate}');
                        appBloc.selectedInspectorType ==
                                InspectorTypes.values[0]
                            ? AppBloc.get(context).inspectionCompanyModel =
                                appBloc.searchedInspectionsCompanyList[index]
                            : AppBloc.get(context).inspectorModel =
                                appBloc.searchedInspectors[index];
                      },
                      child: InspectorItemCard(
                        title: appBloc.selectedInspectorType ==
                                InspectorTypes.values[0]
                            ? appBloc.searchedInspectionsCompanyList[index]
                                    .name ??
                                ''
                            : appBloc.searchedInspectors[index].user?.name ??
                                '',
                        selected: appBloc.selectedInspectorType ==
                                InspectorTypes.values[0]
                            ? appBloc.inspectionCompanyModel ==
                                appBloc.searchedInspectionsCompanyList[index]
                            : appBloc.inspectorModel ==
                                appBloc.searchedInspectors[index],
                        // listSelectedItems.contains(AppText.arabicDays[index]),
                      ),
                    );
                  },
                ),
              ),
              space20Vertical(),
              PrimaryButton(
                text: 'Done',
                onPressed: () {
                  context.pop();
                },
              ),
              space20Vertical(),
            ],
          ),
        );
      },
    );
  }
}
