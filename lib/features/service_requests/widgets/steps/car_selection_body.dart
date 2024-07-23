import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';

import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/helpoo_in_app_notifications.dart';
import '../../../../core/util/widgets/primary_button.dart';
import 'car_selection_card.dart';

class CarSelectionBodyPopup extends StatefulWidget {
  final VoidCallback onConfirmSelection;
  final List carsDataList;

  const CarSelectionBodyPopup({required this.carsDataList, required this.onConfirmSelection, super.key});

  @override
  State<CarSelectionBodyPopup> createState() => _CarSelectionBodyPopupState();
}

class _CarSelectionBodyPopupState extends State<CarSelectionBodyPopup> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select a car',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.black)),
            space24Vertical(),
            SizedBox(
              height: 230,
              child: ListView.builder(
                itemCount: widget.carsDataList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      appBloc.selectedUserCar =
                          widget.carsDataList[index];
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CarSelectionCard(
                        title: widget.carsDataList[index].manufacturer?.enName ?? '?',
                        selected: appBloc.selectedUserCar != null && appBloc.selectedUserCar!.id == widget.carsDataList[index].id,
                        model: widget.carsDataList[index].carModel?.enName ?? '?',
                        plateNumber: widget.carsDataList[index].plateNumber ?? '?',
                      ),
                    ),
                  );
                },
              ),
            ),
            space24Vertical(),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'Confirm',
                    onPressed: () {
                      if (appBloc.selectedUserCar?.id != null) {
                        widget.onConfirmSelection();
                      } else {

                      }
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
          ],
        );
      },
    );
  }
}
