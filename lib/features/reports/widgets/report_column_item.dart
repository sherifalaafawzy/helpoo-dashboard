import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';

class ReportColumnItemWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;
  const ReportColumnItemWidget(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.white,
                border: Border.all(
                  color:
                      isSelected ? Theme.of(context).primaryColor : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    )
                  : const SizedBox()),
          space10Horizontal(),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color:
                      isSelected ? Theme.of(context).primaryColor : Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
