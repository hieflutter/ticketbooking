import 'package:flutter/material.dart';

enum SwiperPageRouteDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

class SwiperPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final SwiperPageRouteDirection direction;

  SwiperPageRoute({
    required this.builder,
    required this.direction,
  });

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(1.0, 0.0); // Default: left-to-right
    const end = Offset.zero;

    final curve = Curves.easeInOut;

    if (direction == SwiperPageRouteDirection.rightToLeft) {
      return SlideTransition(
        position: Tween(begin: -begin, end: -end)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: child,
      );
    } else if (direction == SwiperPageRouteDirection.topToBottom) {
      return SlideTransition(
        position: Tween(begin: Offset(0.0, -1.0), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: child,
      );
    } else if (direction == SwiperPageRouteDirection.bottomToTop) {
      return SlideTransition(
        position: Tween(begin: Offset(0.0, 1.0), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: child,
      );
    } else {
      return SlideTransition(
        position: Tween(begin: begin, end: end)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: child,
      );
    }
  }
}
