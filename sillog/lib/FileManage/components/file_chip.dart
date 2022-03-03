import 'package:flutter/material.dart';
import 'package:sillog/utils/utils.dart';

class SLG_Chips {
  SLG_Chips();

  static ChoiceChip getFileChip({
    required bool isChecked,
    required Function(bool) onSelected,
    required String label,
  }) {
    return ChoiceChip(
      label: isChecked
          ? Container(
              width: 40,
              child: Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              width: 40,
              child: Text(
                label,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
      selected: isChecked,
      shape: StadiumBorder(side: BorderSide(color: SLG_COLOR)),
      pressElevation: 5,
      backgroundColor: Colors.white,
      selectedColor: SLG_COLOR,
      onSelected: onSelected,
    );
  }
}
