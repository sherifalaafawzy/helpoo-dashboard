import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';

class VehicleTypeItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String imageName;
  final String title;
  final String price;
  const VehicleTypeItem(
      {super.key,
      required this.onTap,
      required this.isSelected,
      required this.imageName,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return InkWell(
          onTap: onTap,
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey,
                width: isSelected ? 3.0 : 1.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/$imageName.png',
                  fit: BoxFit.cover,
                ),
                space10Vertical(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                ),
                space5Vertical(),
                Text(
                  'Price: EGP $price',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
