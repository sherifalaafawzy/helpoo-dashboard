import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';
import 'package:hexcolor/hexcolor.dart';

class SideMenuListTile extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;
  final IconData? leadingIcon;
  final String? trailing;
  final bool isSelected;
  final bool hideIcon;
  final bool hideTrailing;
  final bool collapsed;

  const SideMenuListTile({
    super.key,
    required this.onTap,
    required this.title,
    this.leadingIcon,
    this.trailing,
    this.isSelected = false,
    this.hideIcon = false,
    this.hideTrailing = true,
    this.collapsed = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 20,
      onTap: onTap,
      textColor: Colors.white,
      iconColor: Colors.white,
      selected: isSelected,
      selectedTileColor: HexColor(mainColor).withOpacity(0.2),
      selectedColor: HexColor(mainColor),
      hoverColor: Colors.grey.shade500,
      contentPadding: EdgeInsets.symmetric(
        horizontal: collapsed ? 10 : 40,
      ),
      trailing: collapsed
          ? null
          : trailing != null
              ? Text(
                  '( $trailing )',
                  style: TextStyle(
                      color: hideTrailing ? Colors.transparent : Colors.white),
                )
              : null,
      leading: leadingIcon != null
          ? Icon(leadingIcon,
              color: hideIcon ? Colors.transparent : Colors.white)
          : null,
      title: collapsed
          ? null
          : Text(
              title,
            ),
    );
  }
}
