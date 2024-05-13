import 'package:flutter/material.dart';
import 'package:flutter_application/consts/enums.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:provider/provider.dart';

class CustomDropdown extends StatelessWidget {
  final EnumDropdown enumDropdown;
  final String defaultText;

  const CustomDropdown({
    super.key,
    required this.enumDropdown,
    required this.defaultText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, MainProvider model, child) {
        return SizedBox(
          width: 200,
          child: DropdownMenu(
            enableSearch: false,
            requestFocusOnTap: false,
            expandedInsets: const EdgeInsets.all(0),
            menuHeight: 300,
            label: Text(defaultText),
            dropdownMenuEntries: _getEntriesByType(enumDropdown, model),
            onSelected: (value) {
              model.changeDropdownValue(enumDropdown, value);
            },
          ),
        );
      },
    );
  }

  List<DropdownMenuEntry<Object>> _getEntriesByType(
      EnumDropdown enumDropdown, MainProvider model) {
    switch (enumDropdown) {
      case EnumDropdown.channelType:
        return model.channelTypes;
      case EnumDropdown.channel:
        return model.channels;
      case EnumDropdown.issue:
        return model.issues;
      case EnumDropdown.dossier:
        return model.dossiers;
      default:
        return [];
    }
  }
}
