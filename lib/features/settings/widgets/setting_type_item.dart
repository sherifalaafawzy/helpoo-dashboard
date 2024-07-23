import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/widgets/primary_button.dart';

class SettingTypeItem extends StatelessWidget {
  final String name;
  final String baseCost;
  final String costPerKm;
  final VoidCallback onPressed;
  const SettingTypeItem({
    super.key,
    required this.name,
    required this.baseCost,
    required this.costPerKm,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Name: $name',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
          ),
          space10Vertical(),
          Text(
            'Base Cost: $baseCost',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
          ),
          space10Vertical(),
          Text(
            'Cost Per KM: $costPerKm',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
          ),
          space10Vertical(),
          SizedBox(
            width: 200,
            child: PrimaryButton(
              text: 'Edit',
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
