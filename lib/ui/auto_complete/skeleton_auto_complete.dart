import 'package:flutter/material.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/utils/localizer.dart';

class SkeletonAutoComplete extends StatelessWidget {
  const SkeletonAutoComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: Designer.outlinedTextFieldDisabled(
            label: Localizer.i.text('please_wait'),
            icon: Icons.space_dashboard));
  }
}
