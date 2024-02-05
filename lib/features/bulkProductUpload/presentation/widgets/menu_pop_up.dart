import 'package:flutter/material.dart';

/// this is a custom widget that displays a menu
///  with the supplied [menuChildren]
/// using the [MenuAnchor] widget
class CustomMenuPopUp extends StatelessWidget {
  /// constructor for [CustomMenuPopUp]
  const CustomMenuPopUp({
    required this.menuChildren,
    required this.title,
    required this.icon,
    required this.label,
    super.key,
  });

  /// the children of the [CustomMenuPopUp]
  final List<Widget> menuChildren;

  ///   label for the [CustomMenuPopUp] container
  final String title;

  /// label of the [CustomMenuPopUp] button
  final String label;

  /// the icon for the [CustomMenuPopUp] button
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MenuAnchor(
        alignmentOffset: const Offset(0, 5),
        style: const MenuStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.all(12),
          ),
          elevation: MaterialStatePropertyAll<double>(5),
        ),
        menuChildren: menuChildren,
        builder: (context, controller, child) {
          return OutlinedButton.icon(
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            label: Text(
              label.toUpperCase(),
              style: const TextStyle(fontSize: 10),
            ),
            icon: Icon(
              icon,
              size: 22,
            ),
          );
        },
      ),
    );
  }
}
