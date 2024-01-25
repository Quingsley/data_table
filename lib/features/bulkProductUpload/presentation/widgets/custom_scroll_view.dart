import 'package:flutter/widgets.dart';

///[CustomScroll] is a custom scroll view that scrolls both horizontally
/// and vertically.
class CustomScroll extends StatelessWidget {
  /// constructor call
  const CustomScroll({required this.child, super.key});

  ///[child] is the widget to be scrolled
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: child,
      ),
    );
  }
}
