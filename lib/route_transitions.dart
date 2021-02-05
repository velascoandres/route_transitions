library route_transitions;

import 'package:flutter/material.dart';

const DEFAULT_DURATION = Duration(milliseconds: 200);

enum AnimationType {
  normal,
  fadeIn,
}

class RouteTransitions {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final bool replacement;

  RouteTransitions({
    @required this.context,
    @required this.child,
    this.animation = AnimationType.normal,
    this.duration = DEFAULT_DURATION,
    this.replacement = false,
  }) {
    switch (this.animation) {
      case AnimationType.fadeIn:
        this._fadeInTransition(
          duration: this.duration,
        );
        break;

      case AnimationType.normal:
        this._normalTransition();
        break;
      default:
    }
  }

  void _normalTransition() {
    final route = MaterialPageRoute(builder: (_) => this.child);
    this._pushPage(route);
  }

  void _fadeInTransition({
    Duration duration = DEFAULT_DURATION,
  }) {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => this.child,
      transitionDuration: duration,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          child: child,
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(curve: Curves.easeOut, parent: animation)),
        );
      },
    );

    this._pushPage(route);
  }

  void _pushPage(PageRoute route) {
    if (this.replacement) {
      Navigator.pushReplacement(context, route);
    } else {
      Navigator.push(context, route);
    }
  }
}
