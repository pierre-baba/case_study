import 'package:flutter/material.dart';

class AppBarPopupMenu extends StatelessWidget {
  final Function(String) onUnitSelected;

  const AppBarPopupMenu({super.key, required this.onUnitSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: onUnitSelected,
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'switch_unit',
          child: Text('Switch Unit'),
        ),
      ],
    );
  }
}
