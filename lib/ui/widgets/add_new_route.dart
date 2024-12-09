import 'package:flutter/material.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/utils/localizer.dart';
import 'package:ulastir/utils/navigation_utils.dart';

class AddNewRouteButton extends StatelessWidget {
  const AddNewRouteButton({super.key, required this.updateRoutes});

  final Function updateRoutes;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        style: Designer.outlinedButton,
        icon: const Icon(Icons.alt_route_rounded),
        onPressed: () {
          NavigationUtils.openRouteDesignPage(context,
              updateRoutes: updateRoutes);
        },
        label: Text(Localizer.i.text('add_new_route')));
  }
}
