import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import 'edit_setting_popup_body.dart';
import 'setting_type_item.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingsMainWidget extends StatefulWidget {
  const SettingsMainWidget({super.key});

  @override
  State<SettingsMainWidget> createState() => _SettingsMainWidgetState();
}

class _SettingsMainWidgetState extends State<SettingsMainWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (appBloc.isGettingSettingTypesLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
              space20Vertical(),
              Expanded(
                child: GridView.builder(
                  itemCount: appBloc.settingTypesModel!.types!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                  ),
                  itemBuilder: (context, index) {
                    return SettingTypeItem(
                      name: appBloc.settingTypesModel!.types![index].enName!,
                      baseCost: appBloc
                          .settingTypesModel!.types![index].baseCost!
                          .toString(),
                      costPerKm: appBloc
                          .settingTypesModel!.types![index].costPerKm!
                          .toString(),
                      onPressed: () {
                        appBloc.selectedSettingType =
                            appBloc.settingTypesModel!.types![index];
                        showPrimaryPopUp(
                          context: context,
                          width: 800,
                          popUpBody: const EditSettingPopupBody(),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
